
% Este script resuelve las preguntas de las actividades 1 y 3 del 
% proyecto usando las funciones mSimplexMax y mSimplexDual

fprintf('\n\nActividad 1\n\n')

% Declaramos el problema y resolvemos mostrando el tableau
A = [6 4; 8 4; 3 3]; b = [40; 40; 20]; c = [300; 200];
[x0, z0, ban, iter, sensinfo] = mSimplexMax(A, b, c, false)
fprintf("\nsensinfo.lambda =\n\n");
disp(sensinfo.lambda);
fprintf("\nsensinfo.gammas =\n\n");
disp(sensinfo.gammas);
fprintf("\nsensinfo.betas =\n\n");
disp(sensinfo.betas);

% P1
fprintf("\n\nPregunta 1\n");
c = [375; 200]
[x0, z0, ~, ~, ~] = mSimplexMax(A, b, c, false)
c = [375; 175]
[x0, z0, ~, ~, ~] = mSimplexMax(A, b, c, false)

c = [300; 200];

% P2. Ya tenemos guardados los intervalos de sensibilidad para 
% el vector c de antes, asi que solo los imprimimos
fprintf("\n\nPregunta 2\n");

% Reloj de pedestal
fprintf(['\nEl intervalo de sensibilidad ',... 
    'para relojes de pedestal es [%s , %s].\n'],...
    strtrim(rats(sensinfo.gammas(1, 1))),...
    strtrim(rats(sensinfo.gammas(1, 2))));
% Reloj de pared
fprintf(['\nEl intervalo de sensibilidad ',... 
    'para relojes de pared es [%s, %s]\n'],...
    strtrim(rats(sensinfo.gammas(2, 1))),... 
    strtrim(rats(sensinfo.gammas(2, 2))));

% P3
fprintf("\n\nPregunta 3\n");

% David
b = [45; 40; 20]
[x0, z0, ~, ~, ~] = mSimplexMax(A, b, c, false)

% Diana
b = [40; 45; 20]
[x0, z0, ~, ~, ~] = mSimplexMax(A, b, c, false)

% Lidia
b = [40; 40; 25]
[x0, z0, ~, ~, ~] = mSimplexMax(A, b, c, false)

% P4. David puede trabajar menos sin afectar la solucion optima.
% Ya tenemos guardados los intervalos de sensibilidad para b de
% antes, asi que solo los volvemos a imprimir 
fprintf("\n\nPregunta 4\n");

fprintf(['\nEl intervalo de sensibilidad de las horas de ',... 
    'David es [%s, %s).\n'],...
    strtrim(rats(sensinfo.betas(1, 1))),... 
    strtrim(rats(sensinfo.betas(1, 2))));

b = [40; 40; 20];

% P5
fprintf("\n\nPregunta 5\n");

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
fprintf("\n\nPregunta 6\n");

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
fprintf("\n\nPregunta 7\n");

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
fprintf("\n\nPregunta 8\n");

% Precio sombra de Lidia y cambio en las ganancias por el aumento
% en sus horas de disponibilidad semanal
fprintf('\nEl precio sombra de Lidia es %s.\n',...
    strtrim(rats(sensinfo.lambda(3))));
fprintf('\n(Precio sombra de Lidia)*5 = %s.\n',...
    strtrim(rats(sensinfo.lambda(3)*5)));

% Ganancias cuando Lidia trabaja hasta 20 horas semanales
[~, z_20, ~, ~, ~] = mSimplexMax(A, b, c, false)

% Ganancias cuando Lidia trabaja hasta 25 horas semanales
b(3) = 25;
[~, z_25, ~, ~, ~] = mSimplexMax(A, b, c, false)

% Cambio en las ganancias totales optimas
fprintf(['\nEl cambio en la ganancia total es',...
    ' z_25 - z_20 = %s.\n'], strtrim(rats(z_25 - z_20)));

% No es valido utilizar los precios sombra si cambian las horas
% de disponibilidad de ambos porque altera la solucion optima

% Precios sombra de David y Lidia 
fprintf('\nEl precio sombra de David es %s.\n',...
    strtrim(rats(sensinfo.lambda(1))));
fprintf('\nEl precio sombra de Lidia es %s.\n',...
    strtrim(rats(sensinfo.lambda(3))));

% Como el precio sombra de David es cero, la multiplicacion
% del cambio de horas y sus precios sombra es igual a 
% la multiplicacion del precio sombra de Lidia por su 
% cambio de horas
fprintf(['\nLa multiplicación de los precios sombra de David ', ...
    'y de Lidia \npor el cambio en sus horas es igual a %s.\n'],...
    strtrim(rats(sensinfo.lambda(3)*5)));

% Ganancias con b = [40, 40, 20]
[~, z0, ~, ~, ~] = mSimplexMax(A, b, c, false)

% Ganancias despues del cambio en las horas de David y Lidia
b(1) = b(1) - 5; b(3) = b(3) + 5;
[~, z1, ~, ~, ~] = mSimplexMax(A, b, c, false)

% Cambio en las ganancias totales optimas
fprintf(['\nEl cambio en la ganancia total es',...
    ' z1 - z0 = %s.\n\n'], strtrim(rats(z1 - z0)));

fprintf('\nActividad 3\n\n');

A = [6 8 3; 4 4 3]; b = [300; 200]; c = [40; 40; 20]; 
[x0, z0, ban, iter, lambda0] = mSimplexDual(A, b, c, false)
