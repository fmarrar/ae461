clear; clc; close all
N = 801;
X = zeros(1, N, 17); % Frequency (Hz)
R = zeros(1, N, 17); % Real Peaks 
I = zeros(1, N, 17); % Imag Peaks 
Mag = zeros(1, N, 17); % Amplitude
P = zeros(1, N, 17); % Phase (deg)

for i=1:17
    if i < 10
        filename = append('4192-0', int2str(i), '.csv');
    else
        filename = append('4192-', int2str(i), '.csv');
    end
    data = table2array(readtable(filename));
    X(:,:,i) = data(:,1);
    R(:,:,i) = data(:,2);
    I(:,:,i) = data(:,3);
    Mag(:,:,i) = data(:,4);
    P(:,:,i) = data(:,5);
end