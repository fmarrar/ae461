t = ScopeData(:,1);
theta = ScopeData(:,2);
[pks, idx] = findpeaks(theta);
first_7 = pks(1:7);
decrements = zeros(1, 6);

zetas = zeros(1, 7);
for k=1:length(first_7)-1
    decrements(k) = 1/k * log(pks(k)/pks(k+1));
    zetas(k) = decrements(k)/sqrt(4*pi^2 + decrements(k)^2);
end

zeta_avg = mean(zetas);
periods = zeros(1,length(first_7)-1);

for i=1:length(first_7)-1
    periods(i) = t(idx(i+1)) - t(idx(i));
end

period_avg = mean(periods);

omega_d = 2*pi/period_avg;
omega_n = omega_d/sqrt(1 - zeta_avg^2);

m = 0.411;
g = 9.8;
l = 0.02794;

J_0 = m*g*l/omega_n^2;


%% Gain
theta1V = table2array(STEP21V(:,2));
theta2V = table2array(STEP22V(:,2));
theta3V = table2array(STEP23V(:,2));
theta4V = table2array(STEP24V(:,2));
theta5V = table2array(STEP25V(:,2));
theta6V = table2array(STEP26V(:,2));
theta7V = table2array(STEP27V(:,2));

[pks1, idx1] = findpeaks(theta1V);
[pks2, idx2] = findpeaks(theta2V);
[pks3, idx3] = findpeaks(theta3V);
[pks4, idx4] = findpeaks(theta4V);
[pks5, idx5] = findpeaks(theta5V);
[pks6, idx6] = findpeaks(theta6V);
[pks7, idx7] = findpeaks(theta7V);

plot(1:7, [pks1(end), pks2(end), pks3(end), pks4(end), pks5(end), pks6(end), pks7(end)]) 