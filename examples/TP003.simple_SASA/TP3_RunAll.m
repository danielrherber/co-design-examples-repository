%--------------------------------------------------------------------------
% TP3_RunAll.m
% Obtain the computational results for various strategies for the simple 
% SASA test problem (TP3)
%--------------------------------------------------------------------------
%
%--------------------------------------------------------------------------
% Primary contributor: 
%  Daniel R. Herber (danielrherber), Univ. of Illinois at Urbana-Champaign
% Project link:
%  https://github.com/danielrherber/co-design-examples-repository
%--------------------------------------------------------------------------
close all; clear; clc

% direct transcription parameters
p.nt = 10; % 100, 1000

% problem parameters
p.tf = 2;
p.J = 1;
p.umax = 1;

% display
iterflag = 'none'; % 'iter'

% number of tests to run
ntests = 1;

% fixed for TP3
p.t0 = 0; p.y10 = 0; p.y20 = 0; p.y2f = 0;
p.t = linspace(p.t0,p.tf,p.nt)'; % time mesh
p.h = diff(p.t); % step size vector
p.ns = 2; p.nu = 1; % number of states and controls

% initial guess
k0 = 0;
x0 = zeros(p.nt*(p.ns+p.nu),1);

% run for each strategy multiple times
for idx = 1:ntests
	% simultaneous
	disp(' '); disp('simultaneous')
	[k,theta,costs] = TP3_Simultaneous(p,k0,x0,iterflag);
	disp(['    k : ',num2str(k)])
	disp(['theta : ',num2str(theta)])
	disp(costs)

	% nested (QP)
	disp(' '); disp('nested (QP)')
	[k,theta,costs] = TP3_NestedQP(p,k0,x0,iterflag);
	disp(['     k : ',num2str(k)])
	disp([' theta : ',num2str(theta)])
	disp(costs)

	% nested
	disp(' '); disp('nested')
	[k,theta,costs] = TP3_Nested(p,k0,x0,iterflag);
	disp(['     k : ',num2str(k)])
	disp([' theta : ',num2str(theta)])
	disp(costs)
end