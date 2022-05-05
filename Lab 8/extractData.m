function [t, theta] = extractData(file)
data = csvread(append(file, '.csv'));
t = data(:,1);
theta = data(:,2);
end