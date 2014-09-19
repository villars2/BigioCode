% BDP_autoplot creates figures to compare within a time range
hold on;
for qq=1:numel(pseries)
    eval(['plot(pdate,' char(pseries(qq)) '(pindex),''LineWidth'',Width' num2str(qq) ',''Color'',DataColor' num2str(qq) ',''Marker'',Marker' num2str(qq) ',''MarkerSize'',MkS' num2str(qq) ');']) 
end
%Example_RecessionPlot(pdate, Recessions); 
% hold off;
[y_axis]=get(gca,'YLim'); 
dateaxis('x',12);
% set(gca,'XTick',[pdate(1:8:end-1); pdate(end)]);
% set(gca,'XTick',[pdate(1:16:end-1); pdate(end)]);
if strcmp('gr',date_types)
    set(gca,'XTick',[dates_gr]);
else
    set(gca,'XTick',[pdate(1:16:end-8); pdate(end)]);
end
datetick('x','mmmyy','keepticks');
set(gca,'YLim',[y_axis(1), y_axis(2)]);
%This was moved...
Example_RecessionPlot(pdate,Recessions);
hold off
grid on;