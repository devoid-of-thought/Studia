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
    dTzew = 0;
    dQd = 0;
    dPg = 1000;
    out = sim("lab.slx" , czas);
    
    %parametry FOTD
    x1 = 3100; y1 = 15.1;
    x2 = 3488; 
    y2 = 15.86
    
    y_0 = out.dTp(1);
    y_ust = out.dTp(end); 
    T_0 = x1 - czas_skok 
    y_delta = y_ust-y_0;
    K = y_delta/ dPg
    
    a = (y2 - y1) / (x2 - x1);
    t_koniec = (y_ust - y1) / a + x1;
    T_stala = t_koniec - x1
    
    
    figure('Name', 'Wykres konstrukcyjny', 'NumberTitle', 'off');
    plot(out.tout, out.dTp, 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 2, 'DisplayName', 'Proces');
    hold on; 
    
    plot([x1, t_koniec], [y1, y_ust], 'r', 'LineWidth', 2, 'DisplayName', 'Styczna');
    grid on; 
    grid minor;
    xlabel('Czas [s]');
    ylabel('Temperatura [^\circ C]');
    title('Wykres konstrukcyjny');
    hold off;
    
    iden = sim("lab_identyfikacja.slx", czas);
    
    figure('Name', 'Weryfikacja modelu', 'NumberTitle', 'off');
    plot(out.tout, out.dTp, 'b', 'LineWidth', 1.5, 'DisplayName', 'Odpowiedź obiektu oryginał');
    hold on;
    plot(iden.tout, iden.iden, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Odpowiedź modelu FOTD');
    grid on;
    xlabel('Czas [s]');
    ylabel('Temperatura [^\circ C]');
    legend("Obiekt","Model wyznaczony za pomocą stycznej")
    title('Weryfikacja modelu FOTD');
