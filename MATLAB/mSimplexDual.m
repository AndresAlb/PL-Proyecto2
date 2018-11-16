function [x0, z0, ban, iter, lambda0] = mSimplexDual(A, b, c, imprimirPasos) 

% Esta funcion realiza el Metodo Simplex Dual para problemas (duales)
% que tienen la siguiente forma:
%
%               minimizar   c'x 
%               sujeto a    Ax >= b , x >= 0 , c >= 0 
% 
% In :  A ... m x n matrix 
%       b ... column vector with as many rows as A 
%       c ... column vector with as many columns as A 
% 
% Out:  x0 ... SFB optima del problema 
%       z0 ... valor optimo del problema 
%       ban ... indica casos: 
%           -1 ... si el conjunto factible es vacio 
%           0 ... si se encontro una solucion optima 
%           1 ... si la funcion objectivo no es acotada. 
%       iter ... numero de iteraciones que hizo el metodo 
%       lambda0 ... Solucion del problema dual 

    format rat; % MATLAB imprime fracciones en vez de decimales
    
    ban = 0;
    iter = 0;
    [x0, z0, lambda0] = deal( [], [], [] );

    % 1 Definicion de las variables iniciales
    
    [m, n] = size(A); % m variables basicas
    [N, B, c, A] = deal( 1:n, (n+1):(m+n), [c' zeros(1,m)], [-A eye(m)] );
    [lambda, h] = deal( c(B), -b );
    rN = lambda*A(:, N) - c(N); 
    Id = eye(m); % matriz identidad
    
    % Revisamos si el problema es no acotado
    if any(c < 0)
        
        % Si c < 0, entonces el primal de este problema será
        % no-factible. 
        
        if imprimirPasos
            fprintf("\n\nConjunto factible vacio\n");
        end
        
        ban = -1;
        
    end
    
    if imprimirPasos
       imprimirTableau(A(:, B), A(:, N), c(B), rN, h, B, N, iter); 
    end
    
    % 2 Probamos la condicion de optimalidad
    while any(h < 0) && ban == 0
        
        % 2.1 Seleccionamos la variable de salida mediante
        % la Regla de Bland
        
        s = find(h < 0, 1);
        
        filaSalida = (Id(s, :)/A(:, B))*A(:, N);
        
        % 3 Probamos si el problema es acotado
        if any(filaSalida < 0)
            
            % 3.1 Seleccion de la variable de entrada mediante
            % la Regla de Bland
            
            % Buscamos los indices de los denominadores no-negativos
            noNegativos = filaSalida >= 0; 

            % Calculamos los cocientes y asignamos infinito a los
            % cocientes que tienen denominador mayor o igual a cero 
            cocientes = rN./filaSalida;
            cocientes(noNegativos) = inf;

            % s es el indice que corresponde al minimo de cocientes
            [~,e] = min(cocientes);
            
            if imprimirPasos
                fprintf(['La variable de entrada es X%d y la '... 
                    'variable de salida es X%d\n'],[N(e), B(s)]);
            end
            
            % 4 Redefinimos los conjuntos B y N 
            [B(s), N(e)] = deal( N(e), B(s) );
            iter = iter + 1;
            
            % 4.1 Calculamos los nuevos costos relativos 
            lambda = A(:, B)'\c(B)';
            lambda = lambda';
            rN = lambda*A(:, N) - c(N);
            h = -A(:, B)\b;
            
            if imprimirPasos
                imprimirTableau(A(:, B), A(:, N), c(B), rN, h, B, N, iter);
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
        
        x0 = zeros(n + m, 1);
        x0(B) = h;
        lambda0 = -lambda';
        
        % Solo devolvemos los valores de las variables originales
        x0 = x0(1:n);
        
    end
    
    return;
  
end

function imprimirTableau(AB, AN, cB, rN, h, B, N, iter)

% Este metodo imprime el tableau asociado a la base B
% usando las matrices AB, AN y los vectores rN y h

    m = length(B);
    n = length(N);

    T = zeros(m+1,m+n+1);

    T(1:m, B) = eye(m);
    T(1:m, N) = AB\AN;
    T(1:m, m+n+1) = h;
    T(m+1, N) = rN;
    T(m+1, m+n+1) = cB*h;
    
    fprintf("\nVariables basicas:    ");
    disp(B);
    fprintf("Variables no-basicas: ");
    disp(N);
    fprintf("\nIteracion %d\n\n", iter);
    disp(T);

end