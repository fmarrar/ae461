function [rho, vf] = lab1_analysis(rhoM, rhoF, m, L, w, t)
rho = m/(L*w*t);
vf = (rho - rhoM)/(rhoF - rhoM);
end