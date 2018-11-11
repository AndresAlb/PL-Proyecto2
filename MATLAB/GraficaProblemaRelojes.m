% Este script grafica el conjunto factible del problema de los relojes

x = 0:0.5:12;
R1 = 10 - (6/4)*x;
R2 = 10 - 2*x;
R3 = 20/3 - x;
Z = [3; 2];

hold on
axis square;
axis([0 10.5 0 10.5]);

% Coloreamos el area factible
A1 = area(x', R2', 'LineStyle', 'none');
A2 = area(x', R3', 'LineStyle', 'none');
A1.FaceColor = [0.8, 0.8, 0.8];
A2.FaceColor = [0.8, 0.8, 0.8];

% Dibujamos las rectas de las restricciones
pR1 = plot(x, R1, 'color', 'r', 'linestyle', '--', 'linewidth', 5);
pR2 = plot(x, R2, 'color', '[0, 0.4470, 0.7410]', 'LineWidth', 5);
pR3 = plot(x, R3, 'color', '[0.4660, 0.6740, 0.1880]', 'LineWidth', 5);

% Ajustes de los ejes
grid on;
xlabel('$x_1$', 'Interpreter', 'latex', 'Fontsize', 20);
ylabel('$x_2$', 'Interpreter', 'latex', 'Fontsize', 20);
set(gca,'FontSize', 20)
[LEGH,OBJH,OUTH,OUTM] = legend([pR1, pR2, pR3],...
    {'R_1: 6x_1 + 4x_2 \leq 40','R_2: 8x_1 + 4x_2 \leq 40',... 
    'R_3: 3x_1 + 3x_2 \leq 20'});

% Dibujamos vectores normales
vectorNormalZ = arrow([0 0], [3 2], 'Width', 1, ... 
    'NormalDir', [3,2]);
vR2 = arrow([0 0], [4 2], 'Width', 1);
vR3 = arrow([0 0], [10/3 10/3], 'Width', 1);
set(vR2, 'Edgecolor', '[0, 0.4470, 0.7410]',...
    'FaceColor', '[0, 0.4470, 0.7410]');
set(vR3, 'Edgecolor', '[0.4660, 0.6740, 0.1880]',...
    'FaceColor', '[0.4660, 0.6740, 0.1880]');
hold off

clearvars