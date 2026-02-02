function r = reference_signal(k)
    % Skok jednostkowy o amplitudzie 10 w chwili k=10
    if k >= 10
        r = 10;
    else
        r = 0;
    end
end
function [wynik, y0, u0] = Regulator_PI(e,Kp,Ki,obiekt,czas,Ts,y0,u0)
    P = e * Kp;
    I = Ki * e / czas;
    suma = P + I;
    obiekt = obiekt*suma;
    dyskretny = c2d(obiekt, Ts);
    [num, den] = tfdata(dyskretny, 'v');
    wynik = 0;
    for i = 2:length(den)
        wynik = wynik - den(i) * y0(i - 1);
    end
    for i = 2:length(num)
        wynik = wynik + num(i) * u0(i - 1);
    end
    % Przesuwanie historii
    y0(3:-1:2) = y0(2:-1:1);
    y0(1) = wynik;
    u0(3:-1:2) = u0(2:-1:1);
    u0(1) = reference_signal(czas);
end
sdt1_ID = "280082";
sdt2_ID = "280141";
A = str2double(extract(sdt1_ID,6));
B = str2double(extract(sdt2_ID,6));
if A == 0 && B == 0
    A=1;
    B=1;
end
C=A+B;
s = tf('s');
G1 = C/((s+A)*(s+B)*(s-1));
[num, den] = tfdata(G1);
Kp=10;
Ki=1;
Ts_vec = [0.1, 0.5, 1];  % czasy próbkowania
T_end = 30; 
e=0;
y=0;
y0 = [0 0 0];
u0 = [0 0 0];
dowykresu=zeros(1,T_end);
for i=1:length(Ts_vec)
for k=1:T_end
    e=reference_signal(k)-y;%liczenie uchybu
    [y, y0, u0] = Regulator_PI(e, Kp, Ki, G1, k, Ts_vec(i), y0, u0);
    dowykresu(k)=y;
end
figure;
plot(dowykresu)
hold on;
stairs(dowykresu, 'r-o', "Color", "red");
grid on;
hold off;
disp(y)
end
