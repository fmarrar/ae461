function [tr, Mp, ts] = analyze_step(file, rtol)
[t, theta] = extractData(file);

theta_r_l = 0.1*0.5;
theta_r_u = 0.9*0.5;
theta_Mp = 0.5 - 0.01;

for i=1:length(theta)
    thetai = theta(i);
    if isclose(theta_r_l, thetai, rtol)
        tl = t(theta == thetai);
    end
    
    if isclose(theta_r_u, thetai, rtol)
        tu = t(theta == thetai);
    end

    if isclose(theta_Mp, thetai, rtol)
        ts = t(theta == thetai);
    end
end
Mp = (max(theta) - 0.5)*100;
tr = tu(1) - tl(1);
ts = ts(1);
end