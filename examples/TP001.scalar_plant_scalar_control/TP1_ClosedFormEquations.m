%--------------------------------------------------------------------------
% TP1_ClosedFormEquations.m
% Closed-form equations for Test Problem 1: Scalar Plant, Scalar Control in
% DETC2017-67668
%--------------------------------------------------------------------------
%
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/co-design-examples-repository
%--------------------------------------------------------------------------
function out = TP1_ClosedFormEquations

% initialize
syms b positive % plant variable
syms k positive % control variable (feedback gain)
syms t r q wc wp positive
syms x0 
syms x(t)

Dx = diff(x,t);

% solve for x
x = dsolve(Dx == -b*x - (k*x), x(0) == x0);

% integrand
I = simplify( q*x^2 + r*(k*x)^2 );

% objective function
Psi = wc*int( I, t, 0, Inf)/(x0^2) + wp*b;
Psi = simplify(Psi,'steps',100);

%%--- nested co-design
% stationary condition
DPsiDk = diff(Psi,k);

% optimal control for given plant variable
k_nested = solve(DPsiDk==0,k);
k_nested = simplify(k_nested,'steps',100);

% inner-loop objective function value
Psi_nested = subs(Psi,'k',k_nested);
Psi_nested = simplify(Psi_nested,'steps',100);
%%--- nested co-design

% minimum
DPsi_nestedDb = diff(Psi_nested,b);
b_optimal = solve(DPsi_nestedDb==0,b);

Psi_optimal = subs(Psi_nested,'b',b_optimal);
Psi_optimal = simplify(Psi_optimal,'steps',100);

k_optimal = subs(k_nested,'b',b_optimal);
k_optimal = simplify(k_optimal,'steps',100);

% gradient
gPsi = gradient(Psi, [b,k]);
gPsib = gPsi(1);
gPsik = gPsi(2);

% create matlab functions
out.Psi = matlabFunction(Psi);
out.nested.k = matlabFunction(k_nested);
out.nested.Psi = matlabFunction(Psi_nested);
out.gradPsi.b = matlabFunction(gPsib);
out.gradPsi.k = matlabFunction(gPsik);
out.optimal.Psi = matlabFunction(Psi_optimal);
out.optimal.b = matlabFunction(b_optimal);
out.optimal.k = matlabFunction(k_optimal);

end