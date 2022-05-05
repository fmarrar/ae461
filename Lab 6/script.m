clear all; clc; close all
%% Question 1

%%% Part a
vf = [0.6-0.05, 0.6+0.05];
vm = ones(1, length(vf)) - vf;

Em = 2.4e9;
Ef = 120e9;
nuM = 0.35;
nuF = 0.32;
Gm = Em/(2*(1 + 0.35));
Gf = Ef/(2*(1 + 0.32));

Ex = (vf*Ef + vm*Em)*1e-9
Ey = (1./(1/Ef * vf + 1/Em * vm))*1e-9
vxy = nuF*vf + nuM*vm
Gxy = (1./(1/Gf * vf + 1/Gm * vm))*1e-9

%%% Part b
Exavg = mean(Ex)
Exstd = std(Ex)

Eyavg = mean(Ey)
Eystd = std(Ey)

vxyavg = mean(vxy)
vxystd = std(vxy)

Gxyavg = mean(Gxy)
Gxystd = std(Gxy)

%% Question 2
Ex = 181;
Ey = 10.3;
vxy = 0.28;
Gxy = 7.17;

c = 1/(1 - vxy^2 * Ey/Ex);

Q11bar = c*Ex;
Q22bar = c*Ey;
Q12bar = c*vxy*Ey;
Q66bar = Gxy;

theta = linspace(0, pi/2, 101);
m = cos(theta);
n = sin(theta);
Q11 = m.^4*Q11bar + n.^4*Q22bar + 2*m.^2 .* n.^2*Q12bar + 4*m.^2 .* n.^2*Q66bar;

figure(1), clf, hold on, grid on;
plot(rad2deg(theta), Q11, 'LineWidth',2);
xlabel('$\theta$ (deg)', 'Interpreter','latex')
ylabel('In-plane longitudinal stiffness (GPa)','Interpreter','latex')

%%% Part a 
thetaA = rad2deg(theta(40)) % One-half
thetaB = rad2deg(theta(50)) % One-third

%%% Part b
thetaC = rad2deg(theta(16)) % 10% drop

%% Question 3
Q16 = m.^3 .* n * Q11bar - m .* n.^3 * Q22bar + (m .* n.^3 - m.^3 .* n)*Q12bar + 2*(m .* n.^3 - m.^3 .* n)*Q66bar;

theta3 = rad2deg(theta(Q16 == max(Q16)))

%%% Part a
% Yes, $Q_{16,max}$ is a function of the material's consitutive
% properties, since the equation for $Q_{16}$ is coupled (shear strain
% appears in axial stress and vice versa).

%%% Part b
% $Q_{16}$ and $Q_{26}$ represent the coupling between the shear and
% extension, only seen in anistropic materials.

%%% Part c
% No, they do not appear in isotropic constitutive relations, since there
% is symmetry along the material axes (no coupling between shear and
% extension)

%% Question 4
Ex = 38.6e9;
Ey = 8.27e9;
vxy = 0.26;
Gxy = 4.14e9;

X = 1062e6;
Xp = 610e6;
Y = 31e6;
Yp = 118e6;
S = 72e6;

F1bar = 1/X - 1/Xp;
F2bar = 1/Y - 1/Yp;

F11bar = 1/(X*Xp);
F22bar = 1/(Y*Yp);
F12bar = -1/2 * sqrt(F11bar * F22bar);
F66bar = 1/S^2;

theta = deg2rad(15);
m = cos(theta);
n = sin(theta);

F1 = m^2*F1bar + n^2*F2bar;
F11 = m^4*F11bar + n^4*F22bar + 2*m^2*n^2*F12bar + 4*m^2*n^2*F66bar;

z = roots([F11, F1, -1]);

sigma_compress = z(sign(z) == -1)*1e-6
sigma_tensile = z(sign(z) == 1)*1e-6

%% Question 5
% No. Since the constraint was derived assuming incompressibility for
% istropic materials and the definition of bulk modulus. Since composites
% are comprised of more than one material, the bounds do not hold.