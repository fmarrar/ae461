function [E, v] = analyze_bending(material, Ixx, P, L)
if material == 'Aluminum'
    [eps_yyp_1, eps_yy_1, eps_xxp_1] = extractData('Al_bending_123.txt'); % in/in
    [eps_yyp_2, eps_yy_2, eps_xxp_2] = extractData('Al_bending_456.txt'); % in/in
else
    [eps_yyp_1, eps_yy_1, eps_xxp_1] = extractData('comp_bending_123.txt'); % in/in
    [eps_yyp_2, eps_yy_2, eps_xxp_2] = extractData('comp_bending_456.txt'); % in/in
end

N = length(eps_yyp_1);
% Transverse strain
eps_xx_1 = eps_xxp_1 + eps_yyp_1 - eps_yy_1;
eps_xx_2 = eps_xxp_2 + eps_yyp_2 - eps_yy_2;

% Shear strain
gamma1 = eps_xxp_1 - eps_yyp_1;
gamma2 = eps_xxp_2 - eps_yyp_2;

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
sigmayy1 = ro/Ixx * M1;
sigmayy2 = ro/Ixx * M2;

% Best line fit through sigmay vs epsy
p1_Bending = polyfit(eps_yy_1, sigmayy1, 1);
p2_Bending = polyfit(eps_yy_2, sigmayy2, 1);

% Young's Modulus
E = (p1_Bending(1) + p2_Bending(1))/2;

% Best line fit through epsx vs epsy
p1_Bending = polyfit(eps_yy_1, eps_xx_1, 1);
p2_Bending = polyfit(eps_yy_2, eps_xx_2, 1);

% Poisson Ratio
v = abs((p1_Bending(1) + p2_Bending(1)))/2;
end