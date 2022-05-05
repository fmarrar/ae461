function [Q11, Q22, Q12, Q66, Q16, Q26] = offaxisstiffness(Q11bar, Q22bar, Q12bar, Q66bar, theta)
m = cosd(theta);
n = sind(theta);

Q11 = m^4 * Q11bar + n^4 * Q22bar + 2*m^2*n^2*Q12bar + 4*m^2*n^2*Q66bar;
Q22 = n^4 * Q11bar + m^4 * Q22bar + 2*m^2*n^2*Q11bar + 4*m^2*n^2*Q66bar;
Q12 = m^2*n^2*Q11bar + m^2*n^2*Q22bar + (m^4 + n^4)*Q12bar - 4*m^2*n^2*Q66bar;
Q66 = m^2*n^2*Q11bar + m^2*n^2*Q22bar - 2*m^2*n^2*Q12bar + (m^2 - n^2)*Q66bar;
Q16 = m^3*n*Q11bar - m*n^3*Q22bar + (m*n^3 - m^3*n)*Q12bar + 2*(m*n^3 - m^3*n)*Q66bar;
Q26 = m*n^3*Q11bar - m^3*n*Q22bar + (m^3*n - m*n^3)*Q12bar + 2*(m^3*n - m*n^3)*Q66bar;
end