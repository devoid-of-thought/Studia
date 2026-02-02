clear;
close all;

xi = 0.1;
czas_skok = 0;
u_0 = 1;
u_1 = 10;
w_n = 3;
nazwa_folderu = 'wykresy';

stany_pocz_x     = [11, 7, 0, -1, -7,-11];
stany_pocz_x_dot = [0, 3,11, -3, -7, 0];
czas_sym_n = [20,20,20,20,20,20,10,100,  465,  100,150, 290,  150,200,260,0.5,  5, 3, 1,0.3];
roz_xi = [5,2, 1, 0.5, 0.1, 0,-0.05, -0.1, -0.5,-0.8,-0.8,-0.8,-0.9,-0.9,-0.9,-1,-1,-2,-2,-2];

for i = 1:length(roz_xi)
    xi = roz_xi(i);
    czas_sym = czas_sym_n(i);
    figure;
    hold on;
    grid on;
    title(['Portret fazowy dla \xi = ', num2str(xi)]);
    xlabel('Położenie x ');
    ylabel('Prędkość x dot');
    plot(u_1, 0, 'kx', 'MarkerSize', 12, 'LineWidth', 3);
    yline(0, 'k', 'LineWidth', 1);
    xline(u_1, 'k', 'LineWidth', 1);
    for k = 1:length(stany_pocz_x)
        x_dot_0 = stany_pocz_x_dot(k);
        x_0 = stany_pocz_x(k);
        
        out = sim("portret.slx", czas_sym);
        
        plot(out.x, out.x_dot, 'LineWidth', 1.5);
        plot(x_0, x_dot_0, 'ro', 'MarkerSize', 5, 'MarkerFaceColor', 'r');
    end
    
    legend('Punkt równowagi','Trajektoria', 'Start' );
    hold off;
    nazwa_pliku = sprintf('%s/portret_xi_%g_czas_%g.png', ...
                          nazwa_folderu, xi, czas_sym);
    
    saveas(gcf, nazwa_pliku);
    disp(['Zapisano: ', nazwa_pliku]);
end