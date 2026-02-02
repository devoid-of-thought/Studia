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
czas =5000;
czas_skok=500;
%zakłócenie
dTzew = 0;
dQd = 0;
dPg = 0;

%symulacja 
out = sim("lab.slx",czas);
figure,plot(out.tout,out.dTwew,"r"),grid on,
figure,plot(out.tout,out.dTp,"r"),grid on,









    