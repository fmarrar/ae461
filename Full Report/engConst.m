function [Ex, Ey, Gxy, nuXY] = engConst(Ef, Gf, nuF, Em, Gm, nuM, vf, vm)
Ex = vf*Ef + vm*Em;
nuXY = vf*nuF + vm*nuM;
Ey = 1/(vf/Ef + vm/Em);
Gxy = 1/(vf/Gf + vm/Gm);
end