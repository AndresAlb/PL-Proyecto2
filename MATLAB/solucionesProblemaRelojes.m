
% Este script resuelve las preguntas del problema de los relojes
% usando la funcion mSimplexMax

% Declaramos el problema y resolvemos mostrando el tableau
A = [6 4; 8 4; 3 3]; b = [40; 40; 20]; c = [300; 200];
[x0, z0, ban, iter, sensinfo] = mSimplexMax(A, b, c, true)
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
disp(sensinfo.betas(1))

b = [40; 40; 20];

% P5
for i = 35:2:45
    b(1) = i;
    [x0, z0, ~, ~, ~] = mSimplexMax(A, b, c, false);
    fprintf('\nHoras de disponibilidad de David: %d \n', i);
    fprintf('La solucion optima es %d\n', x0);
    fprintf('La ganancia optima es %\n', z0);
end

% P6
for i = 35:2:45
    b(2) = i;
    [x0, z0, ~, ~, ~] = mSimplexMax(A, b, c, false);
    fprintf('\nHoras de disponibilidad de Diana: %d \n', i);
    fprintf('La solucion optima es %d\n', x0);
    fprintf('La ganancia optima es %\n', z0);
end

% P7
for i = 15:2:25
    b(1) = i;
    [x0, z0, ~, ~, ~] = mSimplexMax(A, b, c, false);
    fprintf('\nHoras de disponibilidad de Lidia: %d \n', i);
    fprintf('La solucion optima es %d\n', x0);
    fprintf('La ganancia optima es %\n', z0);
end

% P8. Si es valido utilizar los precios sombra. Lo demostramos
% a continuacion
fprintf('El precio sombra de Lidia es %d', sensinfo.lambda(3));
fprintf(['El efecto sobre la ganancia del aumento en las horas ',... 
    'de disponibilidad de Lidia es %d'], sensinfo.lambda(3)*5);









