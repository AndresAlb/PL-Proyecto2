% Este script grafica el conjunto factible del problema de los relojes

x = 0:0.5:12;
R1 = 10 - (6/4)*x;
R2 = 10 - 2*x;
R3 = 20/3 - x;
Z = [3; 2];

figure1 = figure;

axes1 = axes('Parent', figure1); 
hold(axes1,'on');
axis square;

% Coloreamos el area factible
A1 = area(x', R2', 'LineStyle', 'none');
A2 = area(x', R3', 'LineStyle', 'none');
A1.FaceColor = [0.8, 0.8, 0.8];
A2.FaceColor = [0.8, 0.8, 0.8];

% Dibujamos las rectas de las restricciones
pR1 = plot(x, R1, 'color', 'r', 'linestyle', '--', 'linewidth', 5,...
    'Parent', axes1);
pR2 = plot(x, R2, 'color', '[0, 0.4470, 0.7410]', 'LineWidth', 5,...
    'Parent', axes1);
pR3 = plot(x, R3, 'color', '[0.4660, 0.6740, 0.1880]', 'LineWidth', 5,...
    'Parent', axes1);

% Ajustes de los ejes
xlim(axes1,[0 10.5]);
ylim(axes1,[0 10.5]);
grid(axes1,'on');
axis(axes1,'square');
xlabel('$x_1$', 'Interpreter', 'latex');
ylabel('$x_2$', 'Interpreter', 'latex');
set(axes1,'FontSize',20);
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

% Agregamos anotaciones

% textbox
annotation(figure1,'textbox',...
    [0.413132756489831 0.193525284331669....
    0.0705451577801945 0.0836713995943199],...
    'String',{'Vector normal','a la restricción','R_2'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% textarrow
annotation(figure1,'textarrow',[0.389009802426333 0.413492927094668],...
    [0.447793338842508 0.29924650161464],...
    'String',{'Vector','normal a la','función objetivo'},...
    'HorizontalAlignment','left');

% textbox
annotation(figure1,'textbox',...
    [0.338323175842277 0.320775036076372...
    0.0664646354733408 0.107633892798424],...
    'String',{'Vector normal','a la restricción R_3'},...
    'LineStyle','none',...
    'FitBoxToText','off');

hold(axes1, 'off');
clearvars