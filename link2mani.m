function ydot = link2mani(tspan,y0)

% app = load_app();

% m1 = app.m1
% m2 = app.m2 
% a1 = app.a1
% a2 = app.a2
% [m1, m2, a1, a2] = load('variables2.mat');
m1 = 1; m2 = 1; a1 = 1; a2 = 1;
req_var = load('variables_2.mat');
% [m1, m2, a1, a2] = req_var.sv;
m1 = req_var.sv(1);
m2 = req_var.sv(2);
a1 = req_var.sv(3);
a2 = req_var.sv(4);
g = 9.81; iner21 = m2*a1*a2;
tau1 = 0; tau2 = 0;
 
th1 = y0(1); th2 = y0(2); th1d = y0(3); th2d = y0(4);
%th1 = 0; th2 = 0; th1d = 0; th2d =0;

sth2 = sin(th2); cth2 = cos(th2);
i22 = m2*a2*a2/3;
i21 = i22 + iner21*cth2/2; i12 = i21;
i11 = i22 +m1*a1*a1/3 +m2*a1*a1 + iner21*cth2;
im = [i11, i12; i21, i22];

h1 = -(m2*a1*a2*th1d + iner21/2*th2d)*th2d*sth2;
h2 = iner21/2*sth2*th1d*th1d;
hv = [h1;h2];

cth1 = cos(th1);
cth12 = cos(th1 + th2);
gam1 = m1*g*a1/2*cth1 + m2*g*(a1*cth1 + a2/2*cth12);

gam2 = m1*g*a2/2*cth12; gv = [gam1; gam2];

tau = [tau1;tau2];
phi = tau - hv -gv; thdd = im\phi;
ydot = [y0(3);y0(4);thdd(1);thdd(2)];
end