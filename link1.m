function [ti, th, thd, thdd, tau] = link1(thT, th0, m, a)

T = 10; 
%thT = pi; th0 = 0; m = 1; a = 1;
g = 9.81;

con = 2*pi/T; delth = thT -th0;
iner = m*a*a/3; grav = m*g*a/2;
for i = 1:51
    ti(i) = (i-1)*T/50;
    ang = con*ti(i);
    th(i) = th0 + (delth/T)*(ti(i) - sin(ang)/con);
    thd(i) = delth*(1 - cos(ang))/T;
    thdd(i) = delth*con*sin(ang)/T;
    tau(i) = iner*thdd(i) + grav*sin(th(i));
end

% plot(ti, th, '-', ti, thd, ':', ti, thdd, '-.');
% figure
% plot(ti, tau)

end