%one-link arm
function ydot = link1_for(t,y)

m = 2;
a = 2;
g = 9.81;
tau = 0;
iner = m*a*a/3; grav = m*g*a/2;
ydot = [y(2); (tau - grav*sin(y(1)))/iner];

end