% Simulate the repressilator model
clear all
close all

alpha = 5;
alpha0 = 0.0;
beta = 0.2;
n = 2;

for numreps=1:1
    p = [alpha, alpha0, beta, n]; % parameter vector
    x0 = 30 * rand(6,1); % initial condition is random ~ U[0,30]

    Tmax = 500;
    
    % simulate the ODE from time 0 to Tmax
    [T,Y] = ode45(@repress, [0 Tmax], x0, [], p);

    % Plot variables versus time
    figure(1)
    % First 3 variables (mRNA concentrations) solid lines
    plot(T, Y(:,1:3), 'LineWidth', 3); 
    hold on;
    % Second 3 variables (proteins = transcription factors) dotted
    plot(T, Y(:,4:6), ':', 'LineWidth', 3); 
    hold on;
    legend('m lalcl', 'm tetR', 'm cl', 'p lacl', 'p tetR', 'p cl')
    xlabel('t') ; 
    set(gca,'FontSize',16)


    figure(2)
    % Plot mRNA concentrations in 3D
    plot3(Y(:,1), Y(:,2), Y(:,3), 'LineWidth', 3); 
    hold on 
    xlabel('m lalcl');
    ylabel('m tetR');
    zlabel('m cl')
    set(gca,'FontSize',16)
end