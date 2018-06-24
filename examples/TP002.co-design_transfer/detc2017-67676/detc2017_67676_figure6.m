%--------------------------------------------------------------------------
% detc2017_67676_figure6.m
% Recreates Figure 6 from DETC2017-67676
%--------------------------------------------------------------------------
%
%--------------------------------------------------------------------------
% Primary contributor: 
%  Daniel R. Herber (danielrherber), Univ. of Illinois at Urbana-Champaign
% Project link:
%  https://github.com/danielrherber/co-design-examples-repository
%--------------------------------------------------------------------------
close all

%% parameters
% taken from Figure 6 of DETC2017-67676
tf = 1;
x0 = 1;
v0 = 2;
b = 0;

%% all figures
fwidth = 550; % figure width in pixels
fheight = 350; % figure height in pixels
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

% k points
Nk = 1000;
karray = [0,linspace(1e-4,50,Nk)];

% nested co-design solution space
PSI = [TP2_PSIk0([],tf,x0,v0), TP2_PSI([],tf,x0,v0,karray(2:end))];

% plot the nested co-design solution space
plot(karray,PSI,'linewidth',2,'color',[0 0 0]); hold on

% find the locations of the minimums
[pks,locs,w,p] = findpeaks(-PSI,karray);

% find global minimum
I = find(min(-pks)== -pks);
Glocs = locs(I);
Gpks = -pks(I);
pks(I) = [];
locs(I) = [];

% find the minimum manually if findpeaks fails
if isempty(Gpks)
	Gpks = PSI(1);
    Glocs = 0;
else 
    [Glocs,Gpks] = fminbnd(@(k) TP2_PSI([],tf,x0,v0,k),0,2*Glocs,...
        optimset('TolX',1e-12,'Display','iter'));
end

% plot the local minimums
if ~isempty(pks)
    plot(locs,-pks,'*','markersize',8,'color',[0.3 0.3 0.3]); hold on
end

% plot the global minimum
if ~isempty(Gpks)
    plot(Glocs,Gpks,'.','markersize',20,'color',[252,166,54]/255); hold on
end

% axis labels
myxlabel = '$k$'; % x label with latex
myylabel = 'objective'; % y label with latex
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
ha.YAxis.Label.Interpreter = 'none';
ha.YAxis.FontName = 'Times New Roman';

% add the legend
if isempty(Gpks)
	mylegend = {'$\psi(k)$'};
elseif isempty(pks)
	mylegend = {'$\int_0^{t_f} \left[u^*(t,k)\right]^2 dt$','minimum'};
else
	mylegend = {'$\psi(k)$','Local minima','Global mimina'};
end
hl = legend(mylegend,'location','Best'); % create legend
hl.FontSize = fontlegend; % change legend font size
hl.EdgeColor = wcolor; % change the legend border to black (not a dark grey)

% save a pdf version
mysavename = 'TP2_4_PSI'; % name to give the saved file
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
hf.Position = [200 200 fwidth fheight]; % set figure size and position

% t points
Nt = 300;
tv = linspace(0,tf,Nt);

% k points
Nk = 4;
kv = round(linspace(0,50,Nk+1));
kv = sort([kv,1]);

% control the location of the labels
myI = [175, 175, 137, 126, 136, 75];

% control the location of the label for the optimal value
Bi = 195;

% remove initial value
kv(1) = [];
myI(1) =[];

% plot the state trajectories
TP2_X_plots(tv,kv,myI,Bi,x0,v0,tf,Glocs,fonttick)

% axis labels
myxlabel = '$t$'; % x label with latex
myylabel = '$y^*(t,k)$'; % y label with latex
xlabel(myxlabel) % create x label
ylabel(myylabel) % create y label

% change axis properties
ymin = -0.55; ymax = 1.2;
ylim([ymin ymax]) % change y limits
ha = gca; % get current axis handle
ha.XAxis.Color = bcolor; % change the x axis color to black (not a dark grey)
ha.YAxis.Color = bcolor; % change the y axis color to black (not a dark grey)
ha.XAxis.FontSize = fonttick; % change x tick font size
ha.YAxis.FontSize = fonttick; % change y tick font size
ha.XAxis.Label.FontSize = fontlabel; % change x label font size
ha.YAxis.Label.FontSize = fontlabel; % change y label font size
ha.Layer = 'top'; % place the axes on top of the data

% save a pdf version
mysavename = 'TP2_4_X'; % name to give the saved file
pathpdf = mfoldername(mfilename('fullpath'),'pdf');
filename = [pathpdf,mysavename];
str = ['export_fig ''',filename,''' -pdf'];
eval(str)

%% figure 3
% pre tasks
set(0,'DefaultTextInterpreter','latex'); % change the text interpreter
set(0,'DefaultLegendInterpreter','latex'); % change the legend interpreter
set(0,'DefaultAxesTickLabelInterpreter','latex'); % change the tick interpreter
hf = figure; % create a new figure and save handle
hf.Color = wcolor; % change the figure background color
hf.Position = [200 200 fwidth fheight]; % set figure size and position

% t points
Nt = 300;
tv = linspace(0,tf,Nt);

% k points
Nk = 4;
kv = round(linspace(0,50,Nk+1));
kv = sort([kv,1]);

% control the location of the labels
myI = [30,30, 90, 80, 70, 60];

% control the location of the label for the optimal value
Bi = 55;

% remove initial value
kv(1) = [];
myI(1) =[];

% plot the control trajectories
TP2_U_plots(tv,kv,myI,Bi,x0,v0,tf,Glocs,fonttick)

% axis labels
myxlabel = '$t$'; % x label with latex
myylabel = '$u^*(t,k)$'; % y label with latex
xlabel(myxlabel) % create x label
ylabel(myylabel) % create y label

% change axis properties
ymin = -18; ymax = 18;
ylim([ymin ymax]) % change y limits
ha = gca; % get current axis handle
ha.XAxis.Color = bcolor; % change the x axis color to black (not a dark grey)
ha.YAxis.Color = bcolor; % change the y axis color to black (not a dark grey)
ha.XAxis.FontSize = fonttick; % change x tick font size
ha.YAxis.FontSize = fonttick; % change y tick font size
ha.XAxis.Label.FontSize = fontlabel; % change x label font size
ha.YAxis.Label.FontSize = fontlabel; % change y label font size
ha.Layer = 'top'; % place the axes on top of the data

% save a pdf version
mysavename = 'TP2_4_U'; % name to give the saved file
pathpdf = mfoldername(mfilename('fullpath'),'pdf');
filename = [pathpdf,mysavename];
str = ['export_fig ''',filename,''' -pdf'];
eval(str)