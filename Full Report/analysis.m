clear, clc, close all
rhoM = 1.15;
rhoF = 1.84;
Ef = 235e9;
Gf = 14e9;
nuF = 0.2;
Em = 2.5e9;
Gm = 1e9;
nuM = 0.25;
%% Extracting Data
[T0, d0, F0, eps0] = extractData(0);
[T45, d45, F45, eps45] = extractData(45);
[T90, d90, F90, eps90] = extractData(90);

%% Dimensions and Masses
% Before Curing

% Lengths (cm)
L0B = in2cm(7);
L45B = L0B;
L90B = L0B;

% Widths (cm)
w0B = in2cm(0.93);
w45B = in2cm(0.9);
w90B = in2cm(0.95);

% Thicknesses (cm)
t0B = in2cm(0.08);
t45B = in2cm(0.09);
t90B = in2cm(0.11);

% Masses (g)
m0B = 7.7989 - 0.3185 - 0.2843;
m45B = 15.8521 - 0.2862 - 0.2475;
m90B = 11.8783 - 0.2865 - 0.2904;

% After Curing

% Lengths (cm)
L0A = 10;
L45A = 9.7;
L90A = 10.2;

% Widths (cm)
w0A = 2.4458;
w45A = 2.3388;
w90A = 2.523;

% Thicknesses (cm)
t0A = 0.239;
t45A = 0.2586;
t90A = 0.3606;

% Masses (g)
m0A = 6.4332;
m45A = 9.2716;
m90A = 9.382;
%% Lab 1 Analysis
[rho0B, vf0B] = lab1_analysis(rhoM, rhoF, m0B, L0B, w0B, t0B);
[rho45B, vf45B] = lab1_analysis(rhoM, rhoF, m45B, L45B, w45B, t45B);
[rho90B, vf90B] = lab1_analysis(rhoM, rhoF, m90B, L90B, w90B, t90B);

[rho0A, vf0A] = lab1_analysis(rhoM, rhoF, m0A, L0A, w0A, t0A);
[rho45A, vf45A] = lab1_analysis(rhoM, rhoF, m45A, L45A, w45A, t45A);
[rho90A, vf90A] = lab1_analysis(rhoM, rhoF, m90A, L90A, w90A, t90A);

% Volumetric Shrinkage %
VS0 = abs(L0B*w0B*t0B - L0A*w0A*t0A)/(L0A*w0A*t0A) * 100;
VS45 = abs(L45B*w45B*t45B - L45A*w45A*t45A)/(L45A*w45A*t45A) * 100;
VS90 = abs(L90B*w90B*t90B - L90A*w90A*t90A)/(L90A*w90A*t90A) * 100;

% Force required by hot plate platens to achieve 150 psi
P = 6894.75729*150; % Pressure in Pa
F01 = P*(w0B*t0B*0.0001);
F451 = P*(w45B*t45B*0.0001);
F901 = P*(w90B*t90B*0.0001);
%% Lab 6
% Cross-sectional area (sqm)
A0 = w0A*t0A*0.0001;
A45 = w45A*t45A*0.0001;
A90 = w90A*t90A*0.0001;

% Tensile stress (Pa)
sigma0 = F0*10^3/A0;
sigma45 = F45*10^3/A45;
sigma90 = F90*10^3/A90;

figure(1), clf, hold on, grid on;
plot(eps0(129:389), sigma0(129:389), 'LineWidth',1.5);
xlabel('\epsilon', 'FontSize',13);
ylabel('\sigma (Pa)', 'FontSize',13);
saveas(figure(1), 'sigma0.eps', 'epsc')

figure(2), clf, hold on, grid on;
plot(eps45(1:343), sigma45(1:343), 'LineWidth',1.5);
xlabel('\epsilon', 'FontSize',13);
ylabel('\sigma (Pa)', 'FontSize',13);
saveas(figure(2), 'sigma45.eps', 'epsc')

figure(3), clf, hold on, grid on;
plot(eps90(1:22), sigma90(1:22), 'LineWidth',1.5);
xlabel('\epsilon', 'FontSize',13);
ylabel('\sigma (Pa)', 'FontSize',13);
saveas(figure(3), 'sigma90.eps', 'epsc')

%% Lab 6
z0 = [0.0025,0.0075,0.0125,0.0175]; 
z0 = cat(2, -flip(z0), z0);
z45 = [0.0025,0.0075,0.0125,0.0175,0.0225,0.0275,0.0325,0.0375];
z45 = cat(2, flip(z45), z45);
z90 = z45;

vv = 0.3;
%% 0 Degree Laminate Analysis
[Ex0, Ey0, Gxy0, nuXY0] = engConst(Ef, Gf, nuF, Em, Gm, nuM, vf0A, (1 - vf0A));
[Q11bar0, Q22bar0, Q12bar0, Q66bar0] = inplanestiffness(Ex0, Ey0, Gxy0, nuXY0);
[Q110, Q220, Q120, Q660, Q160, Q260] = offaxisstiffness(Q11bar0, Q22bar0, Q12bar0, Q66bar0, 0);
Qij0 = computeQij(Q110, Q220, Q120, Q660, Q160, Q260);
Aij0 = computeAij(Qij0, z0*0.0254);

%% 45 Degree Laminate Analysis
[Ex45, Ey45, Gxy45, nuXY45] = engConst(Ef, Gf, nuF, Em, Gm, nuM, vf45A, (1 - vf45A));
[Q11bar45, Q22bar45, Q12bar45, Q66bar45] = inplanestiffness(Ex45, Ey45, Gxy45, nuXY45);
[Q1145, Q2245, Q1245, Q6645, Q1645, Q2645] = offaxisstiffness(Q11bar45, Q22bar45, Q12bar45, Q66bar45, 45);
Qij45 = computeQij(Q1145, Q2245, Q1245, Q6645, Q1645, Q2645);

%% -45 Degree Laminate Analysis
[Exn45, Eyn45, Gxyn45, nuXYn45] = engConst(Ef, Gf, nuF, Em, Gm, nuM, vf45A, (1 - vf45A));
[Q11barn45, Q22barn45, Q12barn45, Q66barn45] = inplanestiffness(Exn45, Eyn45, Gxyn45, nuXYn45);
[Q11n45, Q22n45, Q12n45, Q66n45, Q16n45, Q26n45] = offaxisstiffness(Q11barn45, Q22barn45, Q12barn45, Q66barn45, -45);
Qijn45 = computeQij(Q11n45, Q22n45, Q12n45, Q66n45, Q16n45, Q26n45);

%% 90 Degree Laminate Analysis
[Ex90, Ey90, Gxy90, nuXY90] = engConst(Ef, Gf, nuF, Em, Gm, nuM, vf90A, (1 - vf90A));
[Q11bar90, Q22bar90, Q12bar90, Q66bar90] = inplanestiffness(Ex90, Ey90, Gxy90, nuXY90);
[Q1190, Q2290, Q1290, Q6690, Q1690, Q2690] = offaxisstiffness(Q11bar90, Q22bar90, Q12bar90, Q66bar90, 90);
Qij90 = computeQij(Q1190, Q2290, Q1290, Q6690, Q1690, Q2690);