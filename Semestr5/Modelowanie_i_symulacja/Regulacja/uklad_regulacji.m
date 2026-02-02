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
    czas_skok=1000;
    %zakłócenie
    dTzew = 0;
    dQd = 0;
    dPg = 1000;
    out = sim("lab.slx" , czas);
    
    %parametry FOTD
    x1 = 3100; 
    y1 = 15.1;
    x2 = 3488; 
    y2 = 15.86;
    
    y_0 = out.dTp(1);
    y_ust = out.dTp(end); 
    T_0 = 100;
    y_delta = y_ust-y_0;
    K = y_delta/ dPg;
    
    a = (y2 - y1) / (x2 - x1);
    t_koniec = (y_ust - y1) / a + x1;
    T = 1758;
    
    T_i = 3.33*T_0;
    K_rp = 0.9*T/(K*T_0);

    SP0 = T_pn; dSP = 2 ;

    model = sim("Model_z_regulatorem.slx",czas);
    obiekt = sim("Obiekt_z_regulatorem.slx",czas);
    figure;
    plot(obiekt.tout,obiekt.dTp);
    hold on;
    plot(model.tout,model.iden);
    hold off;
    grid on;
    legend("Regulowany Obiekt","Regulowany Model")
    


    
    
    
