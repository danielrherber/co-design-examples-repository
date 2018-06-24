%--------------------------------------------------------------------------
% md_18_1066_figure4.m
% Recreates the plots from Test Problem 3: Simple SASA in MD-18-1066
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
% these values are from MD-18-1066 (can be changed)
p.J = 1; p.tf = 2; p.umax = 1;
p.nt = 20000; % number of nodes
% k values to plot
kvalues(1) = 0;
kvalues(2) = 0.0865610072861534*4*pi^2*p.J/(p.tf^2); % optimal
kvalues(3) = 50;

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
cb = [0 0 0]/255;
cp = [106 0 167]/255;
cr = [225 99 97]/255;

%% figures
for idx = 1:length(kvalues)
    % preliminary tasks
    set(0,'DefaultTextInterpreter','latex'); % change the text interpreter
    set(0,'DefaultLegendInterpreter','latex'); % change the legend interpreter
    set(0,'DefaultAxesTickLabelInterpreter','latex'); % change the tick interpreter
    hf = figure; % create a new figure and save handle
    hf.Color = wcolor; % change the figure background color
    hf.Position = [200 200 fwidth fheight]; % set figure size and position

    % calculate control and states
    k = kvalues(idx);
    [~,U,Y,p] = TP3_Inner(k,p);

    % reduce the data for plotting
    % (requires mapping toolbox, other options are available online)
    try
        [T0,U0,cerr2,tol2] = reducem(p.t(:),U,1e-5);
    catch
        T0 = p.t; U0 = U;
    end
    try
        [T1,Y1,cerr2,tol2] = reducem(p.t(:),Y(:,1),1e-5);
    catch
        T1 = p.t; Y1 = Y(:,1);
    end
    try
        [T2,Y2,cerr2,tol2] = reducem(p.t(:),Y(:,2),1e-5);
    catch
        T2 = p.t; Y2 = Y(:,2);
    end 
    
    % plot state 1
    plot(T1,Y1,'linewidth',2,'color',cr); hold on

    % plot state 2
    plot(T2,Y2,'linewidth',2,'color',cp); hold on

    % plot control
    plot(T0,U0,'linewidth',2,'color',cb); hold on

    % add axis labels
    myxlabel = '$t$'; % x label with latex
    myylabel = '$\xi_1(t), \xi_2(t), u(t)$'; % y label with latex
    xlabel(myxlabel) % create x label
    ylabel(myylabel) % create y label

    % change axis properties
    ymin = -1.3; ymax = 1.3;
    xlim([p.t0 p.tf]) % change x limits
    ylim([ymin ymax]) % change y limits
    ha = gca; % get current axis handle
    ha.XAxis.Color = bcolor; % change the x axis color to black (not a dark gray)
    ha.YAxis.Color = bcolor; % change the y axis color to black (not a dark gray)
    ha.XAxis.FontSize = fonttick; % change x tick font size
    ha.YAxis.FontSize = fonttick; % change y tick font size
    ha.XAxis.Label.FontSize = fontlabel; % change x label font size
    ha.YAxis.Label.FontSize = fontlabel; % change y label font size
    ha.LineWidth = 1; % line width

    % add a legend
    mylegend = {'$\xi_1(t)$','$\xi_2(t)$','$u(t)$'}; % legend with latex
    hl = legend(mylegend,'position',[0.45 0.915 0.1 0.1],'Orientation','horizontal');
    hl.FontSize = fontlegend; % change legend font size
    hl.EdgeColor = 'none'; % change the legend border to black (not a dark gray)
    hl.Color = 'none';

    % save a pdf version
    mysavename = ['TP3_',num2str(idx)]; % name to give the saved file
    pathpdf = mfoldername(mfilename('fullpath'),'pdf');
    filename = [pathpdf,mysavename];
    str = ['export_fig ''',filename,''' -pdf'];
    eval(str)

end