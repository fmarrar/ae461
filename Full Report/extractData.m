function [t, d, F, eps] = extractData(angle)
filename = append(int2str(angle), '_deg.csv');
data = table2array(readtable(filename));
t = data(:,1);
d = data(:,2);
F = data(:,3);
eps = data(:,4);
end