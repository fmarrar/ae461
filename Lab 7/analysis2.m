clear all; clc; close all
%% Determining the damping coefficient
data1 = csvread('STEP1.csv');
t = data1(:,1);
theta = data1(:,2);
% Find the peaks and the corresponding index in the dataset
[pks, idx] = findpeaks(theta);
N = 6;
deltas = zeros(1, N);
zetas = zeros(1, N);

figure(1), clf, hold on, grid on;
plot(t, theta, 'LineWidth',2)
plot(t(idx(1:7)), theta(idx(1:7)), '.', 'MarkerSize',18)
xlabel('t (s)', 'Interpreter','latex', 'FontSize',12)
ylabel('$\theta$ (rad)', 'Interpreter','latex', 'FontSize',12)
legend({'$\theta$ vs. $t$', 'Peaks'}, 'Interpreter','latex', 'fontsize', 12)
saveas(figure(1), 'InitialResponse.eps', 'epsc')

% Calculate the decrements and damping coefficient using the first 6 peaks
for k=1:N
    deltas(k) = 1/k * log(pks(k)/pks(k+1));
    zetas(k) = deltas(k)/sqrt(4*pi^2 + deltas(k)^2);
end

% Average damping coefficient
zeta = mean(zetas);

%% Determining the period, damped natural frequency, and mass moment of inertia
periods = zeros(1, N);

% Calculate the time elapsed between adjacent peaks for the first 6 peaks
for i=1:N
    periods(i) = t(idx(i+1)) - t(idx(i));
end

% Average period
Td = mean(periods);

% Damped frequency
omega_d = 2*pi/Td;

% Damped natural frequency
omega_n = omega_d/sqrt(1 - zeta^2);

m = 0.411; % kg
g = 9.8; % m/s^2
l = 0.02794; % m

% Mass moment of inertia
J0 = m*g*l/omega_n^2; % kg m^2/rad^2

%% Determining the Gain and Friction input offset
pksV = zeros(1, N);
V = 2:7;

% Plotting the data
for i=2:N+1
    filename = append('STEP2_', int2str(i), 'V.csv');
    dataSet = csvread(filename);
    theta = dataSet(:,2);
    pks = findpeaks(theta);
    pksV(i-1) = pks(end);
end

% Line fit through the data
p = polyfit(V, pksV, 1);
figure(2), clf, hold on, grid on;
plot(V, pksV, 'b.', 'MarkerSize',12)
plot(V, polyval(p, V), 'LineWidth',2);
text(4, 0.1, ...
    sprintf('{\\theta_{ss} = %0.5g + %0.5g\\itV}', p(2), p(1)), 'FontSize',12);

xlabel('Voltage (V)', 'Interpreter','latex', 'FontSize',12)
ylabel('Steady-State Angle (rad)', 'Interpreter','latex', 'FontSize',12)
legend({'Data ($\theta_{ss}$)', 'Fit ($\beta_0 + \beta_1 V$)'}, ...
    'Interpreter','latex', 'Location','northwest', 'FontSize',11)
xticks(V)
saveas(figure(2), 'SteadyState.eps', 'epsc')

% Friction offset
Fs = p(2)/p(1);
% Gain
Km = p(1);