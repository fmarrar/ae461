clear; clc; close all; warning('off', 'all')
P = 0:5; % Loading (lbs)
L = 25.875; % Length of the beams (in)
ro = 1.5/2; % Outer radius (in)
tAl = 0.125; % Aluminum thickness (in)
tcomp = 0.075; % Composite thickness (in)
riAl = ro - tAl; % Inner radius for Aluminum (in)
ricomp = ro - tcomp; % Inner radius for Composite (in)
AencAl = pi/4*(ro + riAl)^2;
Aenccomp = pi/4*(ro + ricomp)^2;
IxxAl = pi/4 * (ro^4 - riAl^4);
Ixxcomp = pi/4 * (ro^4 - ricomp^4);
JAl = pi/2*(ro^4 - riAl^4);
Jcomp = pi/2*(ro^2 - ricomp^4);
%% Aluminum - Bending
[eps_yyp_Al1, eps_yy_Al1, eps_xxp_Al1] = extractData('Al_bending_123.txt'); % in/in
[eps_yyp_Al2, eps_yy_Al2, eps_xxp_Al2] = extractData('Al_bending_456.txt'); % in/in

N = length(eps_yyp_Al1);
% Transverse strain
eps_xx_Al1 = eps_xxp_Al1 + eps_yyp_Al1 - eps_yy_Al1;
eps_xx_Al2 = eps_xxp_Al2 + eps_yyp_Al2 - eps_yy_Al2;

% Shear strain
gammaAl1 = eps_xxp_Al1 - eps_yyp_Al1;
gammaAl2 = eps_xxp_Al2 - eps_yyp_Al2;

% Moment at each rosette location
C1 = P;
C2 = -L*P;
M1 = zeros(1, N);
M2 = zeros(1, N);
for i=1:N
    M1(i) = abs(C1(i)*8 + C2(i));
    M2(i) = abs(C1(i)*20.375 + C2(i));
end

% Bending stress at each rosette location
sigmayy_Al1 = ro/IxxAl * M1;
sigmayy_Al2 = ro/IxxAl * M2;

% Best line fit through sigmay vs epsy
p1_Bending_Al_sigma = polyfit(eps_yy_Al1, sigmayy_Al1, 1);
p2_Bending_Al_sigma = polyfit(eps_yy_Al2, sigmayy_Al2, 1);

% Young's Modulus for Aluminum
E_Al = (p1_Bending_Al_sigma(1) + p2_Bending_Al_sigma(1))/2;

% Best line fit through epsx vs epsy
p1_Bending_Al_eps = polyfit(eps_yy_Al1, eps_xx_Al1, 1);
p2_Bending_Al_eps = polyfit(eps_yy_Al2, eps_xx_Al2, 1);

% Poisson Ratio for Aluminum
v_Al1 = abs((p1_Bending_Al_eps(1) + p2_Bending_Al_eps(1)))/2;

figure(1), clf, hold on, grid on;
plot(eps_yy_Al1, eps_xx_Al1, 'b.', 'MarkerSize', 12);
plot(eps_yy_Al1, polyval(p1_Bending_Al_eps, eps_yy_Al1), 'LineWidth', 2);
text(0.5e-5, -7e-6, ...
    sprintf('{\\epsilon_{x} = %0.5g + %0.5g \\epsilon_y}', p1_Bending_Al_eps(2), p1_Bending_Al_eps(1)), 'FontSize',12);
xlabel('\epsilon_{y}', 'fontsize', 14)
ylabel('\epsilon_{x}', 'rotation', 0, 'fontsize', 14)
legend({'Data ($\epsilon_x$ vs $\epsilon_y$)', 'Fit ($\beta_0 + \beta_1 \epsilon_y$)'}, ...
    'Interpreter','latex', 'Location','northeast', 'FontSize',11)
saveas(figure(1), 'epsxAl1.eps', 'epsc')

figure(2), clf, hold on, grid on;
plot(eps_yy_Al2, eps_xx_Al2, 'b.', 'MarkerSize', 12);
plot(eps_yy_Al2, polyval(p2_Bending_Al_eps, eps_yy_Al2), 'LineWidth', 2);
text(1e-5, -2e-5, ...
    sprintf('{\\epsilon_{x} = %0.5g + %0.5g \\epsilon_y}', p2_Bending_Al_eps(2), p2_Bending_Al_eps(1)), 'FontSize',12);
