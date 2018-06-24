%--------------------------------------------------------------------------
% TP3_Simultaneous.m
% Solve the simple SASA problem using a simple implementation of the 
% simultaneous co-design solution strategy
%--------------------------------------------------------------------------
%
%--------------------------------------------------------------------------
% Primary contributor: 
%  Daniel R. Herber (danielrherber), Univ. of Illinois at Urbana-Champaign
% Project link:
%  https://github.com/danielrherber/co-design-examples-repository
%--------------------------------------------------------------------------
function [k,theta,costs] = TP3_Simultaneous(p,k0,x0,iterflag)
% discretized variable indices in x = [y1,y2,u,k];
p.y1i = 1:p.nt; p.y2i = p.nt+1:2*p.nt; p.ui = 2*p.nt+1:3*p.nt; p.ki = 3*p.nt+1;

% initial guess
X0 = [x0;k0];

% fmincon options
options = optimoptions(@fmincon,'display',iterflag,'MaxFunctionEvaluations',...
    1e7,'MaxIterations',10000,'ConstraintTolerance',1e-14);

% solve
tic
[xopt,theta,~,output] = fmincon(@(x) TP3_Obj(x,p),X0,...
    [],[],[],[],[],[],@(x) TP3_Con(x,p),options);
T = toc;

% extract
k = xopt(p.ki);

% computation costs
costs.T = T;
costs.N = output.iterations+1; % missing initial iteration
costs.Tb = costs.T/costs.N;
end
%--------------------------------------------------------------------------
% objective
function F = TP3_Obj(x,p)
    y1 = x(p.y1i); % extract
    F = -y1(end); % objective
end
%--------------------------------------------------------------------------
% constraints
function [c,ceq] = TP3_Con(x,p)
y1 = x(p.y1i); y2 = x(p.y2i); u = x(p.ui); k = x(p.ki); % extract
Y = [y1,y2]; F = [y2,-k/p.J*y1 + u/p.J]; % create matrices (p.nt x p.ns)
ceq1 = y1(1) - p.y10; % initial state 1 conditions 
ceq2 = y2(1) - p.y20; % initial state 2 conditions
ceq4 = y2(end) - p.y2f; % final state 2 conditions
% defect constraints
ceq5 = Y(2:p.nt,1) - Y(1:p.nt-1,1) - p.h/2.*( F(1:p.nt-1,1) + F(2:p.nt,1) );
ceq6 = Y(2:p.nt,2) - Y(1:p.nt-1,2) - p.h/2.*( F(1:p.nt-1,2) + F(2:p.nt,2) );
ceq = [ceq1;ceq2;ceq4;ceq5;ceq6]; % equality constraints
c = [u-p.umax;-u-p.umax]; % inequality constraints
end