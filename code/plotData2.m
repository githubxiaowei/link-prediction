function plotData2(varargin)
%plotData2(datax,datay,fitPoints)
%plotData2(datax,datay,fitPoints,axisRange)
%plotData2(datax,datay,fitPoints,labelx,labely,title)
%plotData2(datax,datay,fitPoints,axisRange,labelx,labely,title) this
%function plot and fit the data with the xlabel and ylabel, you can change
%the range of the axes using the parameter axisRange = [xMIN xMAX yMIN
%yMAX]
%
%eg.
%datax = ARRAY1
%datay = ARRAY2
%fitpoints = [firstIndex :  lastIndex] %[2:8]using points from 2nd to 8th to fit the line 
%axisRange = [xMIN xMAX yMIN yMAX]
%labelx = 'Concentration (mM)'
%labely = 'Current (mA)'
%
%Author XIAOWEI
%Date  2016.10.28

minArgNum = 3;
if(nargin < minArgNum || nargin >minArgNum+4)
    disp('invalid number of arguments');
    return;
elseif(nargin == minArgNum + 1 )
    axisRange = varargin{minArgNum + 1 };
elseif(nargin == minArgNum + 3)
    labelx = varargin{minArgNum + 1 };
    labely = varargin{minArgNum + 2 };
    Title = varargin{minArgNum + 3};
elseif(nargin == minArgNum + 4)
    axisRange = varargin{minArgNum + 1 };
    labelx = varargin{minArgNum + 2 };
    labely = varargin{minArgNum + 3 };
    Title = varargin{minArgNum + 4};
end
x = varargin{1};
y = varargin{2};
fitPoints = varargin{3};
%data from the sheet is stored in two array

if(~isempty(fitPoints))
p=polyfit(x(fitPoints),y(fitPoints),1);

xi = x(fitPoints);
yi=polyval(p,xi);
ym = mean(y(fitPoints));

R2 = sum((yi-ym).^2)/sum((y(fitPoints) - ym).^2)
plot(xi,yi,'k','linewidth',2);
hold on;
%show the fitting line
sprintf('Y=%0.5gX+%0.5g R^2 = %0.5g',p(1),p(2),R2)
end
%plot the curve in black('k') with its linewidth 2

plot(x,y,'go','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',6);
plot(x,y,'k','linewidth',2,'color','r');
%show the primitive points and lines


if(nargin == minArgNum + 1  ||nargin == minArgNum +4)
    axis(axisRange);
end
%range of x and y

set(gca,...%current axes
    'FontSize',16,...
    'FontName','Times New Roman',...
    'box','off',...%you don't want to try 'on'
    'linewidth',3);
%set the attributes of axes
%set(current axes, 'ATTRIBUTE1', 'VALUE1','ATTRIBUTE2', 'VALUE2'......)

set(gcf,'units','inches','windowstyle','normal','position',[4 1 6 6]);
%undock the figure
%set the position of the figure,4 inches from the screen bottom,
%2 inches from the screen left, 5 inches width, 5 inches height
set(gca,'Position',[0.165 0.165 0.75 0.75]);
%set the axes' relative position in the figure
set(gcf,'paperpositionmode','auto');
%ensure that the output tiff/jpg is the same size as you ploted

if(nargin == minArgNum + 3 || nargin == minArgNum + 4)
xlabel(labelx,...
    'FontSize',18,...
    'FontName','Times New Roman',...
    'FontWeight','bold');
ylabel(labely,...
    'FontSize',18,...
    'FontName','Times New Roman',...
    'FontWeight','bold');
title(Title,...
    'FontSize',18,...
    'FontName','Times New Roman',...
    'FontWeight','bold');
end
%set the attributes of labels



end



