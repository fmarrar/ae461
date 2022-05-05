function Aij = computeAij(Qij, z)
Aij = zeros(6, 6);
n = length(z);

for k=1:n-1
    Aij(1,1) = Aij(1,1) + Qij(1,1)*(z(k+1) - z(k));
    Aij(2,2) = Aij(2,2) + Qij(2,2)*(z(k+1) - z(k));
    Aij(1,2) = Aij(1,2) + Qij(1,2)*(z(k+1) - z(k));
    Aij(2,1) = Aij(1,2);
    Aij(6,6) = Aij(6,6) + Qij(6,6)*(z(k+1) - z(k));
    Aij(1,6) = Aij(1,6) + Qij(1,6)*(z(k+1) - z(k));
    Aij(6,1) = Aij(1,6);
    Aij(2,6) = Aij(2,6) + Qij(2,6)*(z(k+1) - z(k));
    Aij(6,2) = Aij(2,6);
end
end