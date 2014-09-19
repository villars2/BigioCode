%% Used to generate plots for syndicated loans based on deal scan data.
% Import the file
% (c) Saki Bigio
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% One must run Stata file DealScanBuild.do to run the code.
% DealScanBuild will build different time series for different types of
% loans depending on their use.
%
% These made change from time to time. 
% For now there are several type of loans corresponding to the main uses:
%
% Variables without a number include the entire sample
% This table documents the type of loans and their numerical order. If
% these changes, these code will be captured by the variable tags
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% By Loan Type
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Acquis. line          1
% CP backup             3
% Corp. purposes        6 
% Debt Repay            8
% LBO                   18
% Proj. finance         25
% Real estate           28
% Takeover              37
% Work. cap             41
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variable Type
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% v                     stands for total volume
% c                     stands for total number of transactions
% r                     for the interest rate used
% clear;
% close all;

%% Compute Program Preferences
% clear;
% close all;
begin_date='1-Mar-1990'; % Initial Date for Data
margin=150;              % Margin Date-Numeric for plots

% Code Preferences
lambda_hp=5           ; % Hodrick and Prescott Filter 1600 recommended by Harald Uhilig and Morten Ravn

% Plot Preferences
margin=150               ; % Margin Date-Numeric for plots

% Color Specifications
BDP_plotspecs; % Code that chooses colors for plots

%% Begin Download
% Adding U.S. GDP, FEDFUNDS and DEFLATOR from FRED
series={'GDP','GDPDEF'}                                                  ;

% Download list in series
FRED_downloads;

%% Upload Deal Scan Data
newData = importdata('SyndicatedLoans.csv');

% Create new variables in the base workspace from those fields.
vars = fieldnames(newData); % Captures all possible name tags
for i = 1:length(vars)
    assignin('base', vars{i}, newData.(vars{i}));
end

% Importing Labels
tags = importdata('tags.csv');

% Create new variables in the base workspace from those fields.
jj=2                    ;
labels=cell(1,1)        ;
labels{1}='Year'      ;
labels{2}='Quarter'   ;
for i = 1:length(tags)   
    if isempty(char(tags{i}(2:end-1)))
    else
        jj=jj+1;
        labels{jj}=char(tags{i}(2:end-1));    
    end    
end

% Data
year   = data(:,1);
quarter= data(:,2);

% Converting to time series
dates = lbusdate(year, quarter*3);
clear year quarter

% Plotting Evolution of Syndicated Loans
for ii=3:length(colheaders)    
    fts = fints(dates, data(:,ii), colheaders{ii})  ;
    Universe = merge(fts, Universe)                 ;
end
Universe.desc = 'Flow of Funds Data'        ;
Universe.freq = 'quarterly'                 ;

% Using Dates from DealScanData
StartDate=dates(1)  ;
EndDate=dates(end)  ;

% Convert combined time series into date and data arrays		
series=[series colheaders{3:end}];
dates = Universe.dates;
Data = fts2mat(Universe.(series));
Dataset = dataset([{Data},series],'ObsNames',cellstr(datestr(dates,'QQ-YY')));
clear tags;

%% Key Dates
% Business Cycle Dates
Space=14;
FRED_RecessionIndicators_DealScan;
T = length(Dataset);

% Truncate Dates
var_dates='GDP'; % Variable dates used for truncation
%eval(['t_init= min((1-isnan(Dataset.' char(var_dates) ')).*(1:T)'') ']);
eval(['t_end = max((1-isnan(Dataset.' char(var_dates) ')).*(1:T)'');']);
eval(['t_beg =81;']);
index_s=1:T;
index_t=(1:t_end);
dates_t=dates(index_t);

