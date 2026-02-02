clear; clc; close all;

folderNazwa = 'modellogistycznywykresy';
if ~exist(folderNazwa, 'dir')
    mkdir(folderNazwa);
end
disp(['Wyniki zostaną zapisane w: ' folderNazwa]);

K_base = 100;
r_base = 0.5;
N0_base = 10;
alpha_base = 0;
t_stop = 40;

disp('Generuję Badanie 1: Warunki początkowe...');

N0_warianty = [10, 60, 140]; 
kolory = {'b', 'g', 'm'};    
styleLinii = {'-', '--', ':'}; 
grubosc = [1.5, 2.0, 2.5];     

fig1 = figure('Name', 'Badanie 1 - Warunki Poczatkowe', 'Color', 'white', 'Position', [100 100 1200 500]);

for i = 1:length(N0_warianty)
    N0 = N0_warianty(i);
    r = r_base; K = K_base; alpha = alpha_base; 
    
    out = sim('model_logistyczny', 'StopTime', num2str(t_stop));
    
    subplot(1, 2, 1); hold on;
    plot(out.tout, out.N_out, 'Color', kolory{i}, 'LineStyle', styleLinii{i}, 'LineWidth', grubosc(i), 'DisplayName', ['N_0 = ' num2str(N0)]);
    
    subplot(1, 2, 2); hold on;
    plot(out.N_out, out.dN_out, 'Color', kolory{i}, 'LineStyle', styleLinii{i}, 'LineWidth', grubosc(i), 'DisplayName', ['Start N_0=' num2str(N0)]);
    
    plot(out.N_out(1), out.dN_out(1), 'o', 'MarkerEdgeColor', kolory{i}, 'MarkerFaceColor', kolory{i}, 'MarkerSize', 6, 'HandleVisibility', 'off'); 
end

subplot(1, 2, 1);
yline(K_base, 'Color', [0.5 0.5 0.5], 'LineStyle', '-', 'LineWidth', 1, 'Label', 'Limit K');
title('Przebiegi czasowe N(t)'); xlabel('Czas'); ylabel('Populacja N'); 
grid on; legend('show', 'Location', 'southeast');
ylim([0 160]);

subplot(1, 2, 2);
yline(0, 'k-', 'HandleVisibility', 'off');
title('Portrety fazowe dN/dt(N)'); xlabel('Populacja N'); ylabel('Prędkość zmian'); 
grid on; legend('show', 'Location', 'south');

saveas(fig1, fullfile(folderNazwa, '1_Wplyw_Warunkow_Poczatkowych.png'));


disp('Generuję Badanie 2: Współczynnik r...');

r_warianty = [0.2, 0.5, 1.0]; 
kolory = {'b', 'k', 'r'};

fig2 = figure('Name', 'Badanie 2 - Wplyw parametru r', 'Color', 'white', 'Position', [150 150 1200 500]);

max_dN_seen = 0;

for i = 1:length(r_warianty)
    r = r_warianty(i);
    N0 = N0_base; K = K_base; alpha = alpha_base;
    
    out = sim('model_logistyczny', 'StopTime', num2str(t_stop));
    
    max_dN_seen = max(max_dN_seen, max(out.dN_out));
    
    subplot(1, 2, 1); hold on;
    plot(out.tout, out.N_out, 'Color', kolory{i}, 'LineWidth', 2, 'DisplayName', ['r = ' num2str(r)]);
    
    subplot(1, 2, 2); hold on;
    plot(out.N_out, out.dN_out, 'Color', kolory{i}, 'LineWidth', 2, 'DisplayName', ['r = ' num2str(r)]);
end

subplot(1, 2, 1);
yline(K_base, 'g--', 'Label', 'Limit K', 'HandleVisibility', 'off');
title('Dynamika wzrostu (Czas)'); xlabel('Czas'); ylabel('Populacja N'); 
grid on; legend show;
ylim([0, K_base * 1.15]);

subplot(1, 2, 2);
title('Szybkość zmian (Fazowy)'); xlabel('Populacja N'); ylabel('Prędkość zmian'); 
grid on; legend show;
ylim([0, max_dN_seen * 1.15]);

saveas(fig2, fullfile(folderNazwa, '2_Wplyw_Parametru_r.png'));


disp('Generuję Badanie 3: Migracje...');

alpha_warianty = [-4, 0, 5]; 
opisy = {'Odłów (-4)', 'Brak (0)', 'Imigracja (+5)'};
kolory = {'r', 'k', 'b'};

fig3 = figure('Name', 'Badanie 3 - Migracje', 'Color', 'white', 'Position', [200 200 1200 500]);

max_N_seen = K_base;

for i = 1:length(alpha_warianty)
    alpha = alpha_warianty(i);
    r = r_base; K = K_base; N0 = N0_base;
    
    out = sim('model_logistyczny', 'StopTime', num2str(t_stop));
    
    max_N_seen = max(max_N_seen, max(out.N_out));
    
    subplot(1, 2, 1); hold on;
    plot(out.tout, out.N_out, 'Color', kolory{i}, 'LineWidth', 2, 'DisplayName', opisy{i});
    
    subplot(1, 2, 2); hold on;
    plot(out.N_out, out.dN_out, 'Color', kolory{i}, 'LineWidth', 2, 'DisplayName', opisy{i});
end

subplot(1, 2, 1);
yline(K_base, 'm--', 'Label', 'Limit K', 'HandleVisibility', 'off');
yline(0, 'k-', 'HandleVisibility', 'off');
ylim([0, max_N_seen * 1.1]);
title('Wpływ migracji na liczebność'); xlabel('Czas'); ylabel('Populacja N'); 
grid on; legend show;

subplot(1, 2, 2);
yline(0, 'k-', 'HandleVisibility', 'off');
title('Portrety fazowe (Migracja)'); xlabel('Populacja N'); ylabel('Prędkość zmian'); 
grid on; legend show;

saveas(fig3, fullfile(folderNazwa, '3_Wplyw_Migracji.png'));

disp('--- ZAKOŃCZONO SUKCESEM ---');