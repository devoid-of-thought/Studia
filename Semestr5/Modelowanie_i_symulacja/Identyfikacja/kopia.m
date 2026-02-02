clear; close all; clc;
%% --- 1. Parametry Modelu ---
TzewN = -20; TwewN = 20; TpN = 15;
PgN = 10000; FpN = 0.01;
cpp = 1000; rop = 1.2; Vw = 250; Vp = 0.25 * Vw;
% Identyfikacja współczynników
K1 = (0.6*PgN)/(TwewN-TzewN);
Kp = (PgN - K1*(TwewN-TzewN) - cpp*rop*FpN*(TwewN-TzewN))/(TwewN-TpN);
Kd = (Kp*(TwewN-TpN))/(TpN-TzewN);
Cvp = cpp*rop*Vp; Cvw = cpp*rop*Vw;
%% --- 2. Symulacja skoku jednostkowego ---
czas = 20000;
t_skok = 3000;     
dPg_val = 2000; % Skok mocy
% Warunki początkowe (stan równowagi)
Pg0 = PgN; Tzew0 = TzewN; Fp0 = FpN;
Cv_vent = cpp*rop*Fp0;
Mian = K1 + Kp + Cv_vent - (Kp^2)/(Kp+Kd);
Twew0 = (Pg0 + Tzew0*(K1 + Cv_vent + (Kp*Kd)/(Kp+Kd))) / Mian;
Tp0 = (Kp*Twew0 + Kd*Tzew0)/(Kp+Kd);
% Ustawienie wymuszenia dla Simulinka
dTzew0 = 0;
dPg0 = dPg_val;
% Symulacja obiektu (Simulink)
out = sim("Mis1.slx", czas);
%% ==========================================================
%% CZĘŚĆ A: IDENTYFIKACJA Tp / Pg (Poddasze)
%% ==========================================================
t_vec = out.tout;
y_vec = out.Tp - Tp0;
u_val = dPg0;        
% Punkt przegięcia
dt = gradient(t_vec);
dy = gradient(y_vec);
dy_dt = dy ./ dt;
[max_slope, idx_max] = max(dy_dt);
t_inflex = t_vec(idx_max);
y_inflex = y_vec(idx_max);
y_ust = mean(y_vec(end-100:end));
% Parametry FOTD dla Tp
k_p = y_ust / u_val;
a_p = max_slope;
b_p = y_inflex - a_p * t_inflex;
t_przeciecia_zera = -b_p / a_p;
T0_p = t_przeciecia_zera - t_skok;
if T0_p < 0, T0_p = 0; end
t_przeciecia_ust = (y_ust - b_p) / a_p;
T_p = t_przeciecia_ust - t_przeciecia_zera;
fprintf('--- WYNIKI DLA Tp/Pg ---\n');
fprintf('k  = %.6f [K/W]\n', k_p);
fprintf('T  = %.2f [s]\n', T_p);
fprintf('T0 = %.2f [s]\n\n', T0_p);
% Model weryfikacyjny dla Tp
t_mod = 0:10:(czas - t_skok);
y_mod_p = zeros(size(t_mod));
for i = 1:length(t_mod)
   tl = t_mod(i);
   if tl < T0_p, y_mod_p(i)=0; else, y_mod_p(i) = k_p*u_val*(1 - exp(-(tl-T0_p)/T_p)); end