% Recessions = [ datenum('15-May-1937'), datenum('15-Jun-1938');
% 	datenum('15-Feb-1945'), datenum('15-Oct-1945');
% 	datenum('15-Nov-1948'), datenum('15-Oct-1949');
% 	datenum('15-Jul-1953'), datenum('15-May-1954');
% 	datenum('15-Aug-1957'), datenum('15-Apr-1958');
% 	datenum('15-Apr-1960'), datenum('15-Feb-1961');
% 	datenum('15-Dec-1969'), datenum('15-Nov-1970');
% 	datenum('15-Nov-1973'), datenum('15-Mar-1975');
% 	datenum('15-Jan-1980'), datenum('15-Jul-1980');
% 	datenum('15-Jul-1981'), datenum('15-Nov-1982');
% 	datenum('15-Jul-1990'), datenum('15-Mar-1991');
% 	datenum('15-Mar-2001'), datenum('15-Nov-2001');
% 	datenum('15-Dec-2007'), datenum('15-Jun-2009')];
% Recessions     = busdate(Recessions);
% 
% % Define Dates for Plots - Great Recession
% GreatRecession = busdate([datenum('15-Dec-2007'), datenum('15-Jun-2009')])  ;
% [~,Beg_GreatRec]   = min(abs(GreatRecession(1)-dates))                   ;
% [~,End_GreatRec]   = min(abs(GreatRecession(2)-dates))                   ;
% Beg_date=Beg_GreatRec-1                                                      ;
% Space=1                                                                     ;
% End_date=length(dates)                                               ;
% dates_path=(Beg_date-Space:End_date)                                   ;
% dates_gr=dates(dates_path)                                                  ;
% dates_cr=(Beg_date-Space:End_date)                                          ;
% dates_cr=dates(dates_cr)                                                    ;
% dates_lr=(Beg_date:length(Dataset.GDP))                                     ;
% dates_lr=dates(dates_lr)                                                    ;
% 
% % Decade Plot
% Decade = busdate([datenum('15-Dec-1998'), datenum('15-Mar-2013')])          ;
% [junk,Beg_DecPlot]   = min(abs(Decade(1)-dates))                            ;
% [junk,End_DecPlot]   = min(abs(Decade(2)-dates))                            ;
% dates_decade=(Beg_DecPlot:End_DecPlot)                                      ;
% dates_d=dates(dates_decade)                                                 ;
% clear junk                                                                  ;
% 
% % Data Transformation
% % Real Side Variables - Start Building Series
% tau=1;
% GDP  = log(Dataset.GDP)                                          ;
% DEF   = log(Dataset.GDPDEF)                                      ;
% GDP_g=mean([(diff(GDP(1:5))); diff(GDP(1:Beg_GreatRec-1))])      ;
% DEF_g=mean([(diff(DEF(1:5))); diff(DEF(1:Beg_GreatRec-1))])      ;
% Trend_g=GDP_g-DEF_g                                              ;
% Trend=tau*Trend_g*(((Beg_date:End_date)-(Beg_date))>0)'          ;
% DEF_path=DEF(Beg_date:End_date)-DEF(Beg_date)                    ;
% GDP_path=GDP(Beg_date:End_date)-GDP(Beg_date)-DEF_path           ;
% RGDP_path=GDP_path-Trend                                         ;
% GDP_cris=GDP(Beg_date-Space:End_date)                            ;

%% Constructing Subsets of Time-Series
GDP=Dataset.GDP;
GDPDEF=Dataset.GDPDEF;

% Construction Series for Loans depending on their use.
tot_syndic_v  = Dataset.t_volume; % Volume
tot_syndic_c  = Dataset.t_count ; % Count
tot_syndic_a  = tot_syndic_v./tot_syndic_c; % Averaga          
tot_syndic_r  = Dataset.t_rate  ; % Rates
nomlist={'GDP','tot_syndic_v','tot_syndic_c','tot_syndic_a',};


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Corp. purposes        6 
% CP backup             3
% Work. cap             40 <- Only taking Working Capital Purposes
gr={'40'}         ; % '6','3',
ii=0                      ;
wc_syndic_v=0*tot_syndic_v;
wc_syndic_c=0*tot_syndic_v;
wc_syndic_r=0*tot_syndic_r;
for vv=1:numel(gr);      
            ii=ii+1;
            eval(['wc_syndic_v= wc_syndic_v+Dataset.t_volume_' char(gr(vv)) ';']);   
            eval(['wc_syndic_c= wc_syndic_c+Dataset.t_count_' char(gr(vv)) ';']); 
            eval(['wc_syndic_r= wc_syndic_r+Dataset.t_rate_' char(gr(vv)) '.*Dataset.t_count_' char(gr(vv)) ';']);
