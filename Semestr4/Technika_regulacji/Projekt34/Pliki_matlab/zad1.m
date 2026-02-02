clear; clc; close all;
sdt1_ID = "280082";
sdt2_ID = "280141";
A = str2double(extract(sdt1_ID,6));
B = str2double(extract(sdt2_ID,6));
C= A+B;
k_max = 25;
k_vec = 0:k_max;
u_step = ones(1, k_max + 1);
u_impulse = zeros(1, k_max + 1);
u_impulse(1) = 1;

Wp1 = 0;
Wp2 = 5;

Wp12 = [0, 0];
Wp22 = [4, 7];

figure(1);
sgtitle('System I - Odpowiedź na skok jednostkowy', 'FontWeight', 'bold');

subplot(2, 1, 1);
y_k1 = Wp1; u_k1 = 0; u_k2 = 0;
y_results = zeros(1, k_max + 1);
for i = 1:(k_max + 1)
    u_k = u_step(i);
    y_k = -y_k1 + 2*u_k + 5*u_k1 - 3*u_k2;
    y_results(i) = y_k;
    y_k1 = y_k; u_k2 = u_k1; u_k1 = u_k;
end
stem(k_vec, y_results, 'b', 'filled', 'DisplayName', 'Odpowiedź y[k]');
hold on;
stem(k_vec, u_step, 'k:', 'LineWidth', 1.5, 'DisplayName', 'Pobudzenie u[k]');
hold off;
title(['Warunki początkowe: ', num2str(Wp1)]);
grid on; xlabel('k'); ylabel('y[k]'); axis tight; legend('show');

subplot(2, 1, 2);
y_k1 = Wp2; u_k1 = 0; u_k2 = 0;
y_results = zeros(1, k_max + 1);
for i = 1:(k_max + 1)
    u_k = u_step(i);
    y_k = -y_k1 + 2*u_k + 5*u_k1 - 3*u_k2;
    y_results(i) = y_k;
    y_k1 = y_k; u_k2 = u_k1; u_k1 = u_k;
end
stem(k_vec, y_results, 'b', 'filled', 'DisplayName', 'Odpowiedź y[k]');
hold on;
stem(k_vec, u_step, 'k:', 'LineWidth', 1.5, 'DisplayName', 'Pobudzenie u[k]');
hold off;
title(['Warunki początkowe: ', num2str(Wp2)]);
grid on; xlabel('k'); ylabel('y[k]'); axis tight; legend('show');

figure(2);
sgtitle('System I - Odpowiedź impulsowa', 'FontWeight', 'bold');

subplot(2, 1, 1);
y_k1 = Wp1; u_k1 = 0; u_k2 = 0;
y_results = zeros(1, k_max + 1);
for i = 1:(k_max + 1)
    u_k = u_impulse(i);
    y_k = -y_k1 + 2*u_k + 5*u_k1 - 3*u_k2;
    y_results(i) = y_k;
    y_k1 = y_k; u_k2 = u_k1; u_k1 = u_k;
end
stem(k_vec, y_results, 'b', 'filled', 'DisplayName', 'Odpowiedź y[k]');
hold on;
stem(k_vec, u_impulse, 'k:', 'LineWidth', 1.5, 'DisplayName', 'Pobudzenie u[k]');
hold off;
title(['Warunki początkowe: ', num2str(Wp1)]);
grid on; xlabel('k'); ylabel('y[k]'); axis tight; legend('show');

subplot(2, 1, 2);
y_k1 = Wp2; u_k1 = 0; u_k2 = 0;
y_results = zeros(1, k_max + 1);
for i = 1:(k_max + 1)
    u_k = u_impulse(i);
    y_k = -y_k1 + 2*u_k + 5*u_k1 - 3*u_k2;
    y_results(i) = y_k;
    y_k1 = y_k; u_k2 = u_k1; u_k1 = u_k;
end
stem(k_vec, y_results, 'b', 'filled', 'DisplayName', 'Odpowiedź y[k]');
hold on;
stem(k_vec, u_impulse, 'k:', 'LineWidth', 1.5, 'DisplayName', 'Pobudzenie u[k]');
hold off;
title(['Warunki początkowe: ', num2str(Wp2)]);
grid on; xlabel('k'); ylabel('y[k]'); axis tight; legend('show');

