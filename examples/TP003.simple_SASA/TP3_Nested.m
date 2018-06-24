%--------------------------------------------------------------------------
% TP3_Nested.m
% Solve the simple SASA problem using a simple implementation of the nested
% co-design solution strategy
%--------------------------------------------------------------------------
%
%--------------------------------------------------------------------------
% Primary contributor: 
%  Daniel R. Herber (danielrherber), Univ. of Illinois at Urbana-Champaign
% Project link:
%  https://github.com/danielrherber/co-design-examples-repository
%--------------------------------------------------------------------------
function [k,theta,costs] = TP3_Nested(p,k0,x0,iterflag)
% initial guess
X0 = x0;

% discretized variable indices in x = [y1,y2,u];
p.y1i = 1:p.nt; p.y2i = p.nt+1:2*p.nt; p.ui = 2*p.nt+1:3*p.nt;

% initialize global variables to compute computational costs
global Ti Ni
Ti = 0; Ni = 0;

% inner-loop fmincon options
options2 = optimoptions(@fmincon,'display','none','MaxFunctionEvaluations',1e7,...
    'MaxIterations',10000,'ConstraintTolerance',1e-14);

% outer-loop fmincon optionsP
options = optimoptions(@fmincon,'display',iterflag,'MaxFunctionEvaluations',1e7,...
    'MaxIterations',10000,'ConstraintTolerance',1e-14);

% solve
tic
[xopt,theta,~,output] = fmincon(@(k) TP3_Inner(k,p,X0,options2),k0,[],[],[],[],[],[],[],options);
T = toc;

% extract
k = xopt(1);

% computation costs
costs.T = T; % total time
costs.N = output.iterations+1; % missing initial iteration
costs.Tb = costs.T/costs.N; % average time per iteration
costs.Nbi = Ni/costs.N; % average inner-loop calls per outer-loop iteration
costs.Tbi = Ti/Ni; % average inner-loop cost per call
costs.Tbo = (costs.T-Ti)/costs.N; % average additional outer-loop cost per iteration

end
%
function F = TP3_Inner(k,p,X0,options)
    t1 = toc;
    [X0,F] = fmincon(@(x) TP3_Obj(x,p),X0,[],[],[],[],[],[],@(x) TP3_Con(x,k,p),options);
    t2 = toc;

    global Ti Ni
    Ti = Ti + (t2-t1);
    Ni = Ni + 1;
end
%--------------------------------------------------------------------------
% objective
function F = TP3_Obj(x,p)
y1 = x(p.y1i); % extract
F = -y1(end); % objective
end
%--------------------------------------------------------------------------
% constraints
function [c,ceq] = TP3_Con(x,k,p)
y1 = x(p.y1i); y2 = x(p.y2i); u = x(p.ui); % extract
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