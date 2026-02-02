function r = reference_signal(t)
    % Skok jednostkowy o amplitudzie 10 w chwili k=10
    if t >= 10
        r = 10;
    else
        r = 0;
    end
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
G1 = C/((s+A)*(s+B)*(s-1))
Kp=10;
Ki=1;
regulator = Kp + (Ki*1/s)
obiekt = G1 * regulator
figure;
step(obiekt)
grid on;
Ts_vec = [0.1 0.25 1];
dyskretny = c2d(obiekt, 1, 'zoh')
[num, den] = tfdata(dyskretny, 'v')
dlugosc = length(den)-1
%kryterium krok 1
wynik1 = 0;
blad = 0;
for i = 1:length(den)
    wynik1 = wynik1 + den(i);
end
if wynik1<=0
    blad = 1;
    disp("blad w 1")
end
wynik2 = 0;
for i = 1:length(den)
    wynik2 = wynik2 + den(i)*(-1)^(dlugosc+1-i);
end
wynik2 = wynik2 * (-1)^(dlugosc);
if wynik2<=0
    blad = 1;
    disp("blad w 2")
end
if abs(den(dlugosc+1)) >= den(1)
    blad = 1;
    disp("blad w 3")
end
n = dlugosc; % stopień wielomianu
m = n + 1;   % liczba współczynników
Szereg_jury = zeros(2*n-3, m); % Inicjalizacja
% Wiersz 1: współczynniki wielomianu
Szereg_jury(1, :) = den; 
% Wiersz 2: odwrócenie współczynników
Szereg_jury(2, 1:m) = fliplr(den); 
% Generowanie kolejnych wierszy
for i = 1:n-2
    current_row = 2*i - 1; % Aktualny wiersz nieparzysty
    L = m - i;             % Długość nowego wiersza
    % Obliczanie nowego wiersza nieparzystego
    next_row = 2*i + 1;
    for j = 1:L
        Szereg_jury(next_row, j) = Szereg_jury(current_row, 1) * Szereg_jury(current_row, j) ...
                                 - Szereg_jury(current_row, end) * Szereg_jury(current_row, end - j);
    end
    
    % Wiersz parzysty: odwrócenie nowego wiersza nieparzystego
    Szereg_jury(next_row + 1, 1:L) = fliplr(Szereg_jury(next_row, 1:L));
end
for i = 1:m/2
    if(abs(Szereg_jury(2*i-1,1))<=abs(Szereg_jury(2*i-1,n+1-i)))
        blad = 1;
        disp("blad w 4")
    end
end
disp(Szereg_jury)
if blad ~= 0
    sprintf("układ niestabilny")
else
    sprintf("układ stabilny")
end