figure(3);
sgtitle('System II - Odpowiedź na skok jednostkowy', 'FontWeight', 'bold');

subplot(2, 1, 1);
y_k1 = Wp1;
y_results = zeros(1, k_max + 1);
for i = 1:(k_max + 1)
    y_k = -0.5 * y_k1 + 0.5 * u_step(i);
    y_results(i) = y_k;
    y_k1 = y_k;
end
stem(k_vec, y_results, 'b', 'filled', 'DisplayName', 'Odpowiedź y[k]');
hold on;
stem(k_vec, u_step, 'k:', 'LineWidth', 1.5, 'DisplayName', 'Pobudzenie u[k]');
hold off;
title(['Warunki początkowe: ', num2str(Wp1)]);
grid on; xlabel('k'); ylabel('y[k]'); axis tight; legend('show');

subplot(2, 1, 2);
y_k1 = Wp2;
y_results = zeros(1, k_max + 1);
for i = 1:(k_max + 1)
    y_k = -0.5 * y_k1 + 0.5 * u_step(i);
    y_results(i) = y_k;
    y_k1 = y_k;
end
stem(k_vec, y_results, 'b', 'filled', 'DisplayName', 'Odpowiedź y[k]');
hold on;
stem(k_vec, u_step, 'k:', 'LineWidth', 1.5, 'DisplayName', 'Pobudzenie u[k]');
hold off;
title(['Warunki początkowe: ', num2str(Wp2)]);
grid on; xlabel('k'); ylabel('y[k]'); axis tight; legend('show');

figure(4);
sgtitle('System II - Odpowiedź impulsowa', 'FontWeight', 'bold');

subplot(2, 1, 1);
y_k1 = Wp1;
y_results = zeros(1, k_max + 1);
for i = 1:(k_max + 1)
    y_k = -0.5 * y_k1 + 0.5 * u_impulse(i);
    y_results(i) = y_k;
    y_k1 = y_k;
end
stem(k_vec, y_results, 'b', 'filled', 'DisplayName', 'Odpowiedź y[k]');
hold on;
stem(k_vec, u_impulse, 'k:', 'LineWidth', 1.5, 'DisplayName', 'Pobudzenie u[k]');
hold off;
title(['Warunki początkowe: ', num2str(Wp1)]);
grid on; xlabel('k'); ylabel('y[k]'); axis tight; legend('show');

subplot(2, 1, 2);
y_k1 = Wp2;
y_results = zeros(1, k_max + 1);
for i = 1:(k_max + 1)
    y_k = -0.5 * y_k1 + 0.5 * u_impulse(i);
    y_results(i) = y_k;
    y_k1 = y_k;
end
stem(k_vec, y_results, 'b', 'filled', 'DisplayName', 'Odpowiedź y[k]');
hold on;
stem(k_vec, u_impulse, 'k:', 'LineWidth', 1.5, 'DisplayName', 'Pobudzenie u[k]');
hold off;
title(['Warunki początkowe: ', num2str(Wp2)]);
grid on; xlabel('k'); ylabel('y[k]'); axis tight; legend('show');

figure(5);
sgtitle('System III - Odpowiedź na skok jednostkowy', 'FontWeight', 'bold');

subplot(2, 1, 1);
y_k1 = Wp12(1); y_k2 = Wp12(2);
u_k1 = 0; u_k2 = 0; u_k3 = 0;
y_results = zeros(1, k_max + 1);
for i = 1:(k_max + 1)
    u_k = u_step(i);
    y_k = y_k1 - y_k2 + u_k + u_k1 - 3*u_k3;
    y_results(i) = y_k;
    y_k2 = y_k1; y_k1 = y_k;
    u_k3 = u_k2; u_k2 = u_k1; u_k1 = u_k;
end
stem(k_vec, y_results, 'b', 'filled', 'DisplayName', 'Odpowiedź y[k]');
hold on;
stem(k_vec, u_step, 'k:', 'LineWidth', 1.5, 'DisplayName', 'Pobudzenie u[k]');
hold off;
title(['Warunki początkowe: [', num2str(Wp12(1)), ', ', num2str(Wp12(2)), ']']);
grid on; xlabel('k'); ylabel('y[k]'); axis tight; legend('show');

