%--------------------------------------------------------------------------
% TP2_X_plots.m
% Specialized function to plot states for Test Problem 2
%--------------------------------------------------------------------------
%
%--------------------------------------------------------------------------
% Primary contributor: 
%  Daniel R. Herber (danielrherber), Univ. of Illinois at Urbana-Champaign
% Project link:
%  https://github.com/danielrherber/co-design-examples-repository
%--------------------------------------------------------------------------
function TP2_X_plots(t,k,I,Bi,x0,v0,tf,k_optimal,fonttick)
% number of k points
Nk = length(k);

% colors
mycolor = plasma(Nk+1);
mycolor = flipud(mycolor);

% states
for j = 1:Nk
    % state solution
    if k(j) == 0
        y = TP2_Xk0(t,tf,x0,v0);
    else
        y = TP2_X(t,tf,x0,v0,k(j));
    end

    % set the color to black if it is the optimum
    if k(j) == k_optimal
        ccolor = 'k';             
    else
        ccolor = mycolor(j,:);
    end

    % plot the state
    plot(t,y,'linewidth',2,'color',ccolor); hold on

end

% plot optimal k if it hasn't been plotted yet
if k_optimal ~= 0
    % state solution
    y = TP2_X(t,tf,x0,v0,k_optimal);

    % plot the state
    plot(t,y,'linewidth',2,'color','k'); hold on
end

% plot the labels
for j = 1:Nk
	% state solution
    if k(j) == 0
        y = TP2_Xk0(t,tf,x0,v0);
    else
        y = TP2_X(t,tf,x0,v0,k(j));
    end

    % index in I
    i = I(j);

    % create a white circle whose size depends on the number of digits
    bc = PlotWhiteCircle(k(j),t(i),y(i));

    % add the text label
    text(t(i), y(i), num2str(k(j)), 'BackgroundColor', bc,...
        'Units','data','Interpreter','latex','HorizontalAlignment','center',...
        'fontsize',fonttick-2,'Margin',0.1,'LineStyle','none',...
        'VerticalAlignment','middle','clipping','on');  
end

% plot optimal k if it hasn't been plotted yet
if k_optimal ~= 0
    % get the state solution
    y = TP2_X(t,tf,x0,v0,k_optimal);

    % 
    i = Bi;

    % create a white circle whose size depends on the number of digits
    bc = PlotWhiteCircle(k_optimal,t(i),y(i));

    % add the text label
    text(t(i), y(i), num2str(round(100*k_optimal)/100), 'BackgroundColor', bc,...
        'Units','data','Interpreter','latex','HorizontalAlignment','center',...
        'fontsize',fonttick-2,'Margin',0.1,'LineStyle','none',...
        'VerticalAlignment','middle','clipping','on');  
end

% change x limits
xlim([0 tf])

end
% create a white circle whose size depends on the number of digits
function bc = PlotWhiteCircle(Glocs,ti,yi)
    if length(num2str(Glocs)) == 1 % ex: '0' or '9'
        % plot the white circle on the trajectory
        plot(ti,yi,'.','color','w','markersize',40); hold on
        
        % no background color for the label
        bc = 'none';
    elseif length(num2str(Glocs)) == 2 % ex: '32' or '97'
        % plot the white circle on the trajectory
        plot(ti,yi,'.','color','w','markersize',60); hold on
        
        % no background color for the label
        bc = 'none';
    else
        % white background color for the label
        bc = 'w';
    end
end