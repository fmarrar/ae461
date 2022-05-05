function output = isclose(theo, exp, rtol)
if abs(theo - exp)/abs(theo) < rtol
    output = true;
else
    output = false;
end
end