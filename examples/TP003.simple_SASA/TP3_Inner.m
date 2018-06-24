%--------------------------------------------------------------------------
% TP3_Inner.m
% Solves the inner-loop control problem with direct transcription for the
% simple SASA problem
%--------------------------------------------------------------------------
%
%--------------------------------------------------------------------------
% Primary contributor: 
%  Daniel R. Herber (danielrherber), Univ. of Illinois at Urbana-Champaign
% Project link:
%  https://github.com/danielrherber/co-design-examples-repository
%--------------------------------------------------------------------------
function [F,U,Y,p] = TP3_Inner(k,p)
%% preliminary
% extract
J = p.J; % inertia
nt = p.nt; % number of time points
umax = p.umax; % control maximum

% calculations
nx = 3*p.nt; % number of optimization variables
p.t0 = 0; % initial time
p.t = linspace(p.t0,p.tf,p.nt); % time mesh
h = p.t(2)-p.t(1); % step size

% indices
% X:optimization variables, U:controls, Y:states
% ordering: X = [U;Y1;Y2]
iU = 1:nt; % control indices in X
iY1 = nt+1:2*nt; % state 1 indices in X
iY2 = 2*nt+1:3*nt; % state 2 indices in X

%% objective function
iY1f = 2*p.nt; % index of the final value of the first state
vY1f = -1; % coefficient of the final value of the first state in objective 
f = sparse(iY1f,1,vY1f,3*p.nt,1,1) ;

%% bounds
% upper bounds
ub = inf(nx,1); % initialize
ub(iU) = umax; % U <= umax

% lower bounds
lb = -inf(nx,1); % initialize
lb(iU) = -umax; % U >= -umax

%% linear inequality constraints
A = []; b = []; % empty 

%% linear equality constraints
% initial value constraints
iY10 = nt+1; % index of the initial value of the 1st state
iY20 = 2*nt+1; % index of the initial value of the 2nd state
Aeq1 = sparse([1,2],[iY10,iY20],1,2,nx,2);
beq1 = [0;0];

% final value constraints
iY2f = 3*nt; % index of the final value of the 2nd state
Aeq2 = sparse(1,iY2f,1,1,nx,1);
beq2 = 0;

% defect constraints for state 1
nEntries = 4; % number of nonzero entries per defect constraint
iRows = repmat( 1:nt-1, 1, nEntries );
iCols = [ iY1(2:end), iY1(1:end-1), iY2(2:end), iY2(1:end-1) ];
iVals = kron( [1,-1,-h/2,-h/2], ones(1,nt-1) );
Aeq3 = sparse( iRows, iCols, iVals, nt-1, nx, nEntries*(nt-1) );
beq3 = sparse(nt-1,1);

% defect constraints for state 2
nEntries = 6; % number of nonzero entries per defect constraint
iRows = repmat( 1:nt-1, 1, nEntries );
iCols = [ iU(2:end), iU(1:end-1), iY1(2:end), iY1(1:end-1), iY2(2:end), iY2(1:end-1) ];
iVals = kron( [-h/(2*J), -h/(2*J), (h*k)/(2*J), (h*k)/(2*J), 1, -1], ones(1,nt-1) );
Aeq4 = sparse( iRows, iCols, iVals, nt-1, nx, nEntries*(nt-1) );
beq4 = sparse(nt-1,1);

% combine
Aeq = [Aeq1;Aeq2;Aeq3;Aeq4];
beq = [beq1;beq2;beq3;beq4];

%% solve as a LP (linear program)
options = optimoptions('linprog','Display','none',...
    'ConstraintTolerance',1e-9,'OptimalityTolerance',1e-10);
[X,F] = linprog(f,A,b,Aeq,beq,lb,ub,options);

%--- extract
if nargout > 1 % only do if requested
    U = X(iU); % controls
    Y = [X(iY1),X(iY2)]; % states
end