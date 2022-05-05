function Qij = computeQij(Q11, Q22, Q12, Q66, Q16, Q26)
Qij = zeros(6,6);
Qij(1,1) = Q11;
Qij(2,2) = Q22;
Qij(1,2) = Q12;
Qij(2,1) = Q12;
Qij(6,6) = Q66;
Qij(1,6) = Q16;
Qij(6,1) = Q16;
Qij(2,6) = Q26;
Qij(6,2) = Q26;
end