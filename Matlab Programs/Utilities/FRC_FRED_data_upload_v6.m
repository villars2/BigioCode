clear;
close all;
% cd('C:\Users\Saki Bigio\Dropbox\Latam Reform\Data');
% cd('C:\Users\sb3439\Dropbox\Latam Reform');

% Code Prefrences
% - Color Specifications
BDP_plotspecs; % Code that chooses colors for plots
Space=10;
Extra=10;
begin_date='1-Apr-1974';
ending_date='1-Jun-2014';

%% Plot Options - make standard format for all graphs later
%DataColor=[0.1 0.45 0.13];
%Marker='X'               ;
%Width=2                  ;
%MkS = 12          ;
%margin=150;


%% Variable Lists
% Constructin Loan List Group
% By Risk
% By Maturity
% By Variable
loanseries={};
vars={'EV','EA','ED','EE'};
maturity={'A','S','M'}    ;
risks={'','N','L','M','O'};
for vv=1:numel(vars);
    for mm=1:numel(maturity);
        for rr=1:numel(risks);        
            var=vars{vv};
            R  =risks{rr};
            M  =maturity{mm};
            eval(['loanseries = [loanseries {''' [var M R] 'NQ''}];']);
        end
    end
end

% Construction SLO List Group
% By Question Type
% By Category Type
sloseries={};
question={'DRTS','DRSD'};
type={'CILM','CIS','PM','CREL'};
for qq=1:numel(question);
	for tt=1:numel(type);
		ques = question{qq};
        tp = type{tt};
		eval(['sloseries = [sloseries {''' [ques tp] '''}];']);
	end
end


% Adding - Bank of America Merrill Lynch Corporate Bond Spreads Data
bondseries={};
rating={'AAA','AA','A','BBB'};
ii=0;
for vv=1:numel(rating);      
            ii=ii+1;
            rate=rating{vv};
            eval(['bondseries = [bondseries {''BAMLC0A' num2str(ii) 'C' [rate] 'EY''}];']);
end

% High Yield Market
rating={'BB','B','C'};
ii=0;
for vv=1:numel(rating);      
            ii=ii+1;
            rate=rating{vv};
            eval(['bondseries = [bondseries {''BAMLH0A' num2str(ii) 'HY' [rate] 'EY''}];']);
end

% Adding Data from Moody's
bondseries = [bondseries, {'AAA'},{'BAA'}];

% Balance Sheet Series from FRED
btypes={'NNB','NNCB'};
bcseries={};
ii=0;
for vv=1:numel(btypes);      
            ii=ii+1;
            rate=btypes{vv};
            eval(['bcseries = [bcseries {''TABS' rate  '''}]']);        
            eval(['bcseries = [bcseries {''TFAABS' rate '''}]']);
            eval(['bcseries = [bcseries {''TRABS' rate '''}]']);
            eval(['bcseries = [bcseries {''TTAABS' rate '''}]']);
            eval(['bcseries = [bcseries {''IABS' rate '''}]']);
            eval(['bcseries = [bcseries {''ESABS' rate '''}]']);
            eval(['bcseries = [bcseries {''REABS' rate '''}]']);
            eval(['bcseries = [bcseries {''TLBS' rate '''}]']);
            eval(['bcseries = [bcseries {''TCMILBS' rate '''}]']);
            eval(['bcseries = [bcseries {''BLNECLBS' rate '''}]']);
            eval(['bcseries = [bcseries {''MLBS' rate '''}]']);
            eval(['bcseries = [bcseries {''TPLBS' rate '''}]']);
end
bcseries = [bcseries {'TXLBSNNB'}]  ;
bcseries = [bcseries {'TXPLBSNNCB'}];
bcseries = [bcseries {'CPLBSNNCB'}] ;
bcseries = [bcseries {'CBLBSNNCB'}] ;

% Adding Commercial Data Series
cpseries = {'FINCP','COMPAPER','ABCOMP','CPN1M','CPN2M','CPN3M','CPF1M','CPF2M','CPF3M'};

% Real Data Series
realqs ={'GDPC96','GDPPOT','GPDIC96','PNFIC96','PCECC96','OPHNFB','ULCNFB'};

% SLO variables
%slo = {'DRTSCILM', 'DRTSCIS','DRTSCREL','DRTSPM','DRSDCILM', 'DRSDCIS','DRSDCREL','DRSDPM'};
% wrote "sloseries" above

% variables for tables 
%table = {'ADJRESNS', 'DEMDEPSL','GDP','IBLACBM027SBOG'};
table = {'ADJRESNS', 'DEMDEPSL','IBLACBM027SBOG'};

% Adding Data from Flow of Funds
series = [loanseries bondseries bcseries cpseries realqs sloseries table {'GDP','FEDFUNDS','COE', 'CPIAUCSL',...
             'GCE', 'GDPDEF', 'GPDI', ...
             'GS10', 'HOANBS','BASE','M1SL', 'M2SL','MZMSL','NFINCP','PCEC','TB3MS','EXCRESNS', 'UNRATE',...
             'EQTA', 'USROE','CORBLACBS','USROA','USNIM','NPCMCM','NCOCMC','TOTLL',...
             'BUSLOANS','REALLN','CONSUMER','LOANS','LOANINV',....
             'USGSEC','DRISCFLM','DRISCFS','SP500','DJIA','VIXCLS'}];
%             'USGSEC','DRTSCILM','DRTSCIS','DRSDCILM','DRSDCIS','DRISCFLM','DRISCFS','DJIA','SP500','VIXCLS'}];        
             

realqs ={'GDPC96','GDPPOT','GPDIC96','PNFIC96','PCECC96','OPHNFB','ULCNFB'};

FRED_downloads;

FRED_RecessionIndicators;
T=length(Dataset);
[~,Beg_Plot]   = min(abs(datenum(begin_date)-dates));
[~,End_Plot]   = min(abs(datenum(ending_date)-dates));

% Truncate Dates
var_dates='GDP'; % Variable dates used for truncation
%eval(['t_init= min((1-isnan(Dataset.' char(var_dates) ')).*(1:T)'') ']);
eval(['t_end = max((1-isnan(Dataset.' char(var_dates) ')).*(1:T)'');']);
eval(['t_beg =81;']);
index_s=1:T;
index_t=(1:t_end);
dates_t=dates(index_t);
index_plot=(Beg_Plot:End_Plot);
dates_plot=dates(index_plot);                                                   ;
index_lr=(Beg_GreatRec-1:strfind(isnan(Dataset.TOTLL)',[0,1])) ;                                  ;
dates_lr=dates(index_lr)    ;

%% Transform Raw Data into Time Series for the Model         
% Great Recession Deviation
% 'CONS','HOURS','INV','WAGES',

% Log series - Level Series
series2log={'GDP','TOTLL','BUSLOANS','REALLN','CONSUMER','LOANS','LOANINV','USGSEC','GDPDEF'};
for i = 1:numel(series2log)
    eval([series2log{i} '   = log(Dataset.' series2log{i} ');']);
    eval(['r' series2log{i} '   = [ 4*mean(diff(' series2log{i} '(1:5))); 4*diff(' series2log{i} ')];']);
end

% Interest rates (annual)
rROE  = (Dataset.USROE)         ;
rROA  = (Dataset.USROA)         ;
rFEDFUNDS= (Dataset.FEDFUNDS)   ;
rG10 = 0.01*(Dataset.GS10)      ;
rTB3 = 0.01*(Dataset.TB3MS)     ;

% Ratios
EQTA    = (Dataset.EQTA    );
USNIM   = (Dataset.USNIM   );
NPCMCM  = (Dataset.NPCMCM  );
NCOCMC  = (Dataset.NCOCMC  );
DRTSCILM= (Dataset.DRTSCILM);
DRTSCIS = (Dataset.DRTSCIS );
DRSDCILM= (Dataset.DRSDCILM);
DRSDCIS = (Dataset.DRSDCIS );
DRISCFLM= (Dataset.DRISCFLM);
DRISCFS = (Dataset.DRISCFS );

% Relabeling Corporate Bond Data
eval(['BOA_AAA=Dataset.' bondseries{1} '-rTB3*100;'])
eval(['BOA_AA =Dataset.' bondseries{2} '-rTB3*100;'])
eval(['BOA_A  =Dataset.' bondseries{3} '-rTB3*100;'])
eval(['BOA_BBB=Dataset.' bondseries{4} '-rTB3*100;'])
eval(['BOA_BB =Dataset.' bondseries{5} '-rTB3*100;'])
eval(['BOA_B  =Dataset.' bondseries{6} '-rTB3*100;'])
eval(['BOA_C  =Dataset.' bondseries{7} '-rTB3*100;'])
eval(['MOO_AAA=Dataset.' bondseries{8} '-rTB3*100;'])
eval(['MOO_BAA=Dataset.' bondseries{9} '-rTB3*100;'])

% Integrated rates - Transforms Returns to Prices and Backouts Log
FED = ret2tick(0.25*rFEDFUNDS);
FED = log(FED(2:end));

% CP - spreds
CPN1M=(Dataset.CPN1M-rTB3*100);
CPN2M=(Dataset.CPN2M-rTB3*100);
CPN3M=(Dataset.CPN3M-rTB3*100);
CPF1M=(Dataset.CPF1M-rTB3*100);
CPF2M=(Dataset.CPF2M-rTB3*100);
CPF3M=(Dataset.CPF3M-rTB3*100);

% CP - spreds
CPN1M_f=(Dataset.CPN1M-rFEDFUNDS);
CPN2M_f=(Dataset.CPN2M-rFEDFUNDS);
CPN3M_f=(Dataset.CPN3M-rFEDFUNDS);
CPF1M_f=(Dataset.CPF1M-rFEDFUNDS);
CPF2M_f=(Dataset.CPF2M-rFEDFUNDS);
CPF3M_f=(Dataset.CPF3M-rFEDFUNDS);


% Unemployment rate
rUNEMP = 0.01*(Dataset.UNRATE);
UNEMP = ret2tick(0.25*rUNEMP);
UNEMP = log(UNEMP(2:end));

% Balance Sheet Log Data
for i = 1:numel(bcseries)
    eval([bcseries{i} '   = (Dataset.' bcseries{i} ');']);
end

% Stock Market Indices
DJIA  = Dataset.DJIA   ;
SP500 = Dataset.SP500  ;
VIX   = Dataset.VIXCLS;

% Some other variables
CONS  = log(Dataset.PCEC)   ;
HOURS = log(Dataset.HOANBS) ;
WAGES = log(Dataset.COE)    ;
INV   = log(Dataset.GPDI)   ;
DEF   = log(Dataset.GDPDEF) ;

% Variables for the tables:
LOAN  = Dataset.BUSLOANS;
RSV   = Dataset.ADJRESNS;
DEP   = Dataset.DEMDEPSL;
IBL   = Dataset.IBLACBM027SBOG;

%% Survey of Loans
Ls=(Dataset.EVANQ+Dataset.EVANNQ+Dataset.EVALNQ+Dataset.EVAMNQ+Dataset.EVAONQ);
ws=[(Dataset.EVANQ)./Ls (Dataset.EVANNQ)./Ls (Dataset.EVALNQ)./Ls (Dataset.EVAMNQ)./Ls (Dataset.EVAONQ)./Ls];

TotalLoan_A  =(Dataset.EVANQ+Dataset.EVANNQ+Dataset.EVALNQ+Dataset.EVAMNQ+Dataset.EVAONQ)                       ;
AverageLoan_A=sum(([(Dataset.EAANQ) (Dataset.EAANNQ) (Dataset.EAALNQ) (Dataset.EAAMNQ) (Dataset.EAAONQ)].*ws),2);
Maturity_A   =sum(([(Dataset.EDANQ) (Dataset.EDANNQ) (Dataset.EDALNQ) (Dataset.EDAMNQ) (Dataset.EDAONQ)].*ws),2);
Rates_A      =sum(([(Dataset.EEANQ) (Dataset.EEANNQ) (Dataset.EEALNQ) (Dataset.EEAMNQ) (Dataset.EEAONQ)].*ws),2);

TotalLoan_S  =(Dataset.EVSNQ+Dataset.EVSNQ+Dataset.EVSLNQ+Dataset.EVSMNQ+Dataset.EVSONQ)                        ;
AverageLoan_S=sum(([(Dataset.EASNQ) (Dataset.EASNNQ) (Dataset.EASLNQ) (Dataset.EASMNQ) (Dataset.EASONQ)].*ws),2);
Maturity_S   =sum(([(Dataset.EDSNQ) (Dataset.EDSNNQ) (Dataset.EDSLNQ) (Dataset.EDSMNQ) (Dataset.EDSONQ)].*ws),2);
Rates_S      =sum(([(Dataset.EESNQ) (Dataset.EESNNQ) (Dataset.EESLNQ) (Dataset.EESMNQ) (Dataset.EESONQ)].*ws),2);

TotalLoan_M  =(Dataset.EVMNQ+Dataset.EVMNQ+Dataset.EVMLNQ+Dataset.EVMMNQ+Dataset.EVMONQ)                        ;
AverageLoan_M=sum(([(Dataset.EAMNQ) (Dataset.EAMNNQ) (Dataset.EAMLNQ) (Dataset.EAMMNQ) (Dataset.EAMONQ)].*ws),2);
Maturity_M   =sum(([(Dataset.EDMNQ) (Dataset.EDMNNQ) (Dataset.EDMLNQ) (Dataset.EDMMNQ) (Dataset.EDMONQ)].*ws),2);
Rates_M      =sum(([(Dataset.EEMNQ) (Dataset.EEMNNQ) (Dataset.EEMLNQ) (Dataset.EEMMNQ) (Dataset.EEMONQ)].*ws),2);

%% Data Conversions
lambda_hp=1600     ; % <- Organize

nomlist={'TotalLoan_S','AverageLoan_S','TotalLoan_M','AverageLoan_M','TotalLoan_A','AverageLoan_A'};
n2rlist=nomlist;
BDP_nom2real;

% Extrating Trends and linear trends
DateEndTrend=Beg_GreatRec+20; % Date for end of linear trend
initlindate=datenum('31-Dec-2007');
pl=6; pu=32;

varlist={'RTotalLoan_S','RAverageLoan_S','RTotalLoan_M','RAverageLoan_M','RTotalLoan_A','RAverageLoan_A'};
BDP_transformations;

dates_slo=dates;

%% Crisis Analysis 
% 'GDPC96','GDPPOT','FPIC96','PCECC96',OPHNFB,ULCNFB,HOANBS
% RCPHBS -  Business Sector: Real Compensation Per Hour
% OPHNFB -  Nonfarm Business Sector: Output Per Hour of All Persons 
% ULCNFB -  Nonfarm Business Sector: Unit Labor Cost (ULCNFB)
% HOANBS - Nonfarm Business Sector: Hours of All Persons (HOANBS)
GDPC96 =Dataset.GDPC96;
INV96  = Dataset.PNFIC96 ;
CONS96  = Dataset.PCECC96;
WAGES   = Dataset.ULCNFB;
Y_L       = GDPC96./exp(HOURS);
GDP_pot=Dataset.GDPPOT;
GDP_pathg=GDPC96./GDPC96(Beg_date);
GDP_potg=[1; GDP_pot(2:end)./GDP_pot(1:end-1)];
RGDP_path=(GDP_pathg-GDP_potg);
RINV_pathg=INV96./INV96(Beg_date);
RINV_path=(RINV_pathg-GDP_potg);
RCONS_pathg=CONS96./CONS96(Beg_date);
RCONS_path=(RCONS_pathg-GDP_potg);
HOURS_pathg=(exp(HOURS)/exp(HOURS(Beg_date)));
RHOURS_path=(HOURS_pathg-1);
RHWAGES_pathg=WAGES./WAGES(Beg_date);
RHWAGES_path=(RHWAGES_pathg-GDP_potg);
MPL_path    = (Y_L./Y_L(Beg_date)-1);

% % Real Side Variables - Start Building Series
% % Extracting Linear Trends
tau=1;
% % Compute Quarterly GDP Growth Rates - Nominal
GDP_g=mean([(diff(GDP(Beg_Plot:Beg_Plot+5))); diff(GDP(Beg_Plot:Beg_GreatRec-1))])      ;
% % Compute Quarterly GDP Growth Rates
DEF_g=mean([(diff(DEF(Beg_Plot:Beg_Plot+5))); diff(DEF(Beg_Plot:Beg_GreatRec-1))])      ;
% HOURS_g=mean([(diff(HOURS(1:5))); diff(HOURS(1:Beg_GreatRec-1))]);
Trend_g=GDP_g-DEF_g                                              ;
Trend_gdp=Trend_g                                                ;
% Trend=tau*Trend_g*(((Beg_date:End_date)-(Beg_date))>0)'          ;
% HTrend=HOURS_g*(((Beg_date:End_date)-(Beg_date))>0)'             ;
% DEF_path=(DEF(Beg_date:End_date)-DEF(Beg_date))               ;
% GDP_path=GDP(Beg_date:End_date)-GDP(Beg_date)-DEF_path           ;
% RGDP_path=GDP_path-Trend                                         ;
% CONS_path=CONS(Beg_date:End_date)-CONS(Beg_date)-DEF_path        ;
% RCONS_path=CONS_path-Trend                                       ;
% INV_path=exp(INV(Beg_date:End_date)-INV(Beg_date))-1-DEF_path           ;
% RINV_path=INV_path-Trend                                         ; 
% HOURS_path=HOURS(Beg_date:End_date)-HOURS(Beg_date)              ;
% RHOURS_path=HOURS_path-HTrend                                    ;
% HWAGES=WAGES-HOURS                                               ;   
% RHWAGES_path=HWAGES(Beg_date:End_date)-HWAGES(Beg_date)-DEF_path ;
% GDP_cris=GDP(Beg_date-Extra:End_date)                            ;
% MPL_path=GDP_path-HOURS_path                                     ;

% Real Side Variables - Start Building Series
rROE_path  =rROE(Beg_date:end)  ;
rROA_path  =rROA(Beg_date:end)  ;
EQTA_path  =EQTA(Beg_date:end)  ;
USNIM_path =USNIM(Beg_date:end) ;
NPCMCM_path=NPCMCM(Beg_date:end);
NCOCMC_path=NCOCMC(Beg_date:end);

% Substracting Average
LOANS_g         =mean([(diff(TOTLL(1:5))); diff(TOTLL(1:Beg_GreatRec-1))]);
DEF_path        =DEF(1:end)-DEF(Beg_date)                          ;
TREND_g         =LOANS_g-DEF_g                                            ;
Trend           =tau*TREND_g*(((1:length(TOTLL))-(Beg_date))>0)'   ;
TOTLL_path      =TOTLL(1:end)-TOTLL(Beg_date)-DEF_path             ;
RTOTLL_path     =TOTLL_path-Trend                                         ;
BUSLOANS_path   =BUSLOANS(1:end)/BUSLOANS(Beg_date)-DEF_path       ; 
RBUSLOANS_path  =BUSLOANS_path-Trend                                      ; 
REALLN_path     =REALLN(1:end)-REALLN(Beg_date)-DEF_path           ;
RREALLN_path    =REALLN_path-Trend                                        ;
CONSUMER_path   =CONSUMER(1:end)-CONSUMER(Beg_date)-DEF_path       ;
RCONSUMER_path  =CONSUMER_path-Trend   ;                         


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Plots
% Syntax for plots:
%
% date_types= one of 'dec', 'gr', 'all' (decade, great recession, whole series)
% FRED_fix_dates
% BDP_autoplot (or BDP_benchautoplot)
% title('\bfName of Series')
% ylabel('Units')

printit = 1;

figure
% Output
date_types='gr';
FRED_fix_dates;

subplot(3,2,1:2,'align');
pseries={'100*RGDP_path'};
BDP_autoplot;
title('\bf Output');
ylabel('%'); grid on;


% Consumption
subplot(3,2,3,'align');
pseries={'100*RCONS_path'};
BDP_autoplot;
title('\bf Consumption');
ylabel('%'); grid on;


% Investment
subplot(3,2,4,'align');
pseries={'100*RINV_path'};
BDP_autoplot;
title('\bf Investment');
ylabel('%'); grid on;


% Hours
subplot(3,2,5,'align');
pseries={'100*RHOURS_path'};
BDP_autoplot;
title('\bf Hours');
ylabel('%'); grid on;


% MPL_path
subplot(3,2,6,'align');
pseries={'100*MPL_path'};
BDP_autoplot;
title('\bf Marginal Product of Labor');
ylabel('%'); grid on;
orient landscape;

% Title of Graph
suptitle('Deviation from Historical Growth Rates')
orient landscape;
if printit==1
    saveas(gcf,'F_realside_tit','pdf');
end

%%%%%%
printit = 1;
date_types='dec';
FRED_fix_dates;

figure
aux=[NaN(Beg_GreatRec-3,1); GDP(Beg_GreatRec-2)+Trend_gdp*(1:T-(Beg_GreatRec-3))'];
pseries={'GDP','aux'};
BDP_autoplot;
title('\bf Log - GDP');
ylabel('end of year %'); grid on;
orient landscape;

if printit==1
    saveas(gcf,'F_output','pdf');
end                                                                                        ;

% Investment
figure
expin=exp(INV);
pseries={'expin'};
BDP_autoplot;
title('\bf Investment');
ylabel('US$ Billion'); grid on;
orient landscape;

if printit==1
    saveas(gcf,'INV_path','pdf');
end  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Real GDP - Level minus Trend
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Current Plot Parameters
printit=1;

rgdp=GDP-DEF;
start=6;
aux=[NaN(Beg_GreatRec-start,1);...
    GDP(Beg_GreatRec-(start-1))-DEF(Beg_GreatRec-(start-1))+Trend_gdp*(1:T-(Beg_GreatRec-start))'];
figure
pseries={'rgdp','aux'};
BDP_autoplot;
title('\bf Log - GDP and Linear Trend');
ylabel('Log - GDP (end of year)'); grid on;
orient landscape;

if printit==1
    saveas(gcf,'F_Routput','pdf');
end      

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot 0.3: Money Aggregates
M1=Dataset.M1SL;
MZM=Dataset.MZMSL;
ER=Dataset.EXCRESNS;
M_Net=MZM-ER;
M1_Net=M1-ER;
% M1SL            M1 money supply (narrow money)
% M2SL            M2 money supply (broad money)
% MZMSL           MZM money supply (really broad money)
% TB3MS           Three-month treasury bill yield
% GS10            Ten-year treasury bond yield
% FEDFUNDS        Effective federal funds rate
% EXCRESNS        Excess Reserves of Depositary Institutions

ldMZM=[NaN; diff(log(MZM))];
figure
pseries={'ldMZM'};
BDP_autoplot;
title('\bf Money Zero Maturity ');
ylabel('Stock'); grid on;
axis([dates_d(1)-2, dates_d(end)+2, 0, 1]);
axis 'auto y'
orient landscape;
printit=0;
if printit==0
    saveas(gcf,'F_MZM_Growth','pdf');
end

lM_Net=log(M_Net);
figure
pseries={'lM_Net'};
BDP_autoplot;
title('\bf Money Zero Maturity ');
ylabel('Stock'); grid on;
axis([dates_d(1)-2, dates_d(end)+2, 0, 1]);
axis 'auto y'
orient landscape;
printit=0;
if printit==0
    saveas(gcf,'F_MZMNet','pdf');
end

lM1_Net=log(M1_Net);
figure
pseries={'lM1_Net'};
BDP_autoplot;
title('\bf M1 Net of Excess Reserves ');
ylabel('Stock'); grid on;
axis([dates_d(1)-2, dates_d(end)+2, 0, 1]);
axis 'auto y'
orient landscape;
printit=0;
if printit==0
    saveas(gcf,'F_M1Net','pdf');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot 0.3: Treasury Bills 
figure
pseries={'100*rTB3','100*rG10','rFEDFUNDS'};
BDP_autoplot;
title('\bf Treasury Bill Rates');
ylabel('%'); grid on;
axis([dates_d(1)-2, dates_d(end)+2, 0, 1]);
axis 'auto y'
legend('3-Month T-Bill','10 year Treasury','FEDFUNDS')
orient landscape;
printit=0;
if printit==0
    saveas(gcf,'F_rates','pdf');
end  

%% Financial Data
figure
subplot(2,1,1)
pseries={'DJIA'};
BDP_autoplot;
title('\bf Dow Jones Industrial Average');
ylabel('%'); grid on;
% axis tight;

subplot(2,1,2)
pseries={'SP500'};
BDP_autoplot;
title('\bf Standard and Poor''s 500');
ylabel('%'); grid on;
axis tight;

orient landscape;
printit=0;
if printit==0
    saveas(gcf,'F_stocks','pdf');
end  

figure
pseries={'VIX'};
BDP_autoplot;
title('\bf VIX Index');
ylabel('%'); grid on;
axis tight;

date_types='gr';
FRED_fix_dates;
figure
pseries={'VIX'};
BDP_autoplot;
title('\bf VIX Index');
ylabel('%'); grid on;
axis tight;

% Save VIX Path
VIX_path=VIX(index_gr);
save VIX_data.mat dates_gr Recessions VIX_path;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLOT 1: Key Banking Sector Indicators
% ROE - Return on Equity 
date_types='dec';
FRED_fix_dates;
figure
subplot(3,2,1,'align');
pseries={'rROE'};
BDP_autoplot;
title('\bfReturn on Equity');
%axis([dates_d(1) - 2, dates_d(end) + 2, 0, 1]);
ylabel('%')
axis 'auto y'

% ROA - Return on Assets
subplot(3,2,2,'align');
pseries={'rROA'};
BDP_autoplot;
title('\bfReturn on Assets');
%axis([dates_d(1) - 2, dates_d(end) + 2, 0, 1]);
ylabel('%')
axis 'auto y'

% EQTA - Leverage Rate
subplot(3,2,3,'align');
pseries={'EQTA'};
BDP_autoplot;
title('\bfEquity to Assets');
%axis([dates_d(1) - 2, dates_d(end) + 2, 0, 1]);
ylabel('%')
axis 'auto y'

% USNIM - Net Interest Margin
subplot(3,2,4,'align');
pseries={'USNIM'};
BDP_autoplot;
title('\bf Net Interest Margin');
%axis([dates_d(1) - 2, dates_d(end) + 2, 0, 1]);
ylabel('%')
axis 'auto y'

% NPCMCM - Non-performing Commercial & Industrial Loans
subplot(3,2,5,'align');
pseries={'NPCMCM'};
BDP_autoplot;
title('\bf Non Performing Commercial Loans');
%axis([dates_d(1) - 2, dates_d(end) + 2, 0, 1]);
ylabel('%')
axis 'auto y'

% NCOCMC - Commercial Loan Rightoffs
subplot(3,2,6,'align');
pseries={'NCOCMC'};
BDP_autoplot;
title('\bf Commercial Loans Right-Offs');
%axis([dates_d(1) - 2, dates_d(end) + 2, 0, 1]);
ylabel('%')
axis 'auto y'

suptitle('Key Banking Indicators')
orient landscape
printit=1;
if printit==1
    saveas(gcf,'F_bankingindicators','pdf');
end

%% PLOT 2: Credit Condition Summary (LEVEL)
pindex=index_plot;
pdate=dates_plot;
figure
pseries={'TOTLL','BUSLOANS','REALLN','CONSUMER'};
BDP_autoplot;
title('\bf Loans per Sector');
h = legend('TOTLL','BUSLOANS','REALLN','CONSUMER','Location','Best');
set(h,'FontSize',7,'Box','off');
ylabel('%')
axis 'auto y'

%% PLOT 2.b: Credit Condition Summary (Growth since recession)
figure
pdate=dates_lr;
pindex=index_lr;
subplot(2,2,1,'align');
pseries={'100*TOTLL_path'};
BDP_autoplot;
title('\bf Total Loans');
ylabel('%'); grid on;
%axis([dates_lr(1) - 10, dates_lr(end) + 10, 0, 1]);
axis 'auto y'

subplot(2,2,2,'align');
pseries={'100*BUSLOANS_path'};
BDP_autoplot;
title('\bf Business Loans');
% h = legend('Data','Location','Best');
% set(h,'FontSize',7,'Box','off');
ylabel('%'); grid on;
%axis([dates_lr(1) - 10, dates_lr(end) + 10, 0, 1]);
axis 'auto y'

subplot(2,2,3,'align');
pseries={'100*CONSUMER_path'};
BDP_autoplot;
title('\bf Consumer Loans');
% h = legend('Data','Location','Best');
% set(h,'FontSize',7,'Box','off');
ylabel('%'); grid on;
%axis([dates_lr(1) - 10, dates_lr(end) + 10, 0, 1]);
axis 'auto y'

subplot(2,2,4,'align');
pseries={'100*REALLN_path'};
BDP_autoplot;
title('\bf Real Estate Loans');
% h = legend('Data','Location','Best');
% set(h,'FontSize',7,'Box','off');
ylabel('%'); grid on;
%axis([dates_lr(1) - 10, dates_lr(end) + 10, 0, 1]);
axis 'auto y'

suptitle('Key Banking Indicators')
orient landscape
printit=0;
if printit==1
    saveas(gcf,'F_BankingLendingSummary1','pdf');
end

%% Plot 3: Survey of Senior Loan Officers
date_types='dec';
FRED_fix_dates;

figure
subplot(2,2,1)
aux1=exp(BUSLOANS./GDP);
aux2=exp(REALLN./GDP);
aux3=exp(CONSUMER./GDP);
pseries={'aux1','aux2','aux3'};
BDP_autoplot;
title('\bfLoans to GDP');
h = legend('BUSLOANS','REALLN','CONSUMER','Location','Best');
set(h,'FontSize',7,'Box','off');
%axis([dates_d(1) + 10, dates_d(end) + 10, 0, 1]);
ylabel('Stock of Loans / GDP')
axis 'auto y'

% the graph above works fine if plotted as a single graph. However, the
% recession bar on the left doesn't fill the entire y-axis if this is plotted as a subplot 
subplot(2,2,2)
aux=exp(USGSEC./GDP);
pseries={'aux'};
BDP_autoplot;
title('\bfInvestments in Securities to GDP');
h = legend('USGSEC','Location','Best');
set(h,'FontSize',7,'Box','off');
%axis([dates_d(1) + 10, dates_d(end) + 10, 0, 1]);
ylabel('Ratio')
axis 'auto y'

subplot(2,2,3)
aux1=DRTSCILM;
aux2=DRSDCILM;
aux3=DRISCFLM;
pseries={'aux1','aux2','aux3'};
BDP_autoplot;
title('\bfSurvey on Loans to Medium/Large Size firms');
h = legend('Tightening Standards','Stronger Demand','Increasing Spreads','Location','Best');
set(h,'FontSize',7,'Box','off');
%axis([dates_d(1) + 10, dates_d(end) + 10, 0, 1]);
ylabel('Ratio')
axis 'auto y'

subplot(2,2,4)
aux1=DRTSCIS;
aux2=DRSDCIS;
aux3=DRISCFS;
pseries={'aux1','aux2','aux3'};
BDP_autoplot;
title('\bfSurvey on Loans to Small firms');
h = legend('Tightening Standards','Stronger Demand','Increasing Spreads','Location','Best');
set(h,'FontSize',7,'Box','off');
%axis([dates_d(1) + 10, dates_d(end) + 10, 0, 1]);
ylabel('Ratio')
axis 'auto y'

suptitle('Key Banking Indicators')
orient landscape
printit=1;
if printit==1
    saveas(gcf,'F_BankingLendingSummary2','pdf');
end


%% Plot 4: SURVEY LOAN OFFICIALS
varlist={'RTotalLoan_S','RAverageLoan_S','RTotalLoan_M','RAverageLoan_M','RTotalLoan_A','RAverageLoan_A'};
BDP_transformations;

date_types='gr';
FRED_fix_dates;

figure
pseries={'RTotalLoan_A','RAverageLoan_A'};
pbench=Beg_GreatRec-1;
BDP_benchautoplot
title('\bf Loan and Loan Size');

figure
pseries={'hp_RTotalLoan_A','hp_RAverageLoan_A'};
pbench=Beg_GreatRec-1;
BDP_benchautoplot
title('\bf Loan and Loan Size');

figure
pseries={'devhpart_RTotalLoan_A','devhpart_RAverageLoan_A'};
pbench=Beg_GreatRec-1;
BDP_autoplot
title('\bf Loan and Loan Size');


date_types='dec';
FRED_fix_dates;
ii = 0;
for qq = 1:numel(question);
    figure 
	for tt = 1:numel(type);
		ii = ii + 1;
		subplot(2,2,tt);
        eval(['pseries={''Dataset.' sloseries{ii} '''};']);
        BDP_autoplot;
		ylabel(['Net percentage']);
		
		subplot(2,2,1)
		title('Large and Medium Firms');
		subplot(2,2,2)
		title('Small Firms');
		subplot(2,2,3)
		title('Prime Mortgage Loans');
		subplot(2,2,4)
		title('Commercial and Real Estate Loans');
      	
    end
    
	if qq == 1
		suptitle('Survey of Loan Officers - Tightening Standards');
        orient landscape
        saveas(gcf,'F_SurveyLoanOfficers_TS','pdf');
	else
		suptitle('Survey of Loan Officers - Stronger Demand');
        orient landscape
        saveas(gcf,'F_SurveyLoanOfficers_SD','pdf');
	end
		
end

figure
ii = 0;
for qq = 1:numel(question);
    figure 
	for tt = 1:numel(type);
        ii = ii + 1;
        subplot(2,2,tt);
        eval(['pseries={''Dataset.' sloseries{ii} ''',''10*Dataset.FEDFUNDS''};']);
        BDP_autoplot;
        ylabel(['Net percentage']);

        subplot(2,2,1)
        title('Large and Medium Firms');
        subplot(2,2,2)
        title('Small Firms');
        subplot(2,2,3)
        title('Prime Mortgage Loans');
        subplot(2,2,4)
        title('Commercial and Real Estate Loans');      	
    end
    legend('Response','FedFunds Rate x10','Orientation','Horizontal');
    
	if qq == 1
		suptitle('Survey of Loan Officers - % Declaring Tightening Standards');
        orient landscape
        saveas(gcf,'F_SurveyLoanOfficers_TS_m','pdf');
	else
		suptitle('Survey of Loan Officers - % Declaring Stronger Demand');
        orient landscape
        saveas(gcf,'F_SurveyLoanOfficers_SD_m','pdf');
	end
		
end

%%

figure
ii=0;
jj=0;
for vv=1:numel(vars);                 % Plot by Risk - For 
    for mm=1:numel(maturity);         % By Maturity Structure
        ii=ii+1;
        subplot(4,3,ii);
        pseries={};
        for rr=1:numel(risks)-1;
            jj=jj+1;
            % By Variable 
            eval(['pseries=[pseries, ''Dataset.' loanseries{jj} '''];']);              
        end
        jj=jj+1;
        eval(['pseries=[pseries, ''Dataset.' loanseries{jj} '''];']);
        BDP_autoplot;
    end
end
% Add Titles 
subplot(4,3,1);
title('All Maturities')
ylabel(['Total Amount Loan']);
subplot(4,3,2);
title('Short Maturity (1-30 days)')
subplot(4,3,3);
title('Long Maturity (31-365 days)')
subplot(4,3,4);
ylabel(['Average Loan Size']);
subplot(4,3,7);
ylabel(['Average Maturity in Days']);
subplot(4,3,10);
ylabel(['Average Rate']);
subplot(4,3,11);
h = legend('Total','Minimal','Low','Medium','High','Orientation','Horizontal');
set(h,'FontSize',7,'Box','off','Position',[0.30 0.02 0.38 0.04]);
suptitle('Survey of Loans Officials')

% Print
orient landscape
printit=1;
if printit==1
    saveas(gcf,'F_SLO','pdf');
end

%% Survey of Lending Terms
% figure
date_types='gr';
FRED_fix_dates;
fignum=gcf;
ii=0;
jj=0;
for vv=1:numel(vars);                 % Plot by Risk - For 
    for mm=1:numel(maturity);         % By Maturity Structure
        ii=ii+1;
        for rr=1:numel(risks)-1;
            figure(fignum+rr)
            subplot(4,3,ii);
            jj=jj+1;
            
            % By Variable 
            eval(['pseries={''Dataset.' loanseries{jj} '''};']);
            BDP_autoplot;
            end        
       % axis([dates_gr(1) - 5, dates_gr(end) + 5, 0, 1]);
        axis 'auto y'
    end
end
for rr=1:numel(risks)-1;
    figure(fignum+rr)
    subplot(4,3,1);
    title('All Maturities')
    ylabel(['Total Amount Loan']);
    subplot(4,3,2);
    title('Short Maturity (1-30 days)')
    subplot(4,3,3);
    title('Long Maturity (31-365 days)')
    subplot(4,3,4);
    ylabel(['Average Loan Size']);
    subplot(4,3,7);
    ylabel(['Average Maturity in Days']);
    subplot(4,3,10);
    ylabel(['Average Rate']);
    subplot(4,3,11);
    
    switch rr
        case 1
          suptitle(['Risk Type: Not Available' risks(rr)])
          orient landscape
            printit=1;
            if printit==1
                saveas(gcf,'F_SLO_na','pdf');
            end
        case 2
          suptitle(['Risk Type: Minimal' risks(rr)])    
                    orient landscape
            printit=1;
            if printit==1
                saveas(gcf,'F_SLO_minimal','pdf');
            end

        case 3
          suptitle(['Risk Type: Low' risks(rr)])         
                    orient landscape
            printit=1;
            if printit==1
                saveas(gcf,'F_SLO_low','pdf');
            end

        case 4
          suptitle(['Risk Type: Medium' risks(rr)])             
                    orient landscape
            printit=1;
            if printit==1
                saveas(gcf,'F_SLO_medium','pdf');
            end

        case 5
          suptitle(['Risk Type: Other'])  
                    orient landscape
            printit=1;
            if printit==1
                saveas(gcf,'F_SLO_other','pdf');
            end

    end
    % MINIMAL         N
    % LOW             L
    % MEDIUM          M
    % OTHER           O
end
        
%% SLO Total Loans
date_types='gr';
FRED_fix_dates;
pbench=index_gr(1);

figure
subplot(2,2,1:2);
jj=1;
% By Variable 
eval(['pseries={''Dataset.' loanseries{jj} '''};']);
BDP_benchautoplot2;
title('Total Amount','FontSize',16); grid on;

subplot(2,2,3);
jj=16;
% By Variable 
eval(['pseries={''Dataset.' loanseries{jj} '''};']);
BDP_benchautoplot2;
title('Average Size','FontSize',16); grid on;

subplot(2,2,4);
jj=46;
eval(['pseries={''Dataset.' loanseries{jj} '''};']);
BDP_benchautoplot2;
title('Interest Rate','FontSize',16); grid on;

orient landscape
printit=1;
if printit==1
    saveas(gcf,'F_SLO_all','pdf');
end

%% Survey of Lending Terms
% figure
% close all;
fignum=gcf;
ii=0;
jj=0;
for vv=1:numel(vars);                 % Plot by Risk - For 
    for mm=1:numel(maturity);         % By Maturity Structure
        for rr=1:numel(risks)-1;
            figure(fignum+rr)
            jj=(vv-1)*(numel(maturity)*numel(risks))+(mm-1)*numel(risks)+rr;
            ii=(vv-1)*numel(maturity)+mm;
            subplot(4,3,ii);
                        
            % By Variable 
            eval(['pseries={''Dataset.' loanseries{jj} '''};']);
            BDP_autoplot;
        end        
       % axis([dates_gr(1) - 5, dates_gr(end) + 5, 0, 1]);
        axis 'auto y'
    end
end

for rr=1:numel(risks)-1;
    figure(fignum+rr)
    subplot(4,3,1);
    title('All Maturities')
    ylabel(['Total Amount Loan']);
    subplot(4,3,2);
    title('Short Maturity (1-30 days)')
    subplot(4,3,3);
    title('Long Maturity (31-365 days)')
    subplot(4,3,4);
    ylabel(['Average Loan Size']);
    subplot(4,3,7);
    ylabel(['Average Maturity in Days']);
    subplot(4,3,10);
    ylabel(['Average Rate']);
    subplot(4,3,11);
    
    switch rr
        case 1
          suptitle(['Risk Type: Not Available' risks(rr)])
          orient landscape
            printit=1;
            if printit==1
                saveas(gcf,'F_SLO_na','pdf');
            end
        case 2
          suptitle(['Risk Type: Minimal' risks(rr)])    
                    orient landscape
            printit=1;
            if printit==1
                saveas(gcf,'F_SLO_minimal','pdf');
            end

        case 3
          suptitle(['Risk Type: Low' risks(rr)])         
                    orient landscape
            printit=1;
            if printit==1
                saveas(gcf,'F_SLO_low','pdf');
            end

        case 4
          suptitle(['Risk Type: Medium' risks(rr)])             
                    orient landscape
            printit=1;
            if printit==1
                saveas(gcf,'F_SLO_medium','pdf');
            end

        case 5
          suptitle(['Risk Type: Other'])  
                    orient landscape
            printit=1;
            if printit==1
                saveas(gcf,'F_SLO_other','pdf');
            end

    end
    % MINIMAL         N
    % LOW             L
    % MEDIUM          M
    % OTHER           O
end
            
%% PLOT 4: Real Sector Variables
% Plot Options
DataColor=[0.1 0.45 0.13]       ;
Marker='D'                      ;
Width=2                         ;
MarkerSize=8                    ;
MarkerEdgeColor=[0.1 0.45 0.13] ;
MarkerFaceColor=[0.1 0.85 0.1]  ;

% Begin Plot of Real Variables
pbench=index_gr(1);
date_types='gr';
FRED_fix_dates;
figure

subplot(2,2,1:2,'align');
pseries={'Ls'};
BDP_benchautoplot2;
title('\bf Total Loans');
ylabel('%'); grid on;
%axis([dates_gr(1) - 50, dates_gr(end) + 50, 0, 1]);
axis 'auto y'

subplot(2,2,3,'align');
pseries={'AverageLoan_S'};
BDP_benchautoplot2;
title('\bf Average Size');
% h = legend('Data','Location','Best');
% set(h,'FontSize',7,'Box','off');
ylabel('%'); grid on;
%axis([dates_gr(1) - 50, dates_gr(end) + 50, 0, 1]);
axis 'auto y'

subplot(2,2,4,'align');
pseries={'Rates_S'};
BDP_autoplot;
title('\bf Average Rates');
% h = legend('Data','Location','Best');
% set(h,'FontSize',7,'Box','off');
ylabel('%'); grid on;
%axis([dates_gr(1) - 50, dates_gr(end) + 50, 0, 1]);
axis 'auto y'

orient landscape;
printit=0;
if printit==1
    saveas(gcf,'F_SLO_GR','pdf');
end

% Title of Graph
suptitle('Survey Loan Officials')

orient landscape;
printit=0;
if printit==1
    saveas(gcf,'F_SLO_GR_tit','pdf');
end

%% Plot 4: Merrill Lynch and Moody's Data Survery 
date_types='dec';
FRED_fix_dates;
figure
subplot(3,1,1)
pseries={'BOA_AAA','BOA_AA','BOA_A','BOA_BBB'};
BDP_autoplot;
title('\bfCorporate Bond Spreads^{1}');
h = legend('AAA','AA','A','BBB','Location','NorthWest');
set(h,'FontSize',7,'Box','off');
%axis([dates_d(1) + 10, dates_d(end) + 10, 0, 1]);
ylabel('%')
axis 'auto y'

subplot(3,1,2)
pseries={'BOA_BB','BOA_B','BOA_C'};
BDP_autoplot;
title('\bfHigh Yield Spreads^{2}');
h = legend('BB','B','C','Location','NorthWest');
set(h,'FontSize',7,'Box','off');
%axis([dates_d(1) + 10, dates_d(end) + 10, 0, 1]);
ylabel('%')
axis 'auto y'

subplot(3,1,3)
pseries={'MOO_AAA','MOO_BAA'};
BDP_autoplot;
title('\bfHigh Yield Spreads^{3}');
h = legend('AAA','BAA','Location','NorthWest');
set(h,'FontSize',7,'Box','off');
%axis([dates_d(1) + 10, dates_d(end) + 10, 0, 1]);
ylabel('%')
axis 'auto y'

suptitle('Corporate Bond Spreads')
orient landscape
printit=1;
if printit==1
    saveas(gcf,'F_bonds','pdf');
end

%% Corporate Bond Spreads Crisis
date_types='gr';
FRED_fix_dates;

figure
subplot(3,1,1)
pseries={'BOA_AAA','BOA_AA','BOA_A','BOA_BBB'};
BDP_autoplot;
title('\bfCorporate Bond Spreads^{1}');
h = legend('AAA','AA','A','BBB','Location','NorthWest');
set(h,'FontSize',7,'Box','off');
%axis([dates_gr(1) + 10, dates_gr(end) + 10, 0, 1]);
ylabel('%')
axis 'auto y'

subplot(3,1,2)
pseries={'BOA_BB','BOA_B','BOA_C'};
BDP_autoplot;
title('\bfHigh Yield Spreads^{2}');
h = legend('BB','B','C','Location','NorthWest');
set(h,'FontSize',7,'Box','off');
%axis([dates_gr(1) + 10, dates_gr(end) + 10, 0, 1]);
ylabel('%')
axis 'auto y'

subplot(3,1,3)
pseries={'MOO_AAA','MOO_BAA','MOO_BAA'};
BDP_autoplot;
title(['\bf Moody''' 's ^{3}']);
h = legend('AAA','BAA','Location','NorthWest');
set(h,'FontSize',7,'Box','off');
%axis([dates_gr(1) + 10, dates_gr(end) + 10, 0, 1]);
ylabel('%')
axis 'auto y'

suptitle('Corporate Bond Spreads')
orient landscape
printit=0;
if printit==1
    saveas(gcf,'F_bonds','pdf');
end
dates_cb=dates;
save cbs.mat dates_cb index_gr MOO_AAA MOO_BAA BOA_BB BOA_B BOA_C BOA_AAA BOA_AA BOA_A BOA_BBB;

%% Plot 5: Commercial Paper Ratings and Issuance
date_types='dec';
FRED_fix_dates;
figure
subplot(2,2,1)
pseries={'Dataset.ABCOMP','Dataset.FINCP'};
BDP_autoplot;
title('\bf Outstanding Commercial Paper');
h = legend('Asset Backed','Fin','Location','Best');
set(h,'FontSize',7,'Box','off');
axis([dates_d(1) + 10, dates_d(end) + 10, 0, 1]);
ylabel('US$ Billion')
axis 'auto y'

subplot(2,2,2)
pseries={'Dataset.COMPAPER'};
BDP_autoplot;
title('\bf Outstanding Non-Financial Non-ABS CP');
axis([dates_d(1) + 2, dates_d(end) + 2, 0, 1]);
ylabel('%')
axis 'auto y'

subplot(2,2,3)
pseries={'CPN1M','CPN2M','CPN3M'};
BDP_autoplot;
title('\bfSpreads of Non-Financial Non-ABS CP');
h = legend('1-month','2-month','3-month','Location','Best');
set(h,'FontSize',7,'Box','off');
axis([dates_d(1) + 2, dates_d(end) + 2, 0, 1]);
ylabel('%')
axis 'auto y'

subplot(2,2,4)
pseries={'CPF1M','CPF2M','CPF3M'};
BDP_autoplot;
title('\bfSpreads of Financial CP');
h = legend('1-month','2-month','3-month','Location','Best');
set(h,'FontSize',7,'Box','off');
axis([dates_d(1) + 2, dates_d(end) + 2, 0, 1]);
ylabel('%')
axis 'auto y'

suptitle('Commercial Paper')
orient landscape
printit=1;
if printit==1
    saveas(gcf,'F_CP','pdf');
end

%% Commercial Paper for Great Recession
ABCOMP=Dataset.ABCOMP;
FINCP=Dataset.FINCP;

date_types='gr';
FRED_fix_dates;

figure
subplot(2,2,1)
pseries={'ABCOMP','FINCP'};
BDP_autoplot;
title('\bf Outstanding ABCP','FontSize',16);
%h = legend('Asset Backed','Location','Best');
%set(h,'FontSize',7,'Box','off');
axis([dates_gr(1) + 10, dates_gr(end) + 10, 0, 1]);
ylabel('US$ Billion'); grid on;
axis 'auto y'

% COMPAPER=Dataset.COMPAPER;
subplot(2,2,2)
pseries={'Dataset.COMPAPER'};
BDP_autoplot;
title('\bf Outstanding Non-Financial Non-AB CP','FontSize',16);
% axis([dates_gr(1) + 10, dates_gr(end) + 10, 0, 1]);
ylabel('US$ Billion')
axis 'auto y'

subplot(2,2,3)
pseries={'CPF1M_f','CPF2M_f','CPF3M_f'};
BDP_autoplot;
title('\bfSpreads of Financial CP','FontSize',16);
h = legend('1-month','2-month','3-month','Location','Best');
set(h,'FontSize',7,'Box','off');
axis([dates_gr(1) + 2, dates_gr(end) + 2, 0, 1]);
ylabel('%')
axis 'auto y'

subplot(2,2,4)
pseries={'CPN1M_f','CPN2M_f','CPN3M_f'};
BDP_autoplot;
title('\bfSpreads of Non-Financial Non-ABS CP','FontSize',16);
h = legend('1-month','2-month','3-month','Location','Best');
set(h,'FontSize',7,'Box','off');
axis([dates_gr(1) + 2, dates_gr(end) + 2, 0, 1]);
ylabel('%')
axis 'auto y'

suptitle('Commercial Paper')
orient landscape
printit=1;
if printit==1
    saveas(gcf,'F_CP','pdf');
end

date_types='gr';
FRED_fix_dates;
pbench=index_gr(1);

figure
subplot(2,1,1)
pseries={'Dataset.COMPAPER'};
BDP_benchautoplot2;
title('\bf Outstanding Non-Financial Non-AB CP','FontSize',16);
% axis([dates_gr(1) + 10, dates_gr(end) + 10, 0, 1]);
% ylabel('US$ Billion')
axis 'auto y'

subplot(2,1,2)
pseries={'CPN1M_f','CPN2M_f','CPN3M_f'};
BDP_autoplot;
title('\bfSpreads of Non-Financial Non-ABS CP','FontSize',16);
h = legend('1-month','2-month','3-month','Location','Best');
set(h,'FontSize',7,'Box','off');
axis([dates_gr(1) + 2, dates_gr(end) + 2, 0, 1]);
ylabel('%')
axis 'auto y'

save cp.mat CPN1M_f CPN2M_f CPN3M_f ABCOMP FINCP CPF1M_f CPF2M_f CPF3M_f; 

%% Plot 6: Corporate Sector Balance Sheet
date_types='dec';
FRED_fix_dates;

figure
subplot(3,2,1:2)
pseries={'TABSNNCB','TLBSNNCB'};
BDP_autoplot;
title('\bfBalance Sheet - Corporations');
h = legend('Assets','Liabilities','Location','Best');
set(h,'FontSize',7,'Box','off');
% axis([dates_d(1) + 2, dates_d(end) + 2, 0, 1]);
axis tight;
ylabel('Log Billions US$')
axis 'auto y'

subplot(3,2,3)
pseries={'IABSNNCB','ESABSNNCB','REABSNNCB'};
BDP_autoplot;
title('\bfTangible Assets ');
h = legend('Inventory','Mach + Eq','Real Estate','Location','Best');
set(h,'FontSize',7,'Box','off');
% axis([dates_d(1) + margin, dates_d(end) + margin, 0, 1]);
axis tight;
ylabel('Log Billions US$')
axis 'auto y'

subplot(3,2,4)
pseries={'BLNECLBSNNCB','CPLBSNNCB','CBLBSNNCB','MLBSNNCB'};
BDP_autoplot;
title('\bfCredit Market Assets and Trade Receivables');
h = legend('Loans N.E.C.','Commercial Paper','Bonds','Mortgages','Location','Best');
set(h,'FontSize',7,'Box','off');
% axis([dates_d(1) + margin, dates_d(end) + margin, 0, 1]);
axis tight;
ylabel('Log Billions US$')
axis 'auto y'

subplot(3,2,5)
pseries={'TFAABSNNCB','TRABSNNCB'};
BDP_autoplot;
title('\bfBalance Sheet - NonCorporate Businesses');
h = legend('Financial Assets','Trade Receivables','Location','Best');
set(h,'FontSize',7,'Box','off');
% axis([dates_d(1) + margin, dates_d(end) + margin, 0, 1]);
axis tight;
ylabel('Log Billions US$')
axis 'auto y'


subplot(3,2,6)
pseries={'TCMILBSNNCB','TPLBSNNCB','TXPLBSNNCB'};
BDP_autoplot;
title('\bfCredit Market Liabilities');
h = legend('Credit Market Liabilities','Trade Payables','Tax Payables','Location','Best');
set(h,'FontSize',7,'Box','off');
% axis([dates_d(1) + margin, dates_d(end) + margin, 0, 1]);
axis tight;
ylabel('Log Billions US$')
axis 'auto y'

printit=1;
if printit==1
   orient landscape
   saveas(gcf,'F_corporate','pdf');
end

%% Figure
date_types='dec';
FRED_fix_dates;

figure
pseries={'BLNECLBSNNCB','CPLBSNNCB','CBLBSNNCB','MLBSNNCB','TPLBSNNCB'};
BDP_autoplot;
title('\bf Corporate Liabilities');
h = legend('Loans N.E.C.','Commercial Paper','Bonds','Mortgages','Payables','Location','NorthWest');
set(h,'FontSize',7,'Box','off');
% axis([dates_d(1) + margin, dates_d(end) + margin, 0, 1]);
axis tight;
ylabel('Billions US$')
axis 'auto y'
orient landscape
saveas(gcf,'F_CorporateLiab','pdf');

figure
pseries={'BLNECLBSNNB','MLBSNNB','TCMILBSNNB','TPLBSNNB'};
BDP_autoplot;
title('\bf Non-Corporate Liabilities');
h = legend('Loans N.E.C.','Commercial Mortgages','Credit Market Liabilities','Payables','Location','NorthWest');
set(h,'FontSize',7,'Box','off');
% axis([dates_d(1) + margin, dates_d(end) + margin, 0, 1]);
axis tight;
ylabel('Billions US$')
axis 'auto y'
orient landscape
saveas(gcf,'F_NonCorporateLiab','pdf');

%% Non-Corporate
figure
area(dates_d, [BLNECLBSNNB(index_d),MLBSNNB(index_d),TCMILBSNNB(index_d),TPLBSNNB(index_d),TXLBSNNB(index_d)],'LineWidth',3);
hold on;
Example_RecessionPlot(dates_d, Recessions);
dateaxis('x',12);
set(gca,'XTick',dates_d(5:12:end));
datetick('x','mmmyy','keepticks');
title('\bf Liabilities of Non-Corporate Sector');
h = legend('Loans N.E.C.','Commercial Mortgages','Credit Market Liabilities','Trade Payables','Tax Payables','Location','NorthWest');
set(h,'FontSize',7,'Box','off');
% axis([dates_d(1) + margin, dates_d(end) + margin, 0, 1]);
axis tight;
ylabel('Log Billions US$')
axis 'auto y'


%% Plot 8: Loans from Flow of Funds
save FoF_loans.mat BLNECLBSNNCB BLNECLBSNNB BUSLOANS;

%% Plot 7: Balance Sheet of Non-Farm Non-Corporate Business Firms
date_types='dec';
FRED_fix_dates;

figure
subplot(3,2,1:2)
pseries={'TABSNNB','TLBSNNB'};
BDP_autoplot;
title('\bfBalance Sheet - NonCorporate Businesses');
h = legend('Assets','Liabilities','Location','Best');
set(h,'FontSize',7,'Box','off');
% axis([dates_d(1) + margin, dates_d(end) + margin, 0, 1]);
axis tight;
ylabel('Log Billions US$')
axis 'auto y'

subplot(3,2,3)
pseries={'IABSNNB','ESABSNNB','REABSNNB'};
BDP_autoplot;
title('\bfTangible Assets');
h = legend('Inventory','Mach + Eq','Real Estate','Location','Best');
set(h,'FontSize',7,'Box','off');
% axis([dates_d(1) + margin, dates_d(end) + margin, 0, 1]);
axis tight;
ylabel('Log Billions US$')
axis 'auto y'

subplot(3,2,5)
pseries={'TFAABSNNB','TRABSNNB'};
BDP_autoplot;
title('\bfCredit Market Assets and Trade Receivables');
h = legend('Financial Assets','Trade Receivables','Location','Best');
set(h,'FontSize',7,'Box','off');
% axis([dates_d(1) + margin, dates_d(end) + margin, 0, 1]);
axis tight;
ylabel('Log Billions US$')
axis 'auto y'

subplot(3,2,4)
pseries={'BLNECLBSNNB','MLBSNNB'};
BDP_autoplot;
title('\bf Credit Market Liabilities ');
h = legend('Loans N.E.C.','Mortgages','Location','Best');
set(h,'FontSize',7,'Box','off');
% axis([dates_d(1) + margin, dates_d(end) + margin, 0, 1]);
axis tight;
ylabel('Log Billions US$')
axis 'auto y'

subplot(3,2,6)
pseries={'TCMILBSNNB','TPLBSNNB','TXLBSNNB'};
BDP_autoplot;
title('\bf Credit Market and Other Liabilites ');
h = legend('Credit Market Liabilities','Trade Payables','Tax Payables','Location','Best');
set(h,'FontSize',7,'Box','off');
% axis([dates_d(1) + margin, dates_d(end) + margin, 0, 1]);
axis tight;
ylabel('Log Billions US$')
axis 'auto y'
printit=1;
if printit==1
   orient landscape
   saveas(gcf,'F_noncorporate','pdf');
end

%% Non-Corporate
figure
area(dates_d, [BLNECLBSNNB(index_d),MLBSNNB(index_d),TCMILBSNNB(index_d),TPLBSNNB(index_d),TXLBSNNB(index_d)],'LineWidth',3);
hold on;
Example_RecessionPlot(dates_d, Recessions);
dateaxis('x',12);
set(gca,'XTick',dates_d(5:12:end));
datetick('x','mmmyy','keepticks');
title('\bf Liabilities of Non-Corporate Sector');
h = legend('Loans N.E.C.','Commercial Mortgages','Credit Market Liabilities','Trade Payables','Tax Payables','Location','NorthWest');
set(h,'FontSize',7,'Box','off');
% axis([dates_d(1) + margin, dates_d(end) + margin, 0, 1]);
axis tight;
ylabel('Log Billions US$')
axis 'auto y'


%% Building Latex Tables
% Real Side Variables
filename=['RealSide_FinCris.txt']                                                                       ;
fid = fopen(filename,'wt')                                                                              ;
fprintf(fid,'\n \\begin{tabular}{|l|c|} \\hline ')                                                      ;
fprintf(fid,'\n \\cellcolor{blue!10} & \\cellcolor{blue!10} \\textbf{Data 2007Q4-2009Q2} \\\\ \\hline ');
fprintf(fid,'\n Output &  %0.3g\\%% \\\\ \\hline',RGDP_path(end-Extra)*100)                             ;
fprintf(fid,'\n Consumption & %0.3g\\%% \\\\ \\hline',RCONS_path(end-Extra)*100)                        ;
fprintf(fid,'\n Investment & %0.3g\\%% \\\\ \\hline',RINV_path(end-Extra)*100)                          ;
fprintf(fid,'\n Hours & %0.3g\\%% \\\\ \\hline',RHOURS_path(end-Extra)*100)                             ;
fprintf(fid,'\n Wages & %0.3g\\%% \\\\ \\hline',RHWAGES_path(end-Extra)*100)                            ;
fprintf(fid,'\n MPL & $\\Uparrow$ \\\\ \\hline')                                                        ;
fclose('all')   

% Key Banki Indicators 
filename=['BankIndgicators_FinCris.txt']                                                                       ;
fid = fopen(filename,'wt')                                                                              ;
fprintf(fid,'\n \\begin{tabular}{|l|c|c|} \\hline ')                                                      ;
fprintf(fid,'\n \\cellcolor{blue!10} & \\cellcolor{blue!10} \\textbf{Data 2007Q4} & \\cellcolor{blue!10} \\textbf{Crisis Trough} \\\\ \\hline ');
fprintf(fid,'\n Return on Equity &  %0.3g\\%% & %0.3g\\%% \\\\ \\hline',rROE_path(1),min(rROE_path))                      ;
fprintf(fid,'\n Return on Assets & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',rROA_path(1),min(rROA_path))                       ;
fprintf(fid,'\n Equity to Asset Ratio & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',EQTA_path(1),min(EQTA_path))                  ;
fprintf(fid,'\n Net Interest Margin & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',USNIM_path(1),max(USNIM_path))                  ; 
fprintf(fid,'\n Non-Performing C\\&I Loans & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',NPCMCM_path(1),max(NPCMCM_path))           ;
fprintf(fid,'\n C\\&I Loan Right-Offs &  %0.3g\\%% &  %0.3g\\%%  \\\\ \\hline',NCOCMC_path(1),max(NCOCMC_path))             ;
fclose('all')   

% Survey on Loans
% Build Auxiliary Table Here.
% By Risk
% By Maturity
% By Variable
loanseries={};
vars={'EV','EA','ED','EE'}                              ;
maturity={'A','S','M'}                                  ;
risks={'','N','L','M','O'}                              ;
AuxTab=zeros(numel(vars)*numel(maturity)*numel(risks),1);
tt=0                                                    ;
for vv=1:numel(vars)                                    ;
    for mm=1:numel(maturity)                            ;
        for rr=1:numel(risks); 
            tt=tt+1             ;
            var=vars{vv}        ;
            R  =risks{rr}       ;
            M  =maturity{mm}    ;
            if tt<=(3*numel(maturity)*numel(risks))
                eval(['AuxTab(' num2str(tt)...
                    ')= [1-min(Dataset.' [var M R] 'NQ(Beg_date:end))./Dataset.' [var M R] 'NQ(Beg_date)];']);
            else
                eval(['AuxTab(' num2str(tt)...
                    ')= [max(Dataset.' [var M R] 'NQ(Beg_date:end)-rFEDFUNDS(Beg_date:end))+rFEDFUNDS(Beg_date)-Dataset.' [var M R] 'NQ(Beg_date)];']);                
            end
        end
    end
end


% Build up table
filename=['Lending_FinCris.txt']                                                                            ;
fid = fopen(filename,'wt')                                                                                  ;
fprintf(fid,'\n \\begin{tabular}{|l|c|c|c|} \\hline ')                                                        ;
fprintf(fid,'\n \\cellcolor{blue!10} \\textbf{Maturity } & \\cellcolor{blue!10} \\textbf{Short } & \\cellcolor{blue!10} \\textbf{Long }&\\cellcolor{blue!10} \\textbf{All} \\\\ \\hline ');
fprintf(fid,'\n \\cellcolor{blue!5}  Loan Volume         &  \\cellcolor{blue!5}                  & \\cellcolor{blue!5}                 & \\cellcolor{blue!5} \\\\ \\hline')               ;
fprintf(fid,'\n All  Risks& %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(1),AuxTab(6),AuxTab(11))               ;
fprintf(fid,'\n Minimal Risk & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(2),AuxTab(7),AuxTab(12))               ;
fprintf(fid,'\n Low Risk     & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(3),AuxTab(8),AuxTab(13))               ;
fprintf(fid,'\n Medium Risk  & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(4),AuxTab(9),AuxTab(14))               ; 
fprintf(fid,'\n High Risk    & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(5),AuxTab(10),AuxTab(15))              ;
fprintf(fid,'\n \\cellcolor{blue!5}  Average Loan Size   &  \\cellcolor{blue!5}                  & \\cellcolor{blue!5}                 & \\cellcolor{blue!5} \\\\ \\hline')               ;
fprintf(fid,'\n All  Risks   & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(16),AuxTab(21),AuxTab(26))               ;
fprintf(fid,'\n Minimal Risk & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(17),AuxTab(22),AuxTab(27))               ;
fprintf(fid,'\n Low Risk     & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(18),AuxTab(23),AuxTab(28))               ;
fprintf(fid,'\n Medium Risk  & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(19),AuxTab(24),AuxTab(29))               ; 
fprintf(fid,'\n High Risk    & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(20),AuxTab(25),AuxTab(30))               ;
fprintf(fid,'\n \\cellcolor{blue!5}  Interest Rate      &  \\cellcolor{blue!5}                  & \\cellcolor{blue!5}                  & \\cellcolor{blue!5} \\\\ \\hline')               ;
fprintf(fid,'\n All  Risks   & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(46),AuxTab(51),AuxTab(56))               ;
fprintf(fid,'\n Minimal Risk & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(47),AuxTab(52),AuxTab(57))               ;
fprintf(fid,'\n Low Risk     & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(48),AuxTab(53),AuxTab(58))               ;
fprintf(fid,'\n Medium Risk  & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(49),AuxTab(54),AuxTab(59))               ; 
fprintf(fid,'\n High Risk    & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(50),AuxTab(55),AuxTab(60))               ;
fprintf(fid,'\n \\cellcolor{blue!5}  Average Maturity   &  \\cellcolor{blue!5}                  & \\cellcolor{blue!5}                  & \\cellcolor{blue!5} \\\\ \\hline')               ;
fprintf(fid,'\n All  Risks   & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(31),AuxTab(36),AuxTab(41))               ;
fprintf(fid,'\n Minimal Risk & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(32),AuxTab(37),AuxTab(42))               ;
fprintf(fid,'\n Low Risk     & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(33),AuxTab(38),AuxTab(43))               ;
fprintf(fid,'\n Medium Risk  & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(34),AuxTab(39),AuxTab(44))               ; 
fprintf(fid,'\n High Risk    & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(35),AuxTab(40),AuxTab(45))               ;
fclose('all') 


% Interest Rate Table
filename=['Paper_Spreads.txt']                                                                            ;
fid = fopen(filename,'wt')                                                                                  ;
fprintf(fid,'\n \\begin{tabular}{|l|c|} \\hline ')                                                        ;
fprintf(fid,'\n \\cellcolor{blue!10} Corporate Bond by Risk Type & \\cellcolor{blue!10} \\textbf{2006Q4} & \\cellcolor{blue!10} \\textbf{Crisis Peak} \\\\ \\hline ');
fprintf(fid,'\n BoAML AAA    & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',BOA_AAA(Beg_date-4),max(BOA_AAA(Beg_date:end)))             ;
fprintf(fid,'\n BoAML AA     & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',BOA_AA(Beg_date-4),max(BOA_AA(Beg_date:end)))               ;
fprintf(fid,'\n BoAML A      & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',BOA_A(Beg_date-4),max(BOA_A(Beg_date:end)))                 ;
fprintf(fid,'\n BoAML BBB    & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',BOA_BBB(Beg_date-4),max(BOA_BBB(Beg_date:end)))             ; 
fprintf(fid,'\n BoAML BB     & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',BOA_BB(Beg_date-4),max(BOA_BB(Beg_date:end)))               ; 
fprintf(fid,'\n BoAML B      & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',BOA_B(Beg_date-4),max(BOA_B(Beg_date:end)))                 ; 
fprintf(fid,'\n BoAML C      & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',BOA_C(Beg_date-4),max(BOA_C(Beg_date:end)))                 ; 
fprintf(fid,'\n Moody''s AAA & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',MOO_AAA(Beg_date-4),max(MOO_AAA(Beg_date:end)))             ;
fprintf(fid,'\n Moody''s BAA & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',MOO_BAA(Beg_date-4),max(MOO_BAA(Beg_date:end)))             ;
fprintf(fid,'\n \\cellcolor{blue!5} Commercial Paper by Maturity  & \\cellcolor{blue!10} \\textbf{2006Q4} & \\cellcolor{blue!10} \\textbf{Crisis Peak} \\\\ \\hline ');
fprintf(fid,'\n Financial 1M & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',CPF1M(Beg_date-4),max(CPF1M(Beg_date:end)))               ;
fprintf(fid,'\n Financial 2M & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',CPF2M(Beg_date-4),max(CPF2M(Beg_date:end)))               ;
fprintf(fid,'\n Financial 3M & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',CPF3M(Beg_date-4),max(CPF3M(Beg_date:end)))               ;
fprintf(fid,'\n Non-Financial 1M & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',CPN1M(Beg_date-4),max(CPN1M(Beg_date:end)))               ; 
fprintf(fid,'\n Non-Financial 2M & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',CPN2M(Beg_date-4),max(CPN2M(Beg_date:end)))               ;
fprintf(fid,'\n Non-Financial 3M & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',CPN3M(Beg_date-4),max(CPN3M(Beg_date:end)))               ;
fclose('all') 

%% Key Graphs of Effects of Volumes of Intermediation.
% Standard Regression ->
figure;
subplot(2,2,1);
rGDP=rGDP*100;
rBUSLOANS=rBUSLOANS*100;
[B,BINT,R,RINT,STATS]=regress(rGDP(2:end),[1+0*rBUSLOANS(1:end-1) rBUSLOANS(1:end-1)]);
% Take out 2% outliers ->
x = prctile(rGDP,2);
growth_aux=rGDP(rGDP>x&rGDP~=rGDP(1));
interm_aux=rBUSLOANS(rGDP>x&rBUSLOANS~=rBUSLOANS(end)&rBUSLOANS~=rBUSLOANS(end-1));
[B_aux]=regress(growth_aux,[1+0*interm_aux(1:length(growth_aux)) interm_aux(1:length(growth_aux))]);
plot(sort(rBUSLOANS(1:end-1)),[1+0*rBUSLOANS(1:end-1) sort(rBUSLOANS(1:end-1))]*B,'LineWidth',3,'Color','r'); hold on;
plot(sort(interm_aux),[1+0*interm_aux sort(interm_aux)]*B_aux,'LineWidth',3,'Color',[0.8 0.3 0.2],'LineStyle','--');
scatter(rBUSLOANS(1:end-1),rGDP(2:end),60,[0.2 0.2 0.8],'d','filled'); hold off;
axis tight; grid on;
xlabel('Business Loans Growth');
ylabel('Ouput Growth');
% use when bad regression
% ylimits=ylim;
% xlimits=xlim;

% Regression Coefficient
subplot(2,2,2);
LOANS= log(exp(BUSLOANS)+exp(REALLN))             ;
rLOANS= [ 4*mean(diff(LOANS(1:5))); 4*diff(LOANS)];
[B,BINT,R,RINT,STATS]=regress(rGDP(2:end),[1+0*rLOANS(1:end-1) rLOANS(1:end-1)]);
% Take out 2% outliers ->
x = prctile(rGDP,2);
growth_aux=rGDP(rGDP>x&rGDP~=rGDP(1));
interm_aux=rLOANS(rGDP>x&rLOANS~=rLOANS(end)&rLOANS~=rLOANS(end-1));
plot(sort(rLOANS(1:end-1)),[1+0*rLOANS(1:end-1) sort(rLOANS(1:end-1))]*B,'LineWidth',3,'Color','r'); hold on;
plot(sort(interm_aux),[1+0*interm_aux sort(interm_aux)]*B_aux,'LineWidth',3,'Color',[0.8 0.3 0.2],'LineStyle','--');
scatter(rLOANS(1:end-1),rGDP(2:end),60,[0.2 0.2 0.8],'d','filled'); hold off;
axis tight; grid on;
xlabel('Business + Real Estate Loans Growth');
ylabel('Ouput Growth');

% Business Loans Including Non-Financial Commercial Paper
subplot(2,2,3)                                          ;
LOANS= log(exp(BUSLOANS)+exp(REALLN)+Dataset.COMPAPER);
rLOANS= [ 4*mean(diff(LOANS(1:5))); 4*diff(LOANS)]      ;
index=  isfinite(rLOANS);
auxrGDP=rGDP(index);
auxrLOANS=rLOANS(index);
[B,BINT,R,RINT,STATS]=regress(auxrGDP(2:end),[1+0*auxrLOANS(1:end-1) auxrLOANS(1:end-1)]);
% Take out 2% outliers ->
x = prctile(rGDP,2);
plot(sort(auxrLOANS(1:end-1)),[1+0*auxrLOANS(1:end-1) sort(auxrLOANS(1:end-1))]*B,'LineWidth',3,'Color','r'); hold on;
scatter(rLOANS(1:end-1),rGDP(2:end),60,[0.2 0.2 0.8],'d','filled'); hold off;
axis tight; grid on;
xlabel('Business + Real Estate Loans Growth');
ylabel('Ouput Growth');

% Regression Coefficient
subplot(2,2,4);
LOANS= log(exp(BUSLOANS)+exp(REALLN)+Dataset.COMPAPER+Dataset.ABCOMP)             ;
rLOANS= [ 4*mean(diff(LOANS(1:5))); 4*diff(LOANS)];
index=  isfinite(rLOANS);
auxrGDP=rGDP(index);
auxrLOANS=rLOANS(index);
[B,BINT,R,RINT,STATS]=regress(auxrGDP(2:end),[1+0*auxrLOANS(1:end-1) auxrLOANS(1:end-1)]);
% Take out 2% outliers ->
x = prctile(rGDP,2);
plot(sort(auxrLOANS(1:end-1)),[1+0*auxrLOANS(1:end-1) sort(auxrLOANS(1:end-1))]*B,'LineWidth',3,'Color','r'); hold on;
scatter(rLOANS(1:end-1),rGDP(2:end),60,[0.2 0.2 0.8],'d','filled'); hold off;
axis tight; grid on;
xlabel('Business + Real Estate Loans Growth');
ylabel('Ouput Growth');

% Add in a title
suptitle('Financial Intermediation and Output Growth');

%% Key Graphs of Effects of Volumes of Intermediation.
% Standard Regression ->
figure;
subplot(2,2,1);
[B,BINT,R,RINT,STATS]=regress(rROA(2:end),[1+0*rBUSLOANS(1:end-1) rBUSLOANS(1:end-1) rBUSLOANS(1:end-1).^2]);
% Take out 2% outliers ->
plot(sort(rBUSLOANS(1:end-1)),[1+0*rBUSLOANS(1:end-1) sort(rBUSLOANS(1:end-1)) sort(rBUSLOANS(1:end-1)).^2]*B,'LineWidth',3,'Color','r'); hold on;
scatter(rBUSLOANS(1:end-1),rROA(2:end),60,[0.2 0.2 0.8],'d','filled'); hold off;
axis tight; grid on;
xlabel('Business Loans Growth');
ylabel('Return on Bank Assets');

% Regression Coefficient
subplot(2,2,2);
LOANS= log(exp(BUSLOANS)+exp(REALLN))             ;
rLOANS= [ 4*mean(diff(LOANS(1:5))); 4*diff(LOANS)]*100;
[B,BINT,R,RINT,STATS]=regress(rROA(2:end),[1+0*rLOANS(1:end-1) rLOANS(1:end-1) rLOANS(1:end-1).^2]);
plot(sort(rLOANS(1:end-1)),[1+0*rLOANS(1:end-1) sort(rLOANS(1:end-1)) sort(rLOANS(1:end-1)).^2]*B,'LineWidth',3,'Color','r'); hold on;
scatter(rLOANS(1:end-1),rROA(2:end),60,[0.2 0.2 0.8],'d','filled'); hold off;
axis tight; grid on;
xlabel('Business + Real Estate Loans Growth');
ylabel('Ouput Growth');

% Including Commercial Paper
subplot(2,2,3);
LOANS= log(exp(BUSLOANS)+exp(REALLN)+Dataset.COMPAPER);
rLOANS= [ 4*mean(diff(LOANS(1:5))); 4*diff(LOANS)]*100;
auxrROA=rROA(index);
auxrLOANS=rLOANS(index);
[B,BINT,R,RINT,STATS]=regress(auxrROA(2:end),[1+0*auxrLOANS(1:end-1) auxrLOANS(1:end-1) auxrLOANS(1:end-1).^2]);
plot(sort(auxrLOANS(1:end-1)),[1+0*auxrLOANS(1:end-1) sort(auxrLOANS(1:end-1)) sort(auxrLOANS(1:end-1)).^2]*B,'LineWidth',3,'Color','r'); hold on;
scatter(rLOANS(1:end-1),rROA(2:end),60,[0.2 0.2 0.8],'d','filled'); hold off;
axis tight; grid on;
xlabel('Business + Real Estate Loans Growth');
ylabel('Ouput Growth');

% Including ABS Commercial Paper
subplot(2,2,4);
LOANS= log(exp(BUSLOANS)+exp(REALLN)+Dataset.COMPAPER+Dataset.ABCOMP)             ;
rLOANS= [ 4*mean(diff(LOANS(1:5))); 4*diff(LOANS)]*100;
auxrROA=rROA(index);
auxrLOANS=rLOANS(index);
[B,BINT,R,RINT,STATS]=regress(auxrROA(2:end),[1+0*auxrLOANS(1:end-1) auxrLOANS(1:end-1) auxrLOANS(1:end-1).^2]);
plot(sort(auxrLOANS(1:end-1)),[1+0*auxrLOANS(1:end-1) sort(auxrLOANS(1:end-1)) sort(auxrLOANS(1:end-1)).^2]*B,'LineWidth',3,'Color','r'); hold on;
scatter(rLOANS(1:end-1),rROA(2:end),60,[0.2 0.2 0.8],'d','filled'); hold off;
axis tight; grid on;
xlabel('Business + Real Estate Loans Growth');
ylabel('Ouput Growth');

% Add in a title
suptitle('Financial Intermediation and Bank ROA');

%% Return to Equity and Volume
figure;
rROE=rROE*100;
subplot(2,2,1);
[B,BINT,R,RINT,STATS]=regress(rBUSLOANS(2:end),[1+0*rROE(1:end-1) rROE(1:end-1)]);
plot(sort(rROE(1:end-1)),[1+0*rROE(1:end-1) sort(rROE(1:end-1))]*B,'LineWidth',3,'Color','r'); hold on;
scatter(rROE(1:end-1),rBUSLOANS(2:end),60,[0.2 0.2 0.8],'d','filled'); hold off;
axis tight; grid on;
xlabel('ROE');
ylabel('Business Loans Growth');
% use when bad regression
% ylimits=ylim;
% xlimits=xlim;

% Regression Coefficient
subplot(2,2,2);
LOANS= log(exp(BUSLOANS)+exp(REALLN))             ;
rLOANS= [ 4*mean(diff(LOANS(1:5))); 4*diff(LOANS)];
[B,BINT,R,RINT,STATS]=regress(rLOANS(2:end),[1+0*rROE(1:end-1) rROE(1:end-1)]);
plot(sort(rROE(1:end-1)),[1+0*rROE(1:end-1) sort(rROE(1:end-1))]*B,'LineWidth',3,'Color','r'); hold on;
scatter(rROE(1:end-1),rLOANS(2:end),60,[0.2 0.2 0.8],'d','filled'); hold off;
axis tight; grid on;
xlabel('Business + Real Estate Loans Growth');
ylabel('Ouput Growth');

% Business Loans Including Non-Financial Commercial Paper
subplot(2,2,3)                                          ;
LOANS= log(exp(BUSLOANS)+exp(REALLN)+Dataset.COMPAPER);
rLOANS= [ 4*mean(diff(LOANS(1:5))); 4*diff(LOANS)]      ;
index=  isfinite(rLOANS);
auxrGDP=rGDP(index);
auxrLOANS=rLOANS(index);
[B,BINT,R,RINT,STATS]=regress(auxrGDP(2:end),[1+0*auxrLOANS(1:end-1) auxrLOANS(1:end-1)]);
% Take out 2% outliers ->
x = prctile(rGDP,2);
plot(sort(auxrLOANS(1:end-1)),[1+0*auxrLOANS(1:end-1) sort(auxrLOANS(1:end-1))]*B,'LineWidth',3,'Color','r'); hold on;
scatter(rLOANS(1:end-1),rGDP(2:end),60,[0.2 0.2 0.8],'d','filled'); hold off;
axis tight; grid on;
xlabel('Business + Real Estate Loans Growth');
ylabel('Ouput Growth');

% Regression Coefficient
subplot(2,2,4);
LOANS= log(exp(BUSLOANS)+exp(REALLN)+Dataset.COMPAPER+Dataset.ABCOMP)             ;
rLOANS= [ 4*mean(diff(LOANS(1:5))); 4*diff(LOANS)];
index=  isfinite(rLOANS);
auxrGDP=rGDP(index);
auxrLOANS=rLOANS(index);
[B,BINT,R,RINT,STATS]=regress(auxrGDP(2:end),[1+0*auxrLOANS(1:end-1) auxrLOANS(1:end-1)]);
% Take out 2% outliers ->
x = prctile(rGDP,2);
plot(sort(auxrLOANS(1:end-1)),[1+0*auxrLOANS(1:end-1) sort(auxrLOANS(1:end-1))]*B,'LineWidth',3,'Color','r'); hold on;
scatter(rLOANS(1:end-1),rGDP(2:end),60,[0.2 0.2 0.8],'d','filled'); hold off;
axis tight; grid on;
xlabel('Business + Real Estate Loans Growth');
ylabel('Ouput Growth');
