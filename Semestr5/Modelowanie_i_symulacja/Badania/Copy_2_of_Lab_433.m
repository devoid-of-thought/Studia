clear;
close all;
%Założenia podstawowe
T_zewn = -20; %Celcius
T_wewn = 20; %Celcius
T_pn = 15; %Celcius
P_gN = 10000; %Watts
V_we =100*2.5; %m^3
V_wp =100*2.5*0.25; %m^3
c_p = 1000; % J/(kg*K)
p_p = 1.2; %kg/m^3
%Parametry statyczne
f_pN = 0.01; %m^3/s
K_1=(0.6*P_gN)/(T_wewn-T_zewn);
K_p = (P_gN-K_1*(T_wewn-T_zewn)-c_p*p_p*f_pN*(T_wewn-T_zewn))/(T_wewn-T_pn);
K_d = (K_p*(T_wewn-T_pn))/(T_pn-T_zewn);
%Parametry dynamiczne
C_vw = c_p*p_p*V_we;
C_vp = c_p*p_p*V_wp;
%warunki początkowe
T_zewn0 = T_zewn+0;
P_gN0 = P_gN*1;
f_pN0= f_pN*1;
%stan równowagi
T_wewn0 = T_zewn0 + (P_gN0)/(K_1+c_p*p_p*f_pN0+(K_p*K_d)/(K_p+K_d));
T_p0 = (K_p*(T_wewn0)+K_d*T_zewn0)/(K_p+K_d);

%symulacja
czas =20000;
czas_skok=3000;
%zakłócenie
dTzew = 10;
dQd = 0;
dPg = 0;

P_p_T_zew = [T_zewn T_zewn+20 T_zewn+20 T_zewn+20];
P_p_Pg = [P_gN P_gN 0.1*P_gN 5*P_gN ];
kolory= ['r' 'g' 'b' "black"];
figure(1),hold on, grid on;
title("T p")
ylabel("temp")
xlabel("czas")
figure(2),hold on, grid on;
title("T wew")
ylabel("temp")
xlabel("czas")

figure(3),hold on, grid on;
title("T p")
ylabel("temp")
xlabel("czas")
figure(4),hold on, grid on;
title("T wew")
ylabel("temp")
xlabel("czas")

for k = 1:4
    T_zewn0 = P_p_T_zew(k);
    P_gN0 = P_p_Pg(k);

    T_wewn0 = T_zewn0 + (P_gN0)/(K_1+c_p*p_p*f_pN0+(K_p*K_d)/(K_p+K_d));
    T_p0 = (K_p*(T_wewn0)+K_d*T_zewn0)/(K_p+K_d);

    out = sim("lab.slx",czas);
    opis = sprintf('T_{zew0}=%.1f, P_{gN0}=%.0f', T_zewn0, P_gN0);
    figure(1);
    plot(out.tout, out.dTp, kolory(k), 'DisplayName', opis);
   
    figure(2);
    plot(out.tout, out.dTwew, kolory(k), 'DisplayName', opis);

    figure(3);
    plot(out.tout, out.dTp-out.dTp(1), kolory(k), 'DisplayName', opis);
   
    figure(4);
    plot(out.tout, out.dTwew-out.dTwew(1), kolory(k), 'DisplayName', opis);
end
figure(1); legend show; 
figure(2); legend show;
figure(3); legend show; 
figure(4); legend show;


%zakłócenie
dTzew = 0;
dQd = 0;
dPg = 10000;

figure(5),hold on, grid on;
title("T p")
ylabel("temp")
xlabel("czas")
figure(6),hold on, grid on;
title("T wew")
ylabel("temp")
xlabel("czas")

figure(7),hold on, grid on;
title("T p")
ylabel("temp")
xlabel("czas")
figure(8),hold on, grid on;
title("T wew")
ylabel("temp")
xlabel("czas")

for k = 1:4
    T_zewn0 = P_p_T_zew(k);
    P_gN0 = P_p_Pg(k);

    T_wewn0 = T_zewn0 + (P_gN0)/(K_1+c_p*p_p*f_pN0+(K_p*K_d)/(K_p+K_d));
    T_p0 = (K_p*(T_wewn0)+K_d*T_zewn0)/(K_p+K_d);

    out = sim("lab.slx",czas);
    opis = sprintf('T_{zew0}=%.1f, P_{gN0}=%.0f', T_zewn0, P_gN0);
    figure(5);
    plot(out.tout, out.dTp, kolory(k), 'DisplayName', opis);
   
    figure(6);
    plot(out.tout, out.dTwew, kolory(k), 'DisplayName', opis);

    figure(7);
    plot(out.tout, out.dTp-out.dTp(1), kolory(k), 'DisplayName', opis);
   
    figure(8);
    plot(out.tout, out.dTwew-out.dTwew(1), kolory(k), 'DisplayName', opis);

end
figure(5); legend show; 
figure(6); legend show;
figure(7); legend show; 
figure(8); legend show;







    