end
wc_syndic_r=wc_syndic_r./wc_syndic_c     ;
wc_syndic_a=wc_syndic_v./wc_syndic_c     ;
nomlist=[nomlist {'wc_syndic_v','wc_syndic_c','wc_syndic_a'}];
% varlist=[varlist {'Rwc_syndic_v','Rwc_syndic_c','Rwc_syndic_a'}];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Investment Related Loans
% Acquis. line          1  <-
% Debt Repay            8
% LBO                   18 <-
% Proj. finance         25 <- Project Financing
% Real estate           27 
% Takeover              36 <- Takeover
gr={'1','18','25','36'}; % '1','8','18',,'27','36'
ii=0                      ;
inv_syndic_v=0*tot_syndic_v;
inv_syndic_c=0*tot_syndic_v;
inv_syndic_r=0*tot_syndic_r;
for vv=1:numel(gr);      
            ii=ii+1;
            eval(['inv_syndic_v= inv_syndic_v+Dataset.t_volume_' char(gr(vv)) ';']);   
            eval(['inv_syndic_c= inv_syndic_c+Dataset.t_count_' char(gr(vv)) ';']); 
            eval(['inv_syndic_r= inv_syndic_r+Dataset.t_rate_' char(gr(vv)) '.*Dataset.t_count_' char(gr(vv)) ';']);
end
inv_syndic_r=inv_syndic_r./inv_syndic_c     ;
inv_syndic_a=inv_syndic_v./inv_syndic_c     ;
nomlist=[nomlist {'inv_syndic_v','inv_syndic_c','inv_syndic_a','GDPDEF'}];
% varlist=[varlist {'Rinv_syndic_v','Rinv_syndic_c','Rinv_syndic_a','GDPDEF'}];
varlist={'RGDP','Rtot_syndic_v','Rtot_syndic_c','Rtot_syndic_a','Rwc_syndic_v','Rwc_syndic_c','Rwc_syndic_a','Rinv_syndic_v','Rinv_syndic_c','Rinv_syndic_a'};
varlist=[varlist ,'GDPDEF'];

%% Constructing Growth Rates and Obtaining trends
n2rlist=nomlist;
BDP_nom2real;

% Extrating Trends and linear trends
DateEndTrend=Beg_GreatRec+20; % Date for end of linear trend
initlindate=datenum('31-Dec-2007');
pl=6; pu=32;
BDP_transformations;

%% Constructing  Plots
figure
Rtot_syndic_v_aux=(100*(1+devhpart_Rtot_syndic_v));
pseries={'Rtot_syndic_v_aux'};
date_types='gr';
FRED_fix_dates;
pbench=Beg_GreatRec-1;
BDP_benchautoplot;
title('\bf Total Syndicated Loans ');

figure
pseries={'Rtot_syndic_v','hp_Rtot_syndic_v'};
date_types='dec';
FRED_fix_dates;
pbench=Beg_GreatRec-1;
BDP_autoplot;
title('\bf Total Syndicated Loans - Volume');

figure
pseries={'Rwc_syndic_v','hp_Rwc_syndic_v'};
date_types='dec';
FRED_fix_dates;
pbench=Beg_GreatRec-1;
BDP_autoplot;
title('\bf Total Syndicated Loans (Working Capital) - Volume');

figure
pseries={'Rinv_syndic_v','hp_Rinv_syndic_v'};
date_types='dec';
FRED_fix_dates;
pbench=Beg_GreatRec-1;
BDP_autoplot;
title('\bf Total Syndicated Loans (Investment) - Volume');

figure
pseries={'Rtot_syndic_a','hp_Rtot_syndic_a'};
date_types='dec';
FRED_fix_dates;
pbench=Beg_GreatRec-1;
BDP_autoplot;
title('\bf Total Syndicated Loans (Investment) - Average Size');

figure
pseries={'tot_syndic_c'};
date_types='dec';
FRED_fix_dates;
pbench=Beg_GreatRec-1;
BDP_autoplot;
title('\bf Total Syndicated Loans - Count of Loans');

