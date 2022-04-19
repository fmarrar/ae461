function [eps_yyp, eps_yy, eps_xxp] = extractData(filename)
data = readtable(filename);
eps = data(:,2:4);
eps_yyp = reshape(table2array(eps(:,1)), [1, 6])*10^(-6);
eps_yy = reshape(table2array(eps(:,2)), [1, 6])*10^(-6);
eps_xxp = reshape(table2array(eps(:,3)), [1, 6])*10^(-6);
end