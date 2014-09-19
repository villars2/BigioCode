function Example_RecessionPlot2(dates)
%EXAMPLE_RECESSIONPLOT Add recession bands to time series plot
% Syntax:
%
%   Example_RecessionPlot(dates)
%
% Description:
%
%   Overlays lines and labels corresponding to critical dates for banks.
%   to identify recessions on a time series plot.
%
% Input Arguments:
%
%   dates - Date numbers used in time series plot.
%           used to jump labels if unnecesary
%
fontsize=9;
TextColor='k';

% Register Annotation Days
Events=[datenum('03-Mar-2008'),  % Failure of Bear Stearns
        datenum('2-Sep-2008'),  % Lehman Brothers Fails        
        datenum('16-Sep-2008'),  % AIG Liquidity Crisis
        datenum('23-Sep-2008'),  % Goldman Sachs, Morgan Stanley become Bank Holdings. J.P. Morgan Chase Acquires Wachovia
        datenum('13-Nov-2008'),  % Amex becomes Bank Holding Company
        datenum('22-Dec-2008'),  % CIT becomes Bank Holding Company
        datenum('31-Dec-2008'),  % Wells Fargo Acquieres Washington Mutual
        datenum('13-Mar-2009')]; % Discover becomes Bank Holding Company

ylimits=get(gca,'YLim');

% -> Note, dates are slightly manipulated since annotations don't fit in graph at quarterly.
% Code must be modified for monthly....because 

% Annotate Failure of Bearn Stearns
r=1;
if Events(r) > min(dates) && Events(r) <= max(dates)    
    line([Events(r) Events(r)],ylimits,'LineStyle','--','Color',[0.0 0.0 0.0]);
    text([Events(r)],ylimits(2),'\bf Bear Stearns',...
        'Rotation',270,'FontSize',07,'Color',TextColor);
end

% Annotate Failure of Lehman + AIG
r=2;
if Events(r) > min(dates) && Events(r) <= max(dates)    
    line([Events(r) Events(r)],ylimits,'LineStyle','--','Color',[0.0 0.0 0.0]);
    text([Events(r)],ylimits(2),'\bf Lehman + AIG',...
        'Rotation',270,'FontSize',07,'Color',TextColor);
end

% Goldman Sachs, Morgan Stanley 
r=6;
if Events(r) > min(dates) && Events(r) <= max(dates)    
    line([Events(r) Events(r)],ylimits,'LineStyle','--','Color',[0.0 0.0 0.0]);
    text([Events(r)],ylimits(2),'\bf Goldman Sachs + Morgan Stanley + Amex + WaMu',...
        'Rotation',270,'FontSize',07,'Color',TextColor);
end

% Amex
% r=5;
% if Events(r) > min(dates) && Events(r) <= max(dates)    
%     line([Events(r) Events(r)],ylimits,'LineStyle','--','Color',[0.0 0.0 0.0]);
%     text([Events(r)],ylimits(2),'\bf Amex','Rotation',270,'FontSize',07);
% end

% Wells Fargo
% r=7;
% if Events(r) > min(dates) && Events(r) <= max(dates)    
%     line([Events(r) Events(r)],ylimits,'LineStyle','--','Color',[0.0 0.0 0.0]);
%     text([Events(r)],ylimits(2),'\bf CIT, Morgan Stanley','Rotation',270,'FontSize',07);
% end

% Wells Fargo
% r=7;
% if Events(r) > min(dates) && Events(r) <= max(dates)    
%     line([Events(r) Events(r)],ylimits,'LineStyle','--','Color',[0.0 0.0 0.0]);
%     text([Events(r)],ylimits(2),'\bf Wells Fargo + WaMu, Morgan Stanley',...
%         'Rotation',270,'FontSize',07,'Color',TextColor);
% end

% Discover
% r=8
% if Events(r) > min(dates) && Events(r) <= max(dates)    
%     line([Events(r) Events(r)],ylimits,'LineStyle','--','Color',[0.0 0.0 0.0]);
%     text([Events(r)],ylimits(2),'\bf Amex','Rotation',270,'FontSize',08);
% end

