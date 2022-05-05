function [Q11bar, Q22bar, Q12bar, Q66bar] = inplanestiffness(Ex, Ey, Gxy, nuXY)
c = 1/(1 - nuXY^2 * Ey/Ex);
Q11bar = c*Ex;
Q22bar = c*Ey;
Q12bar = c*nuXY*Ey;
Q66bar = Gxy;
end