figure
pseries={'Rtot_syndic_a','hp_Rtot_syndic_a'};
date_types='dec';
FRED_fix_dates;
pbench=Beg_GreatRec-1;
BDP_autoplot;
title('\bf Total Syndicated Loans - Average Size');
% %% Total volume of Syndicated Loans
% % Plot Volume of Syndicated Loans, Spreads and Rates
% figure
% subplot(2,2,1:2,'align');
% plot(dates_d, stot_syndic_v(dates_decade),...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates_d, Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates_d(4:12:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Total Volume of Syndicated Loans');
% ylabel('US$ Dollars'); grid on;
% axis([dates_d(1) - 50, dates_d(end) + 50, 0, 1]);
% axis 'auto y'
% 
% subplot(2,2,3,'align');
% plot(dates_d, stot_syndic_a(dates_decade),...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates_d, Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates_d(4:12:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Average Loan Size');
% ylabel('$US Dollars'); grid on;
% axis([dates_d(1) - 50, dates_d(end) + 50, 0, 1]);
% axis 'auto y'
% 
% subplot(2,2,4,'align');
% plot(dates_d, stot_syndic_r(dates_decade)/100,...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates_d, Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates_d(4:12:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Average Spread over Basis Rate');
% ylabel('%'); grid on;
% axis([dates_d(1) - 50, dates_d(end) + 50, 0, 1]);
% axis 'auto y'
% printit=1;
% if printit==1
%     orient landscape
%     saveas(gcf,'F_SyndicatedLoansTotal','pdf');
% end
% 
% % In Real Terms
% figure
% subplot(2,2,1:2,'align');
% plot(dates_d, stot_syndic_v(dates_decade)./Dataset.GDPDEF(dates_decade),...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates_d, Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates_d(4:12:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Total Volume of Syndicated Loans');
% ylabel('Real Value'); grid on;
% axis([dates_d(1) - 50, dates_d(end) + 50, 0, 1]);
% axis 'auto y'
% 
% subplot(2,2,3,'align');
% plot(dates_d, stot_syndic_a(dates_decade)./Dataset.GDPDEF(dates_decade),...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates_d, Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates_d(4:12:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Average Loan Size');
% ylabel('Real Value'); grid on;
% axis([dates_d(1) - 50, dates_d(end) + 50, 0, 1]);
% axis 'auto y'
% 
% subplot(2,2,4,'align');
% plot(dates_d, stot_syndic_r(dates_decade)/100,...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates_d, Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates_d(4:12:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Average Spread over Basis Rate');
% ylabel('%'); grid on;
% axis([dates_d(1) - 50, dates_d(end) + 50, 0, 1]);
% axis 'auto y';
% printit=1;
% if printit==1
%     orient landscape
%     saveas(gcf,'F_SyndicatedRealTotal','pdf');
% end
% 
% % Building Trends, deflating by GDP
% figure
% ax=[dates(Beg_date) - 2, dates(End_date) + 2, 0, 1];
% subplot(2,2,1:2,'align');
% plot(dates((Beg_date:End_date)), tot_syndic_path*100,...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates((Beg_date:End_date)), Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates(4:4:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Total Volume of Syndicated Loans');
% ylabel('%'); grid on;
% axis(ax);
% axis 'auto y'
% 
% subplot(2,2,3,'align');
% plot(dates((Beg_date:End_date)),tot_syndic_a_path*100,...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates((Beg_date:End_date)), Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates(4:4:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Average Loan Size');
% ylabel('%'); grid on;
% axis(ax);
% axis 'auto y'
% 
% subplot(2,2,4,'align');
% plot(dates((Beg_date:End_date)), stot_syndic_r(Beg_date:End_date)/100,...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates((Beg_date:End_date)), Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates(4:4:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Average Spread over Basis Rate');
% ylabel('%'); grid on;
% axis([dates(Beg_date) - 2, dates(End_date) + 2, 0, 1]);
% axis 'auto y';
% printit=1;
% if printit==1
%     orient landscape
%     saveas(gcf,'F_SyndicatedTotalPath','pdf');
% end
% 
% %% Working Capital use
% % Building Plots of Lending by Type
% figure
% subplot(2,2,1:2,'align');
% plot(dates_d, [wc_syndic_v(dates_decade)],...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates_d, Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates_d(4:12:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Volume of Syndicated Loans for Operations');
% ylabel('%'); grid on;
% axis([dates_d(1) - 50, dates_d(end) + 50, 0, 1]);
% axis 'auto y'
% 
% subplot(2,2,3,'align');
% plot(dates_d, [wc_syndic_a(dates_decade)],...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates_d, Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates_d(4:12:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Average Loan Size');
% ylabel('$US Dollar'); grid on;
% axis([dates_d(1) - 50, dates_d(end) + 50, 0, 1]);
% axis 'auto y'
% 
% subplot(2,2,4,'align');
% plot(dates_d, [wc_syndic_r(dates_decade)/100],...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates_d, Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates_d(4:12:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Average Spread over Basis Rate');
% ylabel('%'); grid on;
% axis([dates_d(1) - 50, dates_d(end) + 50, 0, 1]);
% axis 'auto y'
% printit=1;
% if printit==1
%     orient landscape
%     saveas(gcf,'F_SyndicatedWC','pdf');
% end
% 
% % in Real Terms
% figure
% subplot(2,2,1:2,'align');
% plot(dates_d, [wc_syndic_v(dates_decade)./Dataset.GDPDEF(dates_decade)],...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates_d, Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates_d(4:12:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Volume of Syndicated Loans for Operations');
% ylabel('%'); grid on;
% axis([dates_d(1) - 50, dates_d(end) + 50, 0, 1]);
% axis 'auto y'
% 
% subplot(2,2,3,'align');
% plot(dates_d, [wc_syndic_a(dates_decade)./Dataset.GDPDEF(dates_decade)],...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates_d, Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates_d(4:12:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Average Loan Size');
% ylabel('$US Dollar'); grid on;
% axis([dates_d(1) - 50, dates_d(end) + 50, 0, 1]);
% axis 'auto y'
% 
% subplot(2,2,4,'align');
% plot(dates_d, [wc_syndic_r(dates_decade)/100],...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates_d, Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates_d(4:12:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Average Spread over Basis Rate');
% ylabel('%'); grid on;
% axis([dates_d(1) - 50, dates_d(end) + 50, 0, 1]);
% axis 'auto y'
% if printit==1
%     orient landscape
%     saveas(gcf,'F_SyndicatedRealWC','pdf');
% end
% 
% % Building Trends, deflating by GDP
% figure
% ax=[dates(Beg_date) - 2, dates(End_date) + 2, 0, 1];
% subplot(2,2,1:2,'align');
% plot(dates((Beg_date:End_date)), [wc_syndic_path]*100,...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates((Beg_date:End_date)), Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates(4:4:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Volume of Syndicated Loans for Operations');
% ylabel('%'); grid on;
% axis(ax);
% axis 'auto y'
% 
% subplot(2,2,3,'align');
% plot(dates((Beg_date:End_date)),[wc_syndic_a_path]*100,...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates((Beg_date:End_date)), Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates(4:4:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Average Loan Size');
% ylabel('%'); grid on;
% axis(ax);
% axis 'auto y'
% 
% subplot(2,2,4,'align');
% plot(dates((Beg_date:End_date)), [wc_syndic_r(Beg_date:End_date)/100],...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates((Beg_date:End_date)), Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates(4:4:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Average Spread over Basis Rate');
% ylabel('%'); grid on;
% axis([dates(Beg_date) - 2, dates(End_date) + 2, 0, 1]);
% axis 'auto y'
% if printit==1
%     orient landscape
%     saveas(gcf,'F_SyndicatedWCPath','pdf');
% end
% 
% %% Investment Use
% figure
% subplot(2,2,1:2,'align');
% plot(dates_d, inv_syndic_v(dates_decade),...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates_d, Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates_d(4:12:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Volume of Syndicated Loans for Investment');
% ylabel('%'); grid on;
% axis([dates_d(1) - 50, dates_d(end) + 50, 0, 1]);
% axis 'auto y'
% 
% subplot(2,2,3,'align');
% plot(dates_d, [inv_syndic_a(dates_decade)],...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates_d, Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates_d(4:12:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Average Loan Size');
% ylabel('$US Dollar'); grid on;
% axis([dates_d(1) - 50, dates_d(end) + 50, 0, 1]);
% axis 'auto y'
% 
% subplot(2,2,4,'align');
% plot(dates_d, [inv_syndic_r(dates_decade)/100],...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates_d, Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates_d(4:12:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Average Spread over Basis Rate');
% ylabel('%'); grid on;
% axis([dates_d(1) - 50, dates_d(end) + 50, 0, 1]);
% axis 'auto y'
% if printit==1
%     orient landscape
%     saveas(gcf,'F_SyndicatedInv','pdf');
% end
% 
% % In Real Terms
% figure
% subplot(2,2,1:2,'align');
% plot(dates_d, [inv_syndic_v(dates_decade)./Dataset.GDPDEF(dates_decade)],...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates_d, Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates_d(4:12:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Volume of Syndicated Loans for Investment');
% ylabel('%'); grid on;
% axis([dates_d(1) - 50, dates_d(end) + 50, 0, 1]);
% axis 'auto y'
% 
% subplot(2,2,3,'align');
% plot(dates_d, [inv_syndic_a(dates_decade)./Dataset.GDPDEF(dates_decade)],...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates_d, Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates_d(4:12:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Average Loan Size');
% ylabel('$US Dollar'); grid on;
% axis([dates_d(1) - 50, dates_d(end) + 50, 0, 1]);
% axis 'auto y'
% 
% subplot(2,2,4,'align');
% plot(dates_d, [inv_syndic_r(dates_decade)/100],...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates_d, Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates_d(4:12:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Average Spread over Basis Rate');
% ylabel('%'); grid on;
% axis([dates_d(1) - 50, dates_d(end) + 50, 0, 1]);
% axis 'auto y'
% if printit==1
%     orient landscape
%     saveas(gcf,'F_SyndicatedRealInv','pdf');
% end
% 
% % Deviation Paths - Investment
% figure
% ax=[dates(Beg_date) - 2, dates(End_date) + 2, 0, 1];
% subplot(2,2,1:2,'align');
% plot(dates((Beg_date:End_date)), [inv_syndic_path]*100,...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates((Beg_date:End_date)), Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates(4:4:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Volume of Syndicated Loans for Investment');
% ylabel('%'); grid on;
% axis(ax);
% axis 'auto y'
% 
% subplot(2,2,3,'align');
% plot(dates((Beg_date:End_date)),[inv_syndic_a_path]*100,...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates((Beg_date:End_date)), Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates(4:4:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Average Loan Size');
% ylabel('%'); grid on;
% axis(ax);
% axis 'auto y'
% 
% subplot(2,2,4,'align');
% plot(dates((Beg_date:End_date)), [inv_syndic_r(Beg_date:End_date)/100],...
%     'LineWidth',2,'Color',DataColor,'Marker',Marker,'MarkerSize',12);
% Example_RecessionPlot(dates((Beg_date:End_date)), Recessions);
% dateaxis('x',12);
% set(gca,'XTick',dates(4:4:end));
% datetick('x','mmmyy','keepticks');
% title('\bf Average Spread over Basis Rate');
% ylabel('%'); grid on;
% axis([dates(Beg_date) - 2, dates(End_date) + 2, 0, 1]);
% axis 'auto y'
% if printit==1
%     orient landscape
%     saveas(gcf,'F_SyndicatedInvPath','pdf');
% end

% Saving key variables\dates_slo=dates;
dates_syndic=dates;
save DealScan.mat dates_syndic Rtot_syndic_a hp_Rtot_syndic_a Rtot_syndic_v hp_Rtot_syndic_v;

save inv_syndic.mat syndic_inv_fin dates_d_syndic
save DealScan_Loans.mat dates_DealScan Beg_date End_date tot_syndic_path tot_syndic_a_path tot_syndic_r...
    inv_syndic_path inv_syndic_a_path inv_syndic_r wc_syndic_path wc_syndic_a_path wc_syndic_r;