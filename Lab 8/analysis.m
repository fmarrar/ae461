clear all; clc; close all;
%% Parameters
wn = 3.8918;
zeta = 0.0044;
KI = 6;
Kd = 6;
Kp = 0.6;
Km = 0.0642;
tau = 0.4;
% PID transfer function
H = tf([Km*wn^2*Kp, Km*wn^2*KI],...
    [tau,...
    2*tau*wn*zeta + 1,...
    Kd*Km*wn^2 + tau*wn^2 + 2*wn*zeta,...
    wn^2 + Km*Kp*wn^2, KI*Km*wn^2]);

%% Root Locus Plots
rlocus(H)
%% Experimental vs Theoretical Models
% Rise time, percent overshoot, and settling time for experimental data
[tr_i, Mp_i, ts_i] = analyze_step('InitialController', 1e-2);

% 3rd Order Simulated Model
t_sim_3 = 0:0.01:28.825;
theta_sim_3 = 0.5*step(H, t_sim_3);
% 2nd Order Simulated Model
[t_sim_2, theta_sim_2] = extractData('2ndOrder');
% Experimental Data
[t_exp, theta_exp] = extractData('InitialController');

% Plotting 3rd Order simulation and Experimental
figure(1), clf, hold on, grid on;
set(gca, 'DefaultLineLineWidth', 2)
plot(t_exp, theta_exp)
plot(t_sim_3, theta_sim_3, '--')
xlabel('Time (s)', 'FontSize',13, 'Interpreter','latex')
ylabel('Pendulum Angle (rad)', 'FontSize',13, 'Interpreter','latex')
legend({'Experimental Data', 'Third-Order Simulated Data'}, ...
    'Location','southeast', 'FontSize',12, 'Interpreter','latex')
saveas(figure(1), 'ExpVsThird.eps', 'epsc')

% Plotting 2rd Order simulation and Experimental
figure(2), clf, hold on, grid on;
set(gca, 'DefaultLineLineWidth', 2)
plot(t_exp, theta_exp)
plot(t_sim_2, theta_sim_2, '--')
xlabel('Time (s)', 'FontSize',13, 'Interpreter','latex')
ylabel('Pendulum Angle (rad)', 'FontSize',13, 'Interpreter','latex')
legend({'Experimental Data', 'Second-Order Simulated Data'}, ...
    'Location','southeast', 'FontSize',12, 'Interpreter','latex')
saveas(figure(2), 'ExpVsSecond.eps', 'epsc')

%% Integral Windup
[t_Int_1, theta_Int_1] = extractData('IntegralWindup1'); % Integral value before/without windup
[t_Int_2, theta_Int_2] = extractData('IntegralWindup2'); % Integral value after windup

% Plotting the value of the integral term before/without windup
figure(3), clf, hold on, grid on;
set(gca, 'DefaultLineLineWidth', 2)
plot(t_Int_1, theta_Int_1)
xlabel('Time (s)', 'FontSize',13, 'Interpreter','latex')
ylabel('Integral Value', 'FontSize',13, 'Interpreter','latex')
saveas(figure(3), 'IntValueWO.eps', 'epsc')

% Plotting the value of the integral term during/after windup
figure(4), clf, hold on, grid on;
set(gca, 'DefaultLineLineWidth', 2)
plot(t_Int_2, theta_Int_2)
xlabel('Time (s)', 'FontSize',13, 'Interpreter','latex')
ylabel('Integral Value', 'FontSize',13, 'Interpreter','latex')
saveas(figure(4), 'IntValueW.eps', 'epsc')

%% Closed-loop bandwidths

% Theoretical Bode Plot
[mag, phase, wout] = bode(H);
figure(5), clf, hold on, grid on;
h = bodeplot(H, {0.1, 3});
setoptions(h, 'PhaseVisible', 'off', 'Grid', 'on')
% plot(wout, 20*log10(mag(:)), 'LineWidth',2)
% set(gca, 'XScale', 'log')
% xlabel('Frequency (rad/s)', 'Interpreter','latex')
% ylabel('Magnitude (dB)', 'Interpreter','latex')
% xlim([0.1 3])
% Several frequency responses
[t_0p1, amp1_0p1, amp2_0p1] = extractData2('CLB0.1'); % Second amplitude is output
[t_wb, amp1_wb, amp2_wb] = extractData2('CLB0.543');
[t_1p55, amp1_1p55, amp2_1p55] = extractData2('CLB1.55');
[t_3, amp1_3, amp2_3] = extractData2('CLB3');

T = {t_0p1(1:85639), t_wb, t_1p55, t_3};
Amp1 = {amp1_0p1(1:85639), amp1_wb, amp1_1p55, amp1_3};
Amp2 = {amp2_0p1(1:85639), amp2_wb, amp2_1p55, amp2_3};
fields = {'e1', 'e2', 'e3', 'e4'};

for i=1:numel(fields)
    t = T{i};
    amp1 = Amp1{i};
    amp2 = Amp2{i};
    figure(i), clf, hold on, grid on;
    set(gca, 'DefaultLineLineWidth', 2)
    plot(t, amp1)
    plot(t, amp2)
    xlabel('Time (s)', 'FontSize',13, 'Interpreter','latex')
    ylabel('Amplitude', 'FontSize',13, 'Interpreter','latex')
    legend({'Input', 'Output'}, ...
        'Location','best', 'FontSize',12, 'Interpreter','latex')
    saveas(figure(i), append('freq', int2str(i), '.eps'), 'epsc')
end