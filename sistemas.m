%se Define el vector de tiempo correspondiente a un ciclo de 24 horas.
horas = 1:24;

%Se inicializa un vector de 24 posiciones en ceros.
% Según los requerimientos, la producción es 0 en horas nocturnas (1-5 y 19-24)
P_solar = zeros(1, 24);

% Se crea una curva ascendente para el día (horas 6 a 18).
% Se utiliza una función senoidal para simular la curva, alcanzando el pico de 25 kW al mediodía (hora 12).
P_solar(6:18) = 25 * sin(pi * (horas(6:18) - 6) / (18 - 6));

%% b. Generación Eólica (Aerogeneradores)
% La energía eólica fluctúa de forma irregular durante las 24 horas
% Se utiliza la función 'rand' para generar valores aleatorios que no
% superen P_max_eolica =15 kw
P_eolica = 15 * rand(1, 24);

%% c. Generación Híbrida Total
% Se suma matemáticamente el vector solar y el eólico
P_total = P_solar + P_eolica;

%% d. Demanda de la Comunidad
% Se inicializa el vector de demanda.
P_demanda = zeros(1, 24);

% Consumo Mínimo (Horas 1 a 5 y 22 a 24): Oscila entre 2 kW y 4 kW
P_demanda([1:5, 22:24]) = 2 + (4-2) * rand(1, 8);

% Consumo Diurno (Horas 6 a 17): Incrementos moderados oscilando entre 6 kW y 10 kW
P_demanda(6:17) = 6 + (10-6) * rand(1, 12);

% Pico Máximo de Demanda (Horas 18 a 21): Potencia máxima de diseño de 15 kW
P_demanda(18:21) = 15;

%% e. Visualización Gráfica
% Se utiliza el comando plot para graficar en una misma ventana
figure; % Abre una nueva ventana de figura
plot(horas, P_total, 'b-o', 'LineWidth', 1.5, 'MarkerFaceColor', 'b'); 
hold on; % Mantiene la gráfica actual para superponer la siguiente curva
plot(horas, P_demanda, 'r-s', 'LineWidth', 1.5, 'MarkerFaceColor', 'r');

% Añadir etiquetas, título y cuadrícula
title('Simulación del Balance Energético de la Micro-red (Generación vs Demanda)');
xlabel('Tiempo en horas');
ylabel('Potencia en Kilovatios (kW)');
grid on; 

% Leyenda para identificar cada curva
legend('Generación Total', 'Demanda de la Comunidad', 'Location', 'best');
hold off;