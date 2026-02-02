clear;
close all;
clc;

r_vv_n = [0, 1,2.5, 5];
a = 0.6;
b = 0.4;
r_sp = 1;

V_0_n = [5, 10, 15];
P_0_n = [2, 5, 8];

czas_n = [20, 40, 20,10];
model_name = 'lotker'; 

V_0 = 10;
P_0 = 5;
czas = 40;

for i = 1:length(r_vv_n)
    r_vv = r_vv_n(i);
    
    out = sim(model_name, czas);
    
    figure;
    plot(out.tout, out.V, 'b-', 'LineWidth', 2); hold on;
    plot(out.tout, out.P, 'r--', 'LineWidth', 2);
    grid on;
    title({['Wynik symulacji dla r_{vv} = ' num2str(r_vv)], ...
           ['Start: V_0=' num2str(V_0) ', P_0=' num2str(P_0)]});
    xlabel('Czas [s]');
    ylabel('Liczebnosc populacji');
    legend('Ofiary (V)', 'Drapiezniki (P)');
end

colors = lines(length(V_0_n));

for i = 1:length(r_vv_n)
    r_vv = r_vv_n(i);
    
    figure;
    sgtitle(['Rodzina przebiegow czasowych dla r_{vv} = ' num2str(r_vv)]);
    
    subplot(1,2,1);
    hold on; grid on;
    title('Populacja Ofiar (V)');
    xlabel('Czas [s]');
    ylabel('Liczebnosc V');
    
    subplot(1,2,2);
    hold on; grid on;
    title('Populacja Drapieznikow (P)');
    xlabel('Czas [s]');
    ylabel('Liczebnosc P');
            czas = czas_n(i); 

    for j = 1:length(V_0_n)

        V_0 = V_0_n(j);
        P_0 = P_0_n(j);
        
        out = sim(model_name, czas);
        
        subplot(1,2,1);
        plot(out.tout, out.V, '-', 'Color', colors(j,:), 'LineWidth', 2, ...
            'DisplayName', ['Start: ' num2str(V_0) ',' num2str(P_0)]);
            
        subplot(1,2,2);
        plot(out.tout, out.P, '-', 'Color', colors(j,:), 'LineWidth', 2, ...
            'DisplayName', ['Start: ' num2str(V_0) ',' num2str(P_0)]);
    end
    
    subplot(1,2,1); legend('show', 'Location', 'best');
    subplot(1,2,2); legend('show', 'Location', 'best');
end

for i = 1:length(r_vv_n)
    r_vv = r_vv_n(i);
    czas = czas_n(i); 

    figure;
    hold on;
    grid on;
    title({['Portrety fazow dla r_{vv} = ' num2str(r_vv)]});
    ylabel('Populacja Drapieżników [P]');
    xlabel('Populacja Ofiar [V]');
    
    for j = 1:length(V_0_n)
        V_0 = V_0_n(j);

        P_0 = P_0_n(j);
        
        out = sim(model_name, czas);
        
        plot(out.V, out.P, '-', 'Color', colors(j,:), 'LineWidth', 2, ...
            'DisplayName', ['V (Start: ' num2str(V_0) ',' num2str(P_0) ')']);
           end
    hold off;
    legend('show', 'Location', 'bestoutside');
end