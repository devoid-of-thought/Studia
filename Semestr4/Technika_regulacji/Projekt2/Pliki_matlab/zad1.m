close all
std1ID = "280082";
std2ID = "280141";
A = str2double(extractAfter(std1ID,5));
B = str2double(extractAfter(std2ID,5));
t = 0:0.01:10;
sys = tf(A,[B 1]);
w = [0.01, 0.25, 0.1, 0.5, 1,2, 5, 10];

H_points = zeros(1, length(w));

for i = 1:length(w)
    figure(i)
    w0 = w(i);
    u = sin(w0 * t);
    [y, ~] = lsim(sys, u, t);
    [mag, phase] = bode(sys, w0);
    mag = squeeze(mag);
    phase = squeeze(phase);
    phase_rad = deg2rad(phase);
    H = mag * exp(1j * phase_rad);
    H_points(i) = H;

    plot(t, y, 'b', t, u)
    title({
        ['Dla w = ', num2str(w0)]
        ['A = ', num2str(mag, '%.2f'), ', \phi = ', num2str(phase, '%.1f'), '°']
    })
    xlabel('Czas (s)')
    ylabel('Amplituda')
    legend('y(t)', 'u(t)')
    grid on
end

figure(length(w) + 1)
nyquist(sys)
hold on
plot(real(H_points), imag(H_points), 'ro', 'MarkerSize', 4, 'LineWidth', 2)
legend('funkcja nyquist', 'Obliczone punkty')
grid on
