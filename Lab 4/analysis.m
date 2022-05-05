clear all; clc; close all

%% Theoretical Buckling Load for Each Rod with no Eccentric Loading
% S1 (Euler Case 1)
L1 = 350e-3; % Length, meters x
w1 = 20.15e-3; % Width, meters z
t1 = 4.05e-3; % thickness, meters y
E1 = 210e9; % Young's Modulus, Pa
Iyy1 = 1/12 * w1 * t1^3; % Moment of inertia, m^4

S1T = pi^2*E1*Iyy1/L1^2;

% S2 (Euler Case 1)
L2 = 500e-3;
w2 = 20.20e-3;
t2 = 4.05e-3;
E2 = E1;
Iyy2 = 1/12 * w2 * t2^3;

S2T = pi^2*E2*Iyy2/L2^2;

% S3 (Euler Case 1)
L3 = 600e-3;
w3 = 20.10e-3;
t3 = 4.05e-3;
E3 = E1;
Iyy3 = 1/12 * w3 * t3^3;

S3T = pi^2*E3*Iyy3/L3^2;

% S4 (Euler Case 1)
L4 = 650e-3;
w4 = 20.20e-3;
t4 = 4.05e-3;
E4 = E1;
Iyy4 = 1/12 * w4 * t4^3;

S4T = pi^2*E4*Iyy4/L4^2;

% S5 (Euler Case 1)
L5 = 700e-3;
w5 = 20.20e-3;
t5 = 4.05e-3;
E5 = E1;
Iyy5 = 1/12 * w5 * t5^3;

S5T = pi^2*E5*Iyy5/L5^2; % Accounting for where the load cell started

% S6 (Euler Case 4)
L6 = 650e-3;
w6 = 20.15e-3;
t6 = 4.05e-3;
E6 = E1;
Iyy6 = 1/12 * w6 * t6^3;

S6T = pi^2*E6*Iyy6/(0.7*L6)^2;

% S7 (Euler Case 3)
L7 = 650e-3;
w7 = 20.20e-3;
t7 = 4.05e-3;
E7 = E1;
Iyy7 = 1/12 * w7 * t7^3;

S7T = 4*pi^2*E7*Iyy7/L7^2; % Accounting for where the load cell started

% S8 (Euler Case 1)
L8 = 600e-3;
w8 = 25.20e-3;
t8 = 6.10e-3;
E8 = 70e9;
Iyy8 = 1/12 * w8 * t8^3;

S8T = pi^2*E8*Iyy8/L8^2;

% S9 (Euler Case 1)
L9 = 600e-3;
w9 = 25.10e-3;
t9 = 6e-3;
E9 = 104e9;
Iyy9 = 1/12 * w9 * t9^3;

S9T = pi^2*E9*Iyy9/L9^3;

% S10 (Euler Case 1)
L10 = 600e-3;
w10 = 24.95e-3;
t10 = 6e-3;
E10 = 125e9;
Iyy10 = 1/12 * w10 * t10^3;

S10T = pi^2*E10*Iyy10/L10^2;
%% Eccentric Loading Beams
% SZ1 - Zero eccentricity
LSZ1 = 500e-3;
wSZ1 = 24.95e-3;
tSZ1 = 5.90e-3;
ESZ1 = 70e9;
IyySZ1 = 1/12 * wSZ1 * tSZ1^3;

wMaxSZ1 = 2.04e-3; % in meters
eSZ1 = 0;
SZ1T = ESZ1*IyySZ1*(2/LSZ1 * acos(1/(wMaxSZ1/eSZ1 + 1)))^2;

% SZ2 - 1 mm eccentricity
LSZ2 = LSZ1;
wSZ2 = 25.05e-3;
tSZ2 = tSZ1;
ESZ2 = ESZ1;
IyySZ2 = 1/12 * wSZ2 * tSZ2^3;

wMaxSZ2 = 3.69e-3; % in meters
eSZ2 = 2e-3;
SZ2T = ESZ2*IyySZ2*(2/LSZ2 * acos(1/(wMaxSZ2/eSZ2 + 1)))^2;

% SZ3 - 2 mm eccentricity
LSZ3 = LSZ1;
wSZ3 = 25e-3;
tSZ3 = tSZ1;
ESZ3 = ESZ1;
IyySZ3 = 1/12 * wSZ3 * tSZ3^3;

wMaxSZ3 = 3.5e-3;
eSZ3 = 3e-3;
SZ3T = ESZ3*IyySZ3*(2/LSZ3 * acos(1/(wMaxSZ3/eSZ3 + 1)))^2;

%% Demonstration Experiment
d2 = [16.5, 41, 67, 91, 115, 164, 216, 266, 316, 366, 417, 466]; %% mm
d2 = (d2 - d2(1)*ones(1, length(d2)))*10^(-2); % mm

F2 = [0, 175, 600, 700, 750, 800, 825, 850, 850, 860, 870, 870]; % N

figure(1), clf, hold on, grid on;
set(gca,'DefaultLineLineWidth',2);
plot(F2, d2);
xlabel('Compressive Force (N)', 'fontsize', 13, 'Interpreter','latex')
ylabel('Deflection (mm)', 'fontsize', 13, 'Interpreter','latex')
saveas(figure(1), 'Demonstration.eps', 'epsc')

%% Influence of Eccentric Loading
d1 = [4, 28, 53, 79, 153, 204, 254];
d1 = (d1 - d1(1)*ones(1, length(d1)))*10^(-2); % mm
F1 = [50, 775, 1000, 1100, 1100, 1125, 1125];

d2 = -[0, -0.26, -0.5, -0.75, -0.97, -1.22, -1.71, -2.2, -2.69, -3.19, -3.69]; % mm
F2 = [0, 100, 150, 225, 275, 350, 425, 500, 550, 600, 600];

d3 = -[0, -0.25, -0.51, -0.75, -1.0, -1.5, -2.0, -2.5, -3.0, -3.5];% mm
F3 = [50, 100, 150, 200, 250, 300, 375, 400, 450, 500];

figure(2), clf, hold on, grid on;
set(gca, 'DefaultLineLineWidth', 2);
plot(F1, d1);
plot(F2, d2);
plot(F3, d3, 'Color',[0 0.5 0]);
xlabel('Compressive Force (N)', 'fontsize', 13, 'Interpreter','latex')
ylabel('Deflection (mm)', 'fontsize', 13, 'Interpreter','latex')
legend({'e = 0 mm', 'e = 2 mm', 'e = 3 mm'}, 'Interpreter','latex', 'FontSize',13)
saveas(figure(2), 'Eccentric.eps', 'epsc')