end
t_plot_p = t_mod + t_skok;
% --- Rysowanie Tp ---
% Wykres 1: Konstrukcja Tp
f1 = figure(10); hold on; grid on;
plot(out.tout, y_vec, 'b', 'LineWidth', 2);
plot(t_vec, a_p * t_vec + b_p, 'k', 'LineWidth', 1);
yline(y_ust, 'g--', 'LineWidth', 1.5);
text(t_skok, y_ust*0.1, ['Skok Pg = ' num2str(dPg_val) ' W'], 'BackgroundColor', 'w', 'EdgeColor', 'k');
ylim([-1 y_ust*1.2]); xlim([0 czas]);
title('Konstrukcja stycznej (Tp / Pg)'); xlabel('Czas [s]'); ylabel('\Delta Tp [°C]');
saveas(f1, 'Wykres_Ident_Tp_Konstr.png');
% Wykres 2: Weryfikacja Tp
f2 = figure(11); hold on; grid on;
plot(out.tout, y_vec, 'b', 'LineWidth', 2.5, 'DisplayName', 'Obiekt');
plot(t_plot_p, y_mod_p, 'r', 'LineWidth', 2, 'DisplayName', 'Model FOTD');
title(['Weryfikacja Tp: k=' num2str(k_p,'%.4f') ', T=' num2str(T_p,'%.0f') ', T0=' num2str(T0_p,'%.0f')]);
xlabel('Czas [s]'); ylabel('\Delta Tp [°C]'); legend('Location', 'SouthEast');
saveas(f2, 'Weryfikacja_Tp.png');
%% ==========================================================
%% CZĘŚĆ B: IDENTYFIKACJA Twew / Pg (Parter)
%% ==========================================================
y_vec_w = out.Twew - Twew0; % Analizujemy Twew
% Punkt przegięcia
dy_w = gradient(y_vec_w);
dy_dt_w = dy_w ./ dt;
[max_slope_w, idx_max_w] = max(dy_dt_w);
t_inflex_w = t_vec(idx_max_w);
y_inflex_w = y_vec_w(idx_max_w);
y_ust_w = mean(y_vec_w(end-100:end));
% Parametry FOTD dla Twew
k_w = y_ust_w / u_val;
a_w = max_slope_w;
b_w = y_inflex_w - a_w * t_inflex_w;
t_przeciecia_zera_w = -b_w / a_w;
T0_w = t_przeciecia_zera_w - t_skok;
if T0_w < 0, T0_w = 0; end
t_przeciecia_ust_w = (y_ust_w - b_w) / a_w;
T_w = t_przeciecia_ust_w - t_przeciecia_zera_w;
fprintf('--- WYNIKI DLA Twew/Pg ---\n');
fprintf('k  = %.6f [K/W]\n', k_w);
fprintf('T  = %.2f [s]\n', T_w);
fprintf('T0 = %.2f [s]\n', T0_w);
% Model weryfikacyjny dla Twew
y_mod_w = zeros(size(t_mod));
for i = 1:length(t_mod)
   tl = t_mod(i);
   if tl < T0_w, y_mod_w(i)=0; else, y_mod_w(i) = k_w*u_val*(1 - exp(-(tl-T0_w)/T_w)); end
end
t_plot_w = t_mod + t_skok;
% --- Rysowanie Twew ---
% Wykres 3: Konstrukcja Twew
f3 = figure(12); hold on; grid on;
plot(out.tout, y_vec_w, 'b', 'LineWidth', 2, 'DisplayName', 'Obiekt Twew');
plot(t_vec, a_w * t_vec + b_w, 'k', 'LineWidth', 1, 'DisplayName', 'Styczna');
yline(y_ust_w, 'g--', 'LineWidth', 1.5, 'DisplayName', 'Stan ustalony');
% ZAZNACZENIE RODZAJU SKOKU (Tekst na wykresie)
text(t_skok + 1000, y_ust_w*0.5, ...
   ['\leftarrow Wymuszenie: Skok Pg = ' num2str(dPg_val) ' W'], ...
   'BackgroundColor', 'white', 'EdgeColor', 'black', 'FontSize', 10);
ylim([-0.5 y_ust_w*1.2]); xlim([0 czas]);
title('Konstrukcja stycznej (Twew / Pg)');
xlabel('Czas [s]'); ylabel('\Delta Twew [°C]');
legend('Location', 'SouthEast');
saveas(f3, 'Wykres_Ident_Twew_Konstr.png');
% Wykres 4: Weryfikacja Twew
f4 = figure(13); hold on; grid on;
plot(out.tout, y_vec_w, 'b', 'LineWidth', 2.5, 'DisplayName', 'Obiekt Rzeczywisty');
plot(t_plot_w, y_mod_w, 'r', 'LineWidth', 2, 'DisplayName', 'Model FOTD');
% Dodatkowy podpis
text(t_skok + 1000, y_ust_w*0.2, ...
    ['Skok Pg = ' num2str(dPg_val) ' W'], ...
    'FontSize', 8, 'Color', [0.3 0.3 0.3]);
title(['Weryfikacja Twew: k=' num2str(k_w,'%.4f') ', T=' num2str(T_w,'%.0f') ', T0=' num2str(T0_w,'%.0f')]);
xlabel('Czas [s]'); ylabel('\Delta Twew [°C]');
legend('Location', 'SouthEast');
saveas(f4, 'Weryfikacja_Twew.png');
