%--------------------------------------------------------------------------
% detc2017_67668_figure2.m
% Recreates the plots from Test Problem 1: Scalar Plant, Scalar Control in
% DETC2017-67668
%--------------------------------------------------------------------------
%
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% Link: https://github.com/danielrherber/co-design-examples-repository
%--------------------------------------------------------------------------
clear
close all

%% problem parameters
% these values are from DETC2017-67668 (can be changed)
q = 10; r = 1; x0 = 3; wc = 1; wp = 0.3;

%% obtain the closed-form functions
out = TP1_ClosedFormEquations;

%% all figures
fwidth = 550; % figure width in pixels
fheight = 550; % figure height in pixels
fontlabel = 20; % x,y label font size
fontlegend = 12; % x,y legend font size
fonttick = 16; % x,y rick font size
mycolor1 = [0.8500 0.3250 0.0980]; % custom color 1
mycolor2 = [0.4940 0.1840 0.5560]; % custom color 2
wcolor = [1 1 1]; % white color
bcolor = [0 0 0]; % black color

%% figure 1
% preliminary tasks
set(0,'DefaultTextInterpreter','latex'); % change the text interpreter
set(0,'DefaultLegendInterpreter','latex'); % change the legend interpreter
set(0,'DefaultAxesTickLabelInterpreter','latex'); % change the tick interpreter
hf = figure; % create a new figure and save handle
hf.Color = wcolor; % change the figure background color
hf.Position = [200 200 fwidth fheight]; % set figure size and position

% data
N = 600;
kv = linspace(0,8,N);
bv = linspace(0,8,N);
[B,K] = meshgrid(bv,kv);

% calculate objective function values
PSI = out.Psi(B,K,q,r,wc,wp);

% contour line locations
V = [10 5 4.5 4 3.5 3 2.75 2.5 2.4 2.3 min(PSI(:))];

% contour plot
[C2,h2] = contour(B,K,PSI,V,'linewidth',1,'linecolor',[0.3 0.3 0.3]); hold on

% contour line labels
v2 = [2.3 2.5 3 4];
clabel(C2,h2,v2,'FontSize',fontlegend,'interpreter','latex');

% plot the nested solution space
plot(bv,out.nested.k(bv,q,r),'color','k','linewidth',2); hold on

% initial valid solutions vector
valid = [1,2];

% filter k
k_optimal = out.optimal.k(q,r,wc,wp);
valid(k_optimal < 0) = nan;
valid(imag(k_optimal) ~= 0) = nan;

% filter b
b_optimal = out.optimal.b(q,r,wc,wp);
valid(b_optimal < 0) = nan;
valid(imag(b_optimal) ~= 0) = nan;

% if there is a valid index remaining (real, positive)
if ~all(isnan(valid))
    % calculate objective function value
    Psi_optimal = out.optimal.Psi(q,r,wc,wp);

    % remove nan
    valid(isnan(valid)) = [];
    
    % find minimum solution
    [Psi_optimal,I] = min(Psi_optimal(valid));
    k_optimal = k_optimal(valid(I));
    b_optimal = b_optimal(valid(I));
else
    % use fminbnd if a valid solution is not found (boundary solutions)
    [b_optimal,Psi_optimal] = fminbnd(@(b) out.nested.Psi(b,q,r,wc,wp),...
        0,1000,optimset('TolX',1e-12,'Display','iter'));
    k_optimal = out.nested.k(b_optimal,q,r);
end

% plot optimal solution
plot(b_optimal,k_optimal,'.','markersize',20,'color','k'); hold on

% make the axis equal
axis equal

% plot the gradient along the nested solution space
bv2 = linspace(0.25,7.75,10);
Gb = out.gradPsi.b(bv2,out.nested.k(bv2,q,r),q,r,wc,wp);
Gk = out.gradPsi.k(bv2,out.nested.k(bv2,q,r),q,r,wc);
quiver(bv2,out.nested.k(bv2,q,r), -Gb, -Gk,1,...
    'color',[225,100,98]/255,'linewidth',1.5)

% add axis labels
myxlabel = '$b \in x_p$'; % x label with latex
myylabel = '$K \in x_c$'; % y label with latex
xlabel(myxlabel) % create x label
ylabel(myylabel) % create y label

% change axis properties
ha = gca; % get current axis handle
ha.XAxis.Color = bcolor; % change the x axis color to black (not a dark grey)
ha.YAxis.Color = bcolor; % change the y axis color to black (not a dark grey)
ha.XAxis.FontSize = fonttick; % change x tick font size
ha.YAxis.FontSize = fonttick; % change y tick font size
ha.XAxis.Label.FontSize = fontlabel; % change x label font size
ha.YAxis.Label.FontSize = fontlabel; % change y label font size
ha.Layer = 'top'; % place the axes on top of the data
ha.YAxis.TickValues = 0:2:8;

% add a legend
mylegend = {'$\Psi(b,K)$','$\psi(b)$','Global mimina',...
    '$-\nabla \Psi(b,K)$'};
hl = legend(mylegend,'Location','northoutside','Orientation','horizontal');
hl.FontSize = fontlegend+1; % change legend font size
hl.EdgeColor = wcolor; % change the legend border to black (not a dark grey

% save a pdf version
mysavename = 'TP1_PSI'; % name to give the saved file
pathpdf = mfoldername(mfilename('fullpath'),'pdf');
filename = [pathpdf,mysavename];
str = ['export_fig ''',filename,''' -pdf'];
eval(str)

%% figure 2
% preliminary tasks
set(0,'DefaultTextInterpreter','latex'); % change the text interpreter
set(0,'DefaultLegendInterpreter','latex'); % change the legend interpreter
set(0,'DefaultAxesTickLabelInterpreter','latex'); % change the tick interpreter
hf = figure; % create a new figure and save handle
hf.Color = wcolor; % change the figure background color
hf.Position = [200 200 fwidth*4/6 fheight]; % set figure size and position

% plot nested objective function
plot(bv,out.nested.Psi(bv,q,r,wc,wp),'k','linewidth',2); hold on

% plot optimal solution
plot(b_optimal,Psi_optimal,'.','markersize',20,'color','k'); hold on

% add axis labels
myxlabel = '$b \in x_p$'; % x label with latex
myylabel = '$\psi(b)$'; % y label with latex

% change axis properties
xmin = min(bv); xmax = max(bv);
xlabel(myxlabel) % create x label
ylabel(myylabel) % create y label
xlim([xmin xmax]) % change x limits
ha = gca; % get current axis handle
ha.XAxis.Color = bcolor; % change the x axis color to black (not a dark grey)
ha.YAxis.Color = bcolor; % change the y axis color to black (not a dark grey)
ha.XAxis.FontSize = fonttick; % change x tick font size
ha.YAxis.FontSize = fonttick; % change y tick font size
ha.XAxis.Label.FontSize = fontlabel; % change x label font size
ha.YAxis.Label.FontSize = fontlabel; % change y label font size
ha.Layer = 'top'; % place the axes on top of the data

% save a pdf version
mysavename = 'TP1_nested'; % name to give the saved file
pathpdf = mfoldername(mfilename('fullpath'),'pdf');
filename = [pathpdf,mysavename];
str = ['export_fig ''',filename,''' -pdf'];
eval(str)