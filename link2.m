%clear all % Input for trajectory and link parameters T = 10; thlT = pi; th10 = 0; th2T = pi/2; th20 = 0; m1 = 1; m2 = 1; a1 = 1; a2 = 1; g = 9.81; con = 2*pi/T; delta = tlT - th10: delth2 = th2T m2*al*a2;
function [ti, th1, th2, tor1, tor2] = link2(th1T, th10, th2T, th20, m1, m2, a1, a2)
%  th1T = pi; th10 = 0; th2T = pi/2; th20 = 0;
% m1 = 1; m2 = 1; a1 = 1; a2 = 1;
T = 10;
 g = 9.81;
con = 2*pi/T; delth1 = th1T - th10; delth2 = th2T - th20;
iner21 = m2*a1*a2;
for i = 1:51
    ti(i) = (i-1)*T/50;
    ang = con*ti(i);
    %Joint trajectory 
    th1(i) = th10 + (delth1/T)*(ti(i) - sin(ang)/con);
    th1d(i) = delth1*(1- cos(ang))/T;
    th1dd(i) = delth1*con*sin(ang)/T;
    th2 (i) = th20 + (delth2/T)*(ti(i) - sin(ang)/con);
    th2d(i) = delth2*(1- cos(ang))/T;
    th2dd(i) = delth2*con*sin(ang)/T;
    thdd = [th1dd(i); th2dd(i)];

% Inertia matrix 
sth2 = sin(th2(i)); cth2 = cos(th2(i));
i22 = m2*a2*a2/3; i21 = i22 + iner21*cth2/2;
i12 = i21;
i11 = i22 + m1*a1*a1/3 + m2*a1*a1 + iner21*cth2;
im = [i11, i12; i21, i22];

%h-vector 
h1 = -(m2*a1*a2*th1d(i) + iner21/2*th2d(i))*th2d(i)*sth2;
h2 = iner21/2*sth2*th1d(i)*th1d(i);
hv = [h1 ; h2];


%Gamma-vector
cth1 = cos(th1(i));
cth12 = cos(th1(i) + th2(i));
gam1 = m1*g*a1/2*cth1 + m2*g*(a1*cth1 + a2/2*cth12);

gam2 = m1*g*a2/2*cth12; gv = [gam1; gam2];

%Joint torque 
tau = im*thdd + hv + gv;
tor1(i) = tau(1); tor2(i) = tau(2);
end
% plot(app.UIAxes, t,x);
% plot (app.UIAxesAngle,ti, th1,'-',ti, th2,':')
% figure
% 
% plot (app.UIAxesTorque, ti, tor1,'-',ti, tor2,':')
end



