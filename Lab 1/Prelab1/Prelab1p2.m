clear all; clc

%% Graph
vF = [0.35 0.45 0.55 0.65];
rhoM = 1.15;
rhoF = 1.84;
vV = linspace(0, 100, 1000);

vM1 = ones(size(vV)) - vF(1) * ones(size(vV)) - vV/100;
rho1 = rhoF*vF(1) + rhoM * vM1;

vM2 = ones(size(vV)) - vF(2) * ones(size(vV)) - vV/100;
rho2 = rhoF*vF(2) + rhoM * vM2;

vM3 = ones(size(vV)) - vF(3) * ones(size(vV)) - vV/100;
rho3 = rhoF*vF(3) + rhoM * vM3;

vM4 = ones(size(vV)) - vF(4) * ones(size(vV)) - vV/100;
rho4 = rhoF*vF(4) + rhoM * vM4;

figure(1), clf, hold on, grid on;
plot(vV, rho1, 'linewidth', 2)
plot(vV, rho2, 'linewidth', 2)
plot(vV, rho3, 'linewidth', 2)
plot(vV, rho4, 'linewidth', 2)
xlabel('$v_v \times 100$', 'interpreter', 'latex', 'fontsize', 13)
ylabel('$\rho$', 'interpreter', 'latex', 'fontsize', 13)
legend({'$\rho$ at $v_f = 0.35$', '$\rho$ at $v_f = 0.45$', '$\rho$ at $v_f = 0.55$', '$\rho$ at $v_f = 0.65$'}, 'interpreter', 'latex', 'fontsize', 13)
saveas(figure(1), 'rhoVvoid', 'epsc')

%% Part (a)
rhoi = rhoF*0.55 + rhoM * 0.45;
rhof = 0.9*rhoi;

v_vf = ((rhoF - rhoM)*0.55 + (rhoM - rhof))/rhoM;

%% Part (b)
% Row 1
vf = 0.7;
rho = 1.6;
v_v = ((rhoF - rhoM)*vf + (rhoM - rho))/rhoM;

% Row 2
v_v = 0.05;
rho = 1.550;
vf = (rho - rhoM*(1 - v_v))/(rhoF - rhoM);

% Row 3
v_v = 0.03;
vf = 0.65;
rho = vf*(rhoF - rhoM) + rhoM*(1 - v_v);

% Row 4
v_v = 0.02;
rho = 1.7;
vf = (rho - rhoM*(1 - v_v))/(rhoF - rhoM);

% Row 5
rho = 1.625;
syms v_v
vf = 20*v_v;
v_v = double(solve(rho == vf*(rhoF - rhoM) + rhoM*(1 - v_v), v_v));
vf = 20*v_v;

%% Problem 3
% Zero void content
syms rhoM rhoF
rho1 = 1.626;
rho2 = 1.687;
vf1 = 0.66;
vf2 = 0.73;

eq1 = rho1 == rhoF*vf1 + rhoM*(1 - vf1);
eq2 = rho2 == rhoF*vf2 + rhoM*(1 - vf2);
soln1 = solve([eq1, eq2], [rhoM rhoF]);
rhoM1 = double(soln1.rhoM)
rhoF1 = double(soln1.rhoF)

% 5% void content
eq1 = rho1 == rhoF*vf1 + rhoM*(1 - vf1 - 0.05);
eq2 = rho2 == rhoF*vf2 + rhoM*(1 - vf2 - 0.05);
soln2 = solve([eq1, eq2], [rhoM rhoF]);
rhoM2 = double(soln2.rhoM);
rhoF2 = double(soln2.rhoF);