% BDP_autoplot creates figures to compare within a time range
hold on;
for qq=1:numel(pseries)
    eval(['plot(pdate,(' char(pseries(qq)) '(pindex)/' char(pseries(qq)) '(pbench)-1)*100,''LineWidth'',Width' num2str(qq) ',''Color'',DataColor' num2str(qq) ',''Marker'',Marker' num2str(qq) ',''MarkerSize'',MkS' num2str(qq) ');']) 
end
Example_RecessionPlot(pdate, Recessions); 
hold off;
[y_axis]=get(gca,'YLim'); 
dateaxis('x',12);
set(gca,'XTick',[pdate(1:8:end-1); pdate(end)]);
datetick('x','mmmyy','keepticks');
set(gca,'YLim',[y_axis(1), y_axis(2)]);
grid on;