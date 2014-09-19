%% Business Cycle Dates from National Bureau of Economic Research
% Code defines dates for Great Recession Indicators
% Preferences                                                         ;

%% NBER Official Dates
% We include the dates for peaks and troughs of the economic cycle from the 
% National Bureau of Economic Research (see link to NBER in the references).
Recessions = [ datenum('15-May-1937'), datenum('15-Jun-1938');
	datenum('15-Feb-1945'), datenum('15-Oct-1945');
	datenum('15-Nov-1948'), datenum('15-Oct-1949');
	datenum('15-Jul-1953'), datenum('15-May-1954');
	datenum('15-Aug-1957'), datenum('15-Apr-1958');
	datenum('15-Apr-1960'), datenum('15-Feb-1961');
	datenum('15-Dec-1969'), datenum('15-Nov-1970');
	datenum('15-Nov-1973'), datenum('15-Mar-1975');
	datenum('15-Jan-1980'), datenum('15-Jul-1980');
	datenum('15-Jul-1981'), datenum('15-Nov-1982');
	datenum('15-Jul-1990'), datenum('15-Mar-1991');
	datenum('15-Mar-2001'), datenum('15-Nov-2001');
	datenum('15-Dec-2007'), datenum('15-Jun-2009')];
Recessions     = busdate(Recessions);

% Name the Recession
RecessionsTag={'37-38','1945','53-54','57-58','60-61','69-70','73-75','80','82','90-91','2001','Great Rec'};

%% Definitions for plots
% Define Dates for Plots - Great Recession
GreatRecession = busdate([datenum('15-Dec-2007'), datenum('15-Jun-2009')])  ;
[~,Beg_GreatRec]   = min(abs(GreatRecession(1)-dates))                   ;
[~,End_GreatRec]   = min(abs(GreatRecession(2)-dates))                   ;
% Begining and End of GR
Beg_date=Beg_GreatRec-1                                                     ;
End_date=End_GreatRec+Space                                                 ;

% Numerical for Great Recession
index_gr=(Beg_date:End_date)                                              ;
dates_gr=dates(index_gr)                                                  ;
GreatRecIndic=zeros(length(dates),1);
GreatRecIndic(index_gr)=1;

% Index for Pre-Great Recession History
HistIndic=zeros(length(dates),1);
HistIndic(index_gr)=1;


% Dates for last Decade
Decade = busdate([datenum('15-Dec-2000'), datenum('15-Jun-2013')])          ;
[~,Beg_DecPlot]   = min(abs(Decade(1)-dates))                            ;
[~,End_DecPlot]   = min(abs(Decade(2)-dates))                            ;
% Begining and End of GR
Beg_date=Beg_DecPlot-1                                                     ;
End_date=End_DecPlot                                                 ;
% Numerical for Great Recession
index_d=(Beg_DecPlot:End_DecPlot)                                      ;
dates_d=dates(index_d)                                                 ;
DecIndic     =zeros(length(dates),1);
DecIndic(Beg_DecPlot:End_DecPlot)=1;

% Dates for last Decade
PreLast = busdate([datenum('30-Mar-1998')])          ;
[~,End_PrePlot]   = min(abs(PreLast-dates))        ;
% Begining and End of GR                                                    ;

% Numerical for last decade
index_pre=(1:End_PrePlot)                                      ;
dates_pre=dates(index_pre)                                                 ;                                                              

% Recession Indicators
RecIndic     =zeros(length(dates),1);
NotRecIndic  =zeros(length(dates),1);
for ii=1:length(dates)
    if sum(dates(ii)>=Recessions(:,1)&dates(ii)<=Recessions(:,2))==1
        RecIndic(ii)=1;
    else
        NotRecIndic(ii)=1;
    end
end