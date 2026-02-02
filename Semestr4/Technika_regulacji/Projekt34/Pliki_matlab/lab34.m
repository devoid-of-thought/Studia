close all;
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
czasy = [0.1 0.25 0.5 1];
iteracje = 20;
wejscie = 1;%skok jednostkowy
wynik = 0;
wyniki = zeros(1, iteracje);
for i = 1:4
    czas = czasy(i);
    sysd = c2d(G1,czas)
    [num, den] = tfdata(sysd, 'v');
    num(1:4);%licznik bedzie U w rownaniu
    den(1:4);%mianownik bedzie y w rownaniu
    %fprintf('Równanie różnicowe:\n');
    eqn = '';
    for j=2:length(num)%U
        if num(j)>0
            eqn = sprintf('%s + ',eqn);
        else
            eqn = sprintf('%s - ',eqn);
        end
        eqn = sprintf('%s %.4f*u[n%d]', eqn, abs(num(j)),1-j);
    end
    for j=2:length(den)%y
         if den(j)>0
            eqn = sprintf('%s - ',eqn);
         else
            eqn = sprintf('%s + ',eqn);
         end
         eqn = sprintf('%s %.4f*y[n%d] ', eqn, abs(den(j)),1-j);
    end
    eqn = eqn(3:end);
    eqn = sprintf('y[n] = %s', eqn);
    disp(eqn)
    y0 = [0 0 0];
    u0 = [0 0 0];
    for k=1:iteracje
        for j = 2:length(num)
            wynik = wynik + (num(j)*u0(j-1));
        end
        for j = 2:length(den)
            wynik = wynik - (den(j)*y0(j-1));
        end
        for j = 0:length(y0)-2
            y0(length(y0)-j) = y0(length(y0)-j-1);
        end
        y0(1) = wynik;
        for j = 0:length(u0)-2
            u0(length(u0)-j) = u0(length(u0)-j-1);
        end
        u0(1)= wejscie;
        if k == iteracje
            disp(wynik)
        end
        wyniki(k) = wynik;
        wynik = 0;
    end
    figure;
    stepplot(G1,'-',sysd,'-',5)
    hold on;
    t_sym = 0:czas:(iteracje-1)*czas; % Wektor czasu dla symulacji
    stairs(t_sym, wyniki, 'r--o', "Color", "green");
    grid on;
    hold off;
end
