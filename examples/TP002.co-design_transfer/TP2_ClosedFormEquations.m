%--------------------------------------------------------------------------
% TP2_ClosedFormEquations.m
% Closed-form equations for Test Problem 2: Co-Design Transfer
%--------------------------------------------------------------------------
%
%--------------------------------------------------------------------------
% Primary contributor: 
%  Daniel R. Herber (danielrherber), Univ. of Illinois at Urbana-Champaign
% Project link:
%  https://github.com/danielrherber/co-design-examples-repository
%--------------------------------------------------------------------------
function TP2_ClosedFormEquations
% initialize
syms t f y0 v0 k c d
syms y(t)

Dy = diff(y,t);
DDy = diff(Dy,t);

%% nonzero k solution
% unscaled control solution
a = sin((f-t))*sin(f) - f*sin(t);
b = -cos(f-t)*sin(f) + f*cos(t);
u = -(2)/(f^2 - sin(f)^2)*(a*y0 + b*v0);

% solve the differential equation
ysol = dsolve( DDy == -y + u, y(0) == y0, Dy(0) == v0);
ysol = simplify(ysol,'steps',100);

% apply the scaling to the states
ysol = subs(ysol,'t',sqrt(k)*t);
ysol = subs(ysol,'f',sqrt(k)*f);
ysol = subs(ysol,'v0',v0/sqrt(k));
ysol = simplify(ysol,'steps',100);

% apply the scaling to the control
u = subs(u,'t',sqrt(k)*t);
u = subs(u,'f',sqrt(k)*f);
u = subs(u,'v0',v0/sqrt(k));
u = k*u;
u = simplify(u,'steps',100);

% objective
PSI = int(u^2,t,0,f);
PSI = simplify(PSI,'steps',1000);

%% zero k solution
% the control is linear
c = (6*(2*y0 + f*v0))/f^3;
d = -(2*(3*y0 + 2*f*v0))/f^2;
uk0 = c*t + d;
uk0 = simplify(uk0,'steps',100);

% solve the differential equation
ysolk0 = dsolve( DDy == uk0, y(0) == y0, Dy(0) == v0 );
ysolk0 = simplify(ysolk0,'steps',100);

% objective
PSIk0 = int(uk0^2,t,0,f);
PSIk0 = simplify(PSIk0,'steps',1000);

%% 
% output parameters
path = msavename(mfilename('fullpath'),'');
probname = 'TP2';

% save the functions
matlabFunction(u,'file',[path,probname,'_U'],'vars',{'t','f','y0','v0','k'});
matlabFunction(ysol,'file',[path,probname,'_X'],'vars',{'t','f','y0','v0','k'});
matlabFunction(PSI,'file',[path,probname,'_PSI'],'vars',{'t','f','y0','v0','k'});
matlabFunction(uk0,'file',[path,probname,'_Uk0'],'vars',{'t','f','y0','v0'});
matlabFunction(ysolk0,'file',[path,probname,'_Xk0'],'vars',{'t','f','y0','v0'});
matlabFunction(PSIk0,'file',[path,probname,'_PSIk0'],'vars',{'t','f','y0','v0'});

end