subplot(2, 1, 2);
y_k1 = Wp22(1); y_k2 = Wp22(2);
u_k1 = 0; u_k2 = 0; u_k3 = 0;
y_results = zeros(1, k_max + 1);
for i = 1:(k_max + 1)
    u_k = u_step(i);
    y_k = y_k1 - y_k2 + u_k + u_k1 - 3*u_k3;
    y_results(i) = y_k;
    y_k2 = y_k1; y_k1 = y_k;
    u_k3 = u_k2; u_k2 = u_k1; u_k1 = u_k;
end
stem(k_vec, y_results, 'b', 'filled', 'DisplayName', 'Odpowiedź y[k]');
hold on;
stem(k_vec, u_step, 'k:', 'LineWidth', 1.5, 'DisplayName', 'Pobudzenie u[k]');
hold off;
title(['Warunki początkowe: [', num2str(Wp22(1)), ', ', num2str(Wp22(2)), ']']);
grid on; xlabel('k'); ylabel('y[k]'); axis tight; legend('show');

figure(6);
sgtitle('System III - Odpowiedź impulsowa', 'FontWeight', 'bold');

subplot(2, 1, 1);
y_k1 = Wp12(1); y_k2 = Wp12(2);
u_k1 = 0; u_k2 = 0; u_k3 = 0;
y_results = zeros(1, k_max + 1);
for i = 1:(k_max + 1)
    u_k = u_impulse(i);
    y_k = y_k1 - y_k2 + u_k + u_k1 - 3*u_k3;
    y_results(i) = y_k;
    y_k2 = y_k1; y_k1 = y_k;
    u_k3 = u_k2; u_k2 = u_k1; u_k1 = u_k;
end
stem(k_vec, y_results, 'b', 'filled', 'DisplayName', 'Odpowiedź y[k]');
hold on;
stem(k_vec, u_impulse, 'k:', 'LineWidth', 1.5, 'DisplayName', 'Pobudzenie u[k]');
hold off;
title(['Warunki początkowe: [', num2str(Wp12(1)), ', ', num2str(Wp12(2)), ']']);
grid on; xlabel('k'); ylabel('y[k]'); axis tight; legend('show');

subplot(2, 1, 2);
y_k1 = Wp22(1); y_k2 = Wp22(2);
u_k1 = 0; u_k2 = 0; u_k3 = 0;
y_results = zeros(1, k_max + 1);
for i = 1:(k_max + 1)
    u_k = u_impulse(i);
    y_k = y_k1 - y_k2 + u_k + u_k1 - 3*u_k3;
    y_results(i) = y_k;
    y_k2 = y_k1; y_k1 = y_k;
    u_k3 = u_k2; u_k2 = u_k1; u_k1 = u_k;
end
stem(k_vec, y_results, 'b', 'filled', 'DisplayName', 'Odpowiedź y[k]');
hold on;
stem(k_vec, u_impulse, 'k:', 'LineWidth', 1.5, 'DisplayName', 'Pobudzenie u[k]');
hold off;
title(['Warunki początkowe: [', num2str(Wp22(1)), ', ', num2str(Wp22(2)), ']']);
grid on; xlabel('k'); ylabel('y[k]'); axis tight; legend('show');
close all;

syms s t k z
G1_s = C / ((s + A) * (s + B) * (s - 1));

fprintf('\nTransmitancja G1(s):\n');
pretty(G1_s);
fprintf('\nOdpowiedź impulsowa systemu:\n');

g1_t = ilaplace(G1_s, s, t);
pretty(g1_t);

g1_k = subs(g1_t, t, k);

fprintf('\nZdyskretyzowana odpowiedź impulsowa systemu:\n');
pretty(g1_k);

G1_z = ztrans(g1_k, k, z);
G1_z = simplify(G1_z);

fprintf('\nTransmitancja dyskretna systemu:\n');
pretty(G1_z);

g1_new = iztrans(G1_z, z, k);
g1_new = simplify(g1_new);

fprintf('\nOdtworzona odpowiedź impulsowa g1[k] z G1(z):\n');
pretty(g1_new);
