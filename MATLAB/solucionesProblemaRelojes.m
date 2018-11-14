
% Este script resuelve las preguntas del problema de los relojes
% usando la funcion mSimplexMax

% Declaramos el problema y resolvemos mostrando el tableau
A = [6 4; 8 4; 3 3]; b = [40; 40; 20]; c = [300; 200];
[x0, z0, ban, iter, sensinfo] = mSimplexMax(A, b, c, false)
sensinfo.lambda
sensinfo.gammas
sensinfo.betas

% P1
c = [375; 200];
[x0, z0, ~, ~, ~] = mSimplexMax(A, b, c, false)
c = [375; 175];
[x0, z0, ~, ~, ~] = mSimplexMax(A, b, c, false)

c = [300; 200];

% P2. Ya tenemos guardados los intervalos de sensibilidad para 
% el vector c de antes, asi que solo los imprimimos

% Reloj de pedestal
disp(sensinfo.gammas(1));

% Reloj de pared
disp(sensinfo.gammas(2));

% P3

% David
b = [45; 40; 20];
[x0, z0, ~, ~, ~] = mSimplexMax(A, b, c, false)

% Diana
b = [40; 45; 20];
[x0, z0, ~, ~, ~] = mSimplexMax(A, b, c, false)

% Lidia
b = [40; 40; 25];
[x0, z0, ~, ~, ~] = mSimplexMax(A, b, c, false)

% P4. David puede trabajar menos sin afectar la solucion optima.
% Ya tenemos guardados los intervalos de sensibilidad para b de
% antes, asi que solo los volvemos a imprimir 
sensinfo.betas(1, :)

b = [40; 40; 20];

% P5
for i = 35:2:45
    b(1) = i;
    [x0, z0, ~, ~, ~] = mSimplexMax(A, b, c, false);
    fprintf('\nHoras de disponibilidad de David: %d \n', i);
    fprintf('La solucion optima es x0 = (%s, %s)\n',... 
        strtrim(rats(x0(1))), strtrim(rats(x0(2))));
    fprintf('La ganancia optima es %s\n', strtrim(rats(z0)));
end

b = [40; 40; 20];

% P6
for i = 35:2:45
    b(2) = i;
    [x0, z0, ~, ~, ~] = mSimplexMax(A, b, c, false);
    fprintf('\nHoras de disponibilidad de Diana: %d \n', i);
    fprintf('La solucion optima es x0 = (%s, %s)\n',... 
        strtrim(rats(x0(1))), strtrim(rats(x0(2))));
    fprintf('La ganancia optima es %s\n', strtrim(rats(z0)));
end

b = [40; 40; 20];

% P7
for i = 15:2:25
    b(3) = i;
    [x0, z0, ~, ~, ~] = mSimplexMax(A, b, c, false);
    fprintf('\nHoras de disponibilidad de Lidia: %d \n', i);
    fprintf('La solucion optima es x0 = (%s, %s)\n',... 
        strtrim(rats(x0(1))), strtrim(rats(x0(2))));
    fprintf('La ganancia optima es %s\n', strtrim(rats(z0)));
end

b = [40; 40; 20];

% P8. Si es valido utilizar los precios sombra si solo cambian las
% horas de disponibilidad de Lidia. Lo demostramos a continuacion

% Precio sombra de Lidia y cambio en las ganancias por el aumento
% en sus horas de disponibilidad semanal
sensinfo.lambda(3)
sensinfo.lambda(3)*5

% Ganancias cuando Lidia trabaja hasta 20 horas semanales
[~, z_20, ~, ~, ~] = mSimplexMax(A, b, c, false);
z_20

% Ganancias cuando Lidia trabaja hasta 25 horas semanales
b(3) = 25;
[~, z_25, ~, ~, ~] = mSimplexMax(A, b, c, false);
z_25

% Cambio en las ganancias
z_25 - z_20

% No es valido utilizar los precios sombra si cambian las horas
% de disponibilidad de ambos porque cambian la solucion optima
[x0, z0, ~, ~, ~] = mSimplexMax(A, b, c, false);













