function [x0, z0, ban, iter, sensinfo] = mSimplexMax(A, b, c, imprimirPasos) 

% Esta funcion realiza la Fase II del Metodo Simplex para problemas
% que tienen la siguiente forma
%
%               maximizar   c'x 
%               sujeto a    Ax <= b , x >= 0 , b >= 0 
% 
% In :  A ... mxn matrix 
%       b ... column vector with as many rows as A 
%       c ... column vector with as many entries as one row of A 
%       imprimirPasos ... boolean variable which indicates whether
%       or not to print the step-by-step solution of the given problem 
% 
% Out:  xo ..... SBF optima del problema 
%       zo ..... valor optimo del problema 
%       ban .... indica casos: 
%           -1 ... si el conjunto factible es vacio 
%           0 .... si se encontro una solucion optima 
%           1 .... si la funcion objectivo no es acotada. 
%       iter ... numero de iteraciones (cambios de variables basicas) 
%       que hizo el metodo
%       sensinfo ... Solo cuando ban = 0: 
%           sensinfo.lambda ... es la solucion dual 
%           sensinfo.gammas ... 2xn matrix con intervalos 
%           sensinfo.betas ... 2xm matrix con intervalos
    
    format rat; % MATLAB imprime fracciones en vez de decimales
    
    iter = 0;

    % 1 Definicion de las variables en estado 0 
    
    c = -c;
    [m, n] = size(A); % m variables basicas
    ban = 0;
    [N, B, c, A] = deal( 1:n, (n+1):(m+n), [c' zeros(1,m)], [A eye(m)] );
    [lambda, h] = deal( c(B), b );
    rN = lambda*A(:, N) - c(N); 
    
    % Si el conjunto factible es vacio, el Metodo Simplex no
    % tendra opcion mas que escoger un punto que no cumpla
    % la restriccion de no-negatividad.
    if any(b < 0)
        
        if imprimirPasos
            fprintf("\n\nConjunto factible vacio\n");
        end
        
        ban = -1;
        
    end
    
    if imprimirPasos
       imprimirTableau(A(:, N), c(B), rN, h, B, N, iter); 
    end
    
    % 2 Probamos la condicion de optimalidad
    while any(rN > 0) && ban == 0
        
        % 2.1 Seleccionamos la variable de entrada mediante
        % la Regla de Bland
        e = find(rN > 0, 1);
        
        % 3 Probamos si el problema es acotado
        if any(A(:, N(e)) > 0)
            
            % 3.1 Seleccion de la variable de salida mediante
            % la Regla de Bland

            % Buscamos los indices de los denominadores no-positivos
            noPositivos = A(:, N(e)) <= 0; 

            % Calculamos los cocientes y asignamos infinito a los
            % cocientes que tienen denominador menor o igual a cero 
            cocientes = h./A(:, N(e));
            cocientes(noPositivos) = inf;

            % s es el indice que corresponde al minimo de cocientes
            [~, s] = min(cocientes);
            
            if imprimirPasos
                fprintf(['La variable de entrada es X%d y la '... 
                    'variable de salida es X%d\n'],[N(e), B(s)]);
            end
            
            % 4 Redefinimos los conjuntos B y N 
            [B(s), N(e)] = deal( N(e), B(s) );
            [A(:, B), A(:, N), h] = deal( eye(m),...
                A(:, B)\A(:, N), A(:, B)\h );
            iter = iter + 1;
            
            % 4.1 Calculamos los nuevos costos relativos 
            lambda = A(:, B)'\c(B)';
            lambda = lambda';
            rN = lambda*A(:, N) - c(N);
            
            if imprimirPasos
                imprimirTableau(A(:, N), c(B), rN, h, B, N, iter);
            end
            
        else
            
            % El problema es no-acotado. 
            ban = 1;
            if imprimirPasos
                fprintf("\n\nProblema no-acotado\n");
            end
        
        end
        
    end
    
    if ban == 0
        x0 = zeros(m+n, 1);
        x0(B) = A(:,B)\h;
        z0 = -c*x0;
        
        % Solo devolvemos los valores de las variables originales
        x0 = x0(1:n); 
        
        % Analisis de sensibilidad
        sensinfo.lambda = lambda;
        sensinfo.gammas = [];
        sensinfo.betas = [];
    else
        [x0, z0, sensinfo] = deal( [], [], [] );
    end
    
    return;
  
end

function imprimirTableau(AN, cB, rN, h, B, N, iter)

% Este metodo imprime el tableau asociado a la base B
% usando las matrices AB, AN y los vectores rN y h

    m = length(B);
    n = length(N);

    T = zeros(m+1,m+n+1);

    T(1:m, B) = eye(m);
    T(1:m, N) = AN;
    T(1:m, m+n+1) = h;
    T(m+1, N) = rN;
    T(m+1, m+n+1) = cB*h;
    
    fprintf("\nVariables basicas:    ");
    disp(B);
    fprintf("Variables no-basicas: ");
    disp(N);
    fprintf("\nIteracion %d\n\n", iter);
    disp(T);

    return;

end