xlabel('\epsilon_{y}', 'fontsize', 14)
ylabel('\epsilon_{x}', 'rotation', 0, 'fontsize', 14)
legend({'Data ($\epsilon_x$ vs $\epsilon_y$)', 'Fit ($\beta_0 + \beta_1 \epsilon_y$)'}, ...
    'Interpreter','latex', 'Location','northeast', 'FontSize',11)
saveas(figure(2), 'epsxAl2.eps', 'epsc')

figure(3), clf, hold on, grid on;
plot(eps_yy_Al1, sigmayy_Al1, 'b.', 'MarkerSize', 12);
plot(eps_yy_Al1, polyval(p1_Bending_Al_sigma, eps_yy_Al1), 'LineWidth', 2);
text(1e-5, -2e-5, ...
    sprintf('{\\sigma_{y} = %0.5g + %0.5g \\epsilon_y}', p1_Bending_Al_sigma(2), p1_Bending_Al_sigma(1)), 'FontSize',12);
xlabel('\epsilon_{y}', 'fontsize', 14)
ylabel('\sigma_{y} (psi)', 'fontsize', 14)
legend({'Data ($\sigma_y$ vs $\epsilon_y$)', 'Fit ($\beta_0 + \beta_1 \epsilon_y$)'}, ...
    'Interpreter','latex', 'Location','northeast', 'FontSize',11)
saveas(figure(3), 'sigmayAl1.eps', 'epsc')
%% Composite - Bending
[eps_yyp_comp1, eps_yy_comp1, eps_xxp_comp1] = extractData('comp_bending_123.txt'); % in/in
[eps_yyp_comp2, eps_yy_comp2, eps_xxp_comp2] = extractData('comp_bending_456.txt'); % in/in

N = length(eps_yyp_comp1);
% Transverse strain
eps_xx_comp1 = eps_xxp_comp1 + eps_yyp_comp1 - eps_yy_comp1;
eps_xx_comp2 = eps_xxp_comp2 + eps_yyp_comp2 - eps_yy_comp2;

% Shear strain
gammacomp1 = eps_xxp_comp1 - eps_yyp_comp1;
gammacomp2 = eps_xxp_comp2 - eps_yyp_comp2;

% Moment at each rosette location
C1 = P;
C2 = -L*P;
M1 = zeros(1, N);
M2 = zeros(1, N);
for i=1:N
    M1(i) = abs(C1(i)*8 + C2(i));
    M2(i) = abs(C1(i)*20.375 + C2(i));
end

% Bending stress at each rosette location
sigmayy_comp1 = ro/Ixxcomp * M1;
sigmayy_comp2 = ro/Ixxcomp * M2;

% Best line fit through sigmay vs epsy
p1_Bending_comp_sigma = polyfit(eps_yy_comp1, sigmayy_comp1, 1);
p2_Bending_comp_sigma = polyfit(eps_yy_comp2, sigmayy_comp2, 1);

% Young's Modulus for Composite
E_comp = (p1_Bending_comp_sigma(1) + p2_Bending_comp_sigma(1))/2;

% Best line fit through epsx vs epsy
p1_Bending_comp_eps = polyfit(eps_yy_comp1, eps_xx_comp1, 1);
p2_Bending_comp_eps = polyfit(eps_yy_comp2, eps_xx_comp2, 1);

% Poisson Ratio for Composite
v_comp1 = abs((p1_Bending_comp_eps(1) + p2_Bending_comp_eps(1)))/2;
%% Aluminum - Torsion
[eps_yyp_Al1, eps_yy_Al1, eps_xxp_Al1] = extractData('Al_torsion_123.txt'); % in/in
[eps_yyp_Al2, eps_yy_Al2, eps_xxp_Al2] = extractData('Al_torsion_456.txt'); % in/in

N = length(eps_yyp_Al1);
% Transverse strain
eps_xx_Al1 = eps_xxp_Al1 + eps_yyp_Al1 - eps_yy_Al1;
eps_xx_Al2 = eps_xxp_Al2 + eps_yyp_Al2 - eps_yy_Al2;

% Shear strain
gammaAl1 = eps_xxp_Al1 - eps_yyp_Al1;
gammaAl2 = eps_xxp_Al2 - eps_yyp_Al2;

% Twisting Moment
My = 10*P;

% Tangential Shear Stress
sigmasy = My/(2*tAl*AencAl);

% Best line fit through sigmasy vs gamma
p1_Torsion_Al = polyfit(gammaAl1, sigmasy, 1);
p2_Torsion_Al = polyfit(gammaAl2, sigmasy, 1);

% Shear modulus for Aluminum
G_Al1 = abs(p1_Torsion_Al(1) + p2_Torsion_Al(1))/2;
%% Composite - Torsion
[eps_yyp_comp1, eps_yy_comp1, eps_xxp_comp1] = extractData('comp_torsion_123.txt'); % in/in
[eps_yyp_comp2, eps_yy_comp2, eps_xxp_comp2] = extractData('comp_torsion_456.txt'); % in/in

N = length(eps_yyp_comp1);
% Transverse strain
eps_xx_comp1 = eps_xxp_comp1 + eps_yyp_comp1 - eps_yy_comp1;
eps_xx_comp2 = eps_xxp_comp2 + eps_yyp_comp2 - eps_yy_comp2;

% Shear strain
gammacomp1 = eps_xxp_comp1 - eps_yyp_comp1;
gammacomp2 = eps_xxp_comp2 - eps_yyp_comp2;

% Twisting Moment
My = 10*P;

% Tangenticomp Shear Stress
sigmasy = My/(2*tcomp*Aenccomp);

% Best line fit through sigmasy vs gamma
p1_Torsion_comp = polyfit(gammacomp1, sigmasy, 1);
p2_Torsion_comp = polyfit(gammacomp2, sigmasy, 1);

% Shear modulus for compuminum
G_comp1 = abs(p1_Torsion_comp(1) + p2_Torsion_comp(1))/2;
%% Aluminum - Twist Angle
d1 = [0.07, 0.14, 0.21, 0.28, 0.349]*0.0393701; % Left gauge
d2 = [0.095, 0.19, 0.28, 0.37, 0.465]*0.0393701; % Right gauge

% Twist angle
theta_Al = atan((d2 - d1)./8.75);

% Twist angle per unit length
alpha_Al = theta_Al./L;

% Shear modulus
G_Al2 = abs(My(2:end)./(JAl*alpha_Al));
G_Al2 = mean(G_Al2);
%% Composite - Twist Angle
d1 = [0.51, 1, 1.485, 1.98, 2.48]*0.0393701;
d2 = [0.54, 0.99, 1.33, 1.781, 2.24]*0.0393701;

% Twist angle
theta_comp = atan((d2 - d1)./8.75);

% Twist angle per unit length
alpha_comp = theta_comp./L;

% Shear modulus
G_comp2 = abs(My(2:end)./(Jcomp*alpha_comp));
G_comp2 = mean(G_comp2);
%% Poisson Ratio from average shear modulus and young's modulus
v_Al2 = E_Al/(2*G_Al2) - 1;
v_comp2 = E_comp/(2*G_comp2) - 1;

%% sigmax, sigmay, sigmaxy at each rosette - Aluminum
sigmax_Al1 = E_Al/(1 - v_Al1^2) * (eps_xx_Al1 + v_Al1*eps_yy_Al1);
sigmax_Al2 = E_Al/(1 - v_Al1^2) * (eps_xx_Al2 + v_Al1*eps_yy_Al2);

sigmay_Al1 = E_Al/(1 - v_Al1^2) * (eps_yy_Al1 + v_Al1*eps_xx_Al1);
sigmay_Al2 = E_Al/(1 - v_Al1^2) * (eps_yy_Al2 + v_Al1*eps_xx_Al2);

sigmaxy_Al1 = G_Al1*gammaAl1;
sigmaxy_Al2 = G_Al1*gammaAl2;
%% sigmax, sigmay, sigmaxy at each rosette - Composite
sigmax_comp1 = E_comp/(1 - v_comp1^2) * (eps_xx_comp1 + v_comp1*eps_yy_comp1);
sigmax_comp2 = E_comp/(1 - v_comp1^2) * (eps_xx_comp2 + v_comp1*eps_yy_comp2);

sigmay_comp1 = E_comp/(1 - v_comp1^2) * (eps_yy_comp1 + v_comp1*eps_xx_comp1);
sigmay_comp2 = E_comp/(1 - v_comp1^2) * (eps_yy_comp2 + v_comp1*eps_xx_comp2);

sigmaxy_comp1 = G_comp1*gammacomp1;
sigmaxy_comp2 = G_comp1*gammacomp2;