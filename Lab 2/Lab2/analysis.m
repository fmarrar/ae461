clear all; clc; close all

%% Shear Force and Bending Moment Diagrams 
d12 = 2.177;
d34 = 4.349;
dR1F1 = 1.0846;
dR2F2 = 1.095;
L = 5;

dF1 = 0.5*(L - d12);
dR1 = 0.5*(L - d34);

dF2 = dF1 + d12;
dR2 = dR1 + d34;

syms R1 R2
F = 133;
F1 = F/2;
F2 = F/2;

eq1 = 0 == R1 + R2 - F1 - F2;
eq2 = 0 == -F1*dR1F1 - F2*(d12 + dR1F1) + R2*d34;

soln = solve([eq1, eq2], [R1 R2]);
R1 = double(soln.R1);
R2 = double(soln.R2);

N = 1001;
x1 = linspace(0, dR1, N);
x2 = linspace(dR1, dF1, N);
x3 = linspace(dF1, dF2, N);
x4 = linspace(dF2, dR2, N);
x5 = linspace(dR2, L, N);

figure(1), clf;

subplot(2, 1, 1);
plot([x1, x2, x3, x4, x5], [zeros(1, N), R1*ones(1, N), (R1 - F1)*ones(1, N), -R2*ones(1, N), zeros(1, N)], 'linewidth', 2)
grid on;
ylabel('$V_z$ (N)', 'Interpreter','latex', 'FontSize', 13)

subplot(2, 1, 2);
plot([x1, x2, x3, x4, x5], [zeros(1, N), R1*(x2 - dR1), R1*(x3 - dR1) - F1*(x3 - dF1), R2*(L - x4 - dR1), zeros(1, N)], 'linewidth', 2)
grid on;
ylabel('$M_y$ (N \ in)','FontSize',13, 'Interpreter','latex')
xlabel('$x$ (in)', 'interpreter', 'latex', 'fontsize', 13)
saveas(figure(1), 'ShearBending.eps', 'epsc')

%% Calculating the fringe constant
t = 0.213;
h = 1;
Iyy = 1/12 * t * h^3;

z = [0.522, 0.284, h - 0.973];
m = [0.5, 1.5, 2.5];
M = 72.3145*0.2248089431; % lbs-in

sigmaX = zeros(1, length(z));

for i=1:length(z)
    sigmaX(i) = -M*z(i)/Iyy;
end

p = polyfit(m, sigmaX, 1);
% Fringe constant
Fs = p(1)*t;

% Line fit fringe order vs stress
mFit = linspace(m(1), m(end), N);
sigmaXFit = polyval(p, mFit);

figure(2), clf, hold on, grid on;
plot(m, sigmaX, '.', 'MarkerSize',15)
plot(mFit, sigmaXFit, '--')
xlabel('$n$', 'FontSize',13, 'Interpreter','latex')
ylabel('$\sigma_x$ (psi)', 'FontSize', 13, 'Interpreter','latex')
legend({'Experimental $n$ vs. $\sigma_x$', 'Line fit $n$ vs. $\sigma_x$'}, 'Interpreter','latex', 'FontSize', 13, 'Location','northwest')
saveas(figure(2), 'Fs.eps', 'epsc')
%% U-Notch, V-Notch Stress Resolution at F = 138, 136 N respectively
zU = [0.446, 0.344, 0.308, 0.295, 0.284];
mU = 0.5:1:length(zU) + 0.5;
sigmaU = zeros(1, length(zU));

zV = [0.402, 0.391, 0.362, 0.308, 0.287];
mV = mU;
sigmaV = zeros(1, length(zV));

sigmaUn = zeros(1, length(z));

for i=1:length(zU)
    sigmaU(i) = Fs/t * mU(i);
    sigmaV(i) = Fs/t * mV(i);
end

for i=1:length(z)
    sigmaUn(i) = Fs/t * m(i);
end

figure(3), clf, hold on, grid on;
set(gca,'DefaultLineLineWidth',2)
plot(z, sigmaUn)
plot(zU, sigmaU, 'color', [0 0.5 0])
plot(zV, sigmaV, 'r')
xlabel('Fringe location (in)', 'Interpreter','latex', 'FontSize',13)
ylabel('$\sigma_x$ (psi)', 'Interpreter','latex', 'FontSize',13)
legend({'Unnotched Beam', 'U-Notch Beam', 'V-Notch Beam'}, 'Interpreter','latex', 'fontsize', 11, 'Location','best')
saveas(figure(3), 'StressVFringeLocation.eps', 'epsc')

figure(4), clf, hold on, grid on;
plot(zU(1:end-2), sigmaU(1:end-2), 'LineWidth',2)
xlabel('Fringe location (in)', 'Interpreter','latex', 'FontSize',13)
ylabel('$\sigma_x$ (psi)', 'Interpreter','latex', 'FontSize',13)
saveas(figure(4), 'StressVsUnnotchedCross.eps', 'epsc')
%% Theoretical Maximum Stress for U and V Notched Beams
tU = 0.215;
tV = 0.214;

depthU = 0.261;
depthV = 0.263;

dU = h - depthU;
dV = h - depthV;

rU = 0.146/2;

sigma_Nom_U = 6*M/(tU*dU^2);
sigma_Nom_V = 6*M/(tV*dV^2);

% U-Notch
% Since h/r is greater than 2 and less than 20
C1 = 2.966 + 0.502*depthU/rU - 0.009*(depthU/rU)^2;
C2 = -6.475 - 1.126*depthU/rU + 0.019*(depthU/rU)^2;
C3 = 8.023 + 1.253*depthU/rU - 0.020*(depthU/rU)^2;
C4 = -3.572 - 0.634*depthU/rU + 0.010*(depthU/rU)^2;

KtU = C1 + C2*depthU/h + C3*(depthU/h)^3 + C4*(depthU/h)^3;
sigma_Max_U = KtU*sigma_Nom_U;

% V-Notch
KtV = KtU;
sigma_Max_V = KtV*sigma_Nom_V;

%% Curve fitting to extrapolate maximum stress
zUFit = linspace(zU(1), depthU, N);
zVFit = linspace(zV(1), depthV, N);
% Cubic fit since the stress concentration factor is cubic
pUFit = polyfit(zU, sigmaU, 3);
pVFit = polyfit(zV, sigmaV, 3);

sigmaUFit = polyval(pUFit, zUFit);
sigmaVFit = polyval(pVFit, zVFit);

errorU = abs(sigma_Max_U - max(sigmaUFit))/sigma_Max_U
errorV = abs(sigma_Max_V - max(sigmaVFit))/sigma_Max_V

figure(5), clf, hold on, grid on;
set(gca,'DefaultLineLineWidth',2)
plot(zUFit, sigmaUFit, '--')
plot(zVFit, sigmaVFit, '--')
xlabel('Fringe location (in)', 'FontSize',13, 'Interpreter','latex')
ylabel('$\sigma_x$ (psi)', 'FontSize', 13, 'Interpreter','latex')
legend({'Curve Fit for U-Notch Beam', 'Curve Fit for V-Notch Beam'}, 'Interpreter','latex', 'FontSize',13)
saveas(figure(5), 'CurveFitStress.eps', 'epsc')