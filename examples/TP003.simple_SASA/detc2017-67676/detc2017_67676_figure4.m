%--------------------------------------------------------------------------
% detc2017_67676_figure4.m
% Recreates the plots from Figure 4 in DETC2017-67676
%--------------------------------------------------------------------------
%
%--------------------------------------------------------------------------
% Primary contributor: 
%  Daniel R. Herber (danielrherber), Univ. of Illinois at Urbana-Champaign
% Project link:
%  https://github.com/danielrherber/co-design-examples-repository
%--------------------------------------------------------------------------
close all; clear

%% problem parameters
% these values are from DETC2017-67676 (can be changed)
umax = 0.5; f = 3; J = 3;
ct = f/(2*pi); % scaling constant for time

%% obtain the closed-form functions
out = TP3_ClosedFormEquations;

%% all figures
fwidth = 500; % figure width in pixels
fheight = 300; % figure height in pixels
fontlabel = 16; % x,y label font size
fontlegend = 14; % x,y legend font size
fonttick = 12; % x,y tick font size
mycolor1 = [0.8500 0.3250 0.0980]; % custom color 1
mycolor2 = [0.4940 0.1840 0.5560]; % custom color 2
wcolor = [1 1 1]; % white color
bcolor = [0 0 0]; % black color
rc = [225,99,97]/255; % red

%% figure for position
% preliminary tasks
set(0,'DefaultTextInterpreter','latex'); % change the text interpreter
set(0,'DefaultLegendInterpreter','latex'); % change the legend interpreter
set(0,'DefaultAxesTickLabelInterpreter','latex'); % change the tick interpreter
hf = figure; % create a new figure and save handle
hf.Color = wcolor; % change the figure background color
hf.Position = [200 200 fwidth fheight]; % set figure size and position

% scaled time grid
N = 100;
ts = out.scaled.ts;
t = sort([ts+10*eps,ts-10*eps,linspace(0,2*pi,N)]);

% plot scaled theta
plot(t,real(out.scaled.theta(t)),'linewidth',2,'Color',[0 0 0]); hold on

% plot unscaled theta
plot(ct*t,real(out.unscaled.theta(ct*t,umax,f,J)),'linewidth',2,'Color',rc); hold on

% add axis labels
myxlabel = 'time'; % x label with latex
myylabel = 'position'; % y label with latex
xlabel(myxlabel) % create x label
ylabel(myylabel) % create y label

% change axis properties
xmin = 0; % x axis minimum
xmax = 2*pi; % x axis maximum
ymin = 0; % y axis minimum
% ymax = 0.5; % y axis maximum
ymax = 12; % y axis maximum
xlim([xmin xmax]) % change x limits
ylim([ymin ymax]) % change y limits
ha = gca; % get current axis handle
ha.XAxis.Color = bcolor; % change the x axis color to black (not a dark gray)
ha.YAxis.Color = bcolor; % change the y axis color to black (not a dark gray)
ha.XAxis.FontSize = fonttick; % change x tick font size
ha.YAxis.FontSize = fonttick; % change y tick font size
ha.XAxis.Label.FontSize = fontlabel; % change x label font size
ha.YAxis.Label.FontSize = fontlabel; % change y label font size
ha.XAxis.Label.Interpreter = 'none';
ha.XAxis.FontName = 'Times New Roman';
ha.YAxis.Label.Interpreter = 'none';
ha.YAxis.FontName = 'Times New Roman';

% add a legend
mylegend = {'$\bar{\theta}(\bar{t})$','$\theta(t)$'}; % legend with latex
% hl = legend(mylegend,'position',[0.7 0.8 0.1 0.1],'Orientation','horizontal'); % create legend
hl = legend(mylegend,'position',[0.3 0.8 0.1 0.1],'Orientation','horizontal'); % create legend
hl.FontSize = fontlegend; % change legend font size
hl.EdgeColor = 'none'; % change the legend border to black (not a dark gray)
hl.Color = 'none';

% save a pdf version
mysavename = 'TP3_position'; % name to give the saved file
pathpdf = mfoldername(mfilename('fullpath'),'pdf');
filename = [pathpdf,mysavename];
str = ['export_fig ''',filename,''' -pdf'];
eval(str)

%% figure for control
% preliminary tasks
set(0,'DefaultTextInterpreter','latex'); % change the text interpreter
set(0,'DefaultLegendInterpreter','latex'); % change the legend interpreter
set(0,'DefaultAxesTickLabelInterpreter','latex'); % change the tick interpreter
hf = figure; % create a new figure and save handle
hf.Color = wcolor; % change the figure background color
hf.Position = [200 200 fwidth fheight]; % set figure size and position

% scaled time grid
N = 100;
ts = out.scaled.ts;
t = sort([ts,ts+100*eps,ts-100*eps,linspace(0,2*pi,N)]);

% plot scaled control
plot(t,out.scaled.U(t),'linewidth',2,'Color',[0 0 0]); hold on

% plot unscaled control
plot(ct*t,out.unscaled.U(ct*t,umax,f),'linewidth',2,'Color',rc); hold on

% add axis labels
myxlabel = 'time'; % x label with latex
myylabel = 'control'; % y label with latex
xlabel(myxlabel) % create x label
ylabel(myylabel) % create y label

% change axis properties
xmin = 0; % x axis minimum
xmax = 2*pi; % x axis maximum
ymin = -1; % y axis minimum
ymax = 1; % y axis maximum
xlim([xmin xmax]) % change x limits
ylim([ymin ymax]) % change y limits
ha = gca; % get current axis handle
ha.XAxis.Color = bcolor; % change the x axis color to black (not a dark gray)
ha.YAxis.Color = bcolor; % change the y axis color to black (not a dark gray)
ha.XAxis.FontSize = fonttick; % change x tick font size
ha.YAxis.FontSize = fonttick; % change y tick font size
ha.XAxis.Label.FontSize = fontlabel; % change x label font size
ha.YAxis.Label.FontSize = fontlabel; % change y label font size
ha.XAxis.Label.Interpreter = 'none';
ha.XAxis.FontName = 'Times New Roman';
ha.YAxis.Label.Interpreter = 'none';
ha.YAxis.FontName = 'Times New Roman';

% add a legend
mylegend = {'$\bar{u}(\bar{t})$','$u(t)$'}; % legend with latex
hl = legend(mylegend,'position',[0.3 0.2 0.1 0.1],'Orientation','horizontal'); % create legend
hl.FontSize = fontlegend; % change legend font size
hl.EdgeColor = 'none'; % change the legend border to black (not a dark gray)
hl.Color = 'none';

% save a pdf version
mysavename = 'TP3_control'; % name to give the saved file
pathpdf = mfoldername(mfilename('fullpath'),'pdf');
filename = [pathpdf,mysavename];
str = ['export_fig ''',filename,''' -pdf'];
eval(str)