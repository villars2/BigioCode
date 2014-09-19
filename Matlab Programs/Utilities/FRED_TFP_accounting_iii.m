%% FRED_TFP_accounting_ii
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% This code downloads some basic components of GDP and performs classical
% accounting exercises
%
% Pending Correlations, Latex, In Matlab Display and TXT
% FRED Series     Description
% -----------     ----------------------------------------------------------------
% CORE QUANTITIES AND PRICES 
% -----------     ----------------------------------------------------------------
% GDP             Gross domestic product in $ billions (NIPA)
% GPDI            Gross Private Domestic Investment (NIPA)
% PNFI            Gross Private NonResidential Fixed Investment (NIPA)
% PRFI            Gross Private Residential Fixed Investment (NIPA)
% COFC            Consumption of Fixed Capital (NIPA)
% GDINOS          Gross Domestic Income: Net Operating Surplus ()
% PCE             Personal Consumption Expenditures
% PCND            Personal Consumption Expenditures: Non-Durable Goods
% PCEDG           Personal Consumption Expenditures: Durable Goods
% GCE             Goverment Consumption and Investment Expenditures
% USAGFCFQDSMEI   Gross Capital Formation in the United States (OECD) Billions of United States Dollars
% GDPDEF          Gross Domestic Product: Implicit Price Deflator (NIPA)
% PPICPE          Producer Price of Equipment
% NETEXP          Net Exports of Goods & Services
% BOPXGS          Total Exports of Goods and Services
% -----------     ----------------------------------------------------------------
% CORE REAL QUANTITIES 
% -----------     ----------------------------------------------------------------       
% GDPC96          Real Gross Domestic Product, 3 Decimal (GDPC96)
% GPDIC96         Real Gross Private Domestic Investment
% PNFIC96         Real Private Nonresidential Fixed Investment 
% PRFIC96         Real Private residential Fixed Investment 
% A262RX1A020NBEA Real Consumption of Fixed Capital (NIPA)
% PCECC96         Real Personal Consumption Expenditures 
% GCEC96          Real Goverment Consumption Expenditures  
% PCDGCC96        Real Personal Consumption Expenditures: Durable Goods 
% PCNDGC96        Real Personal Consumption Expenditures: NonDurable Goods 
% GDPPOT          Real Potential Gross Domestic Product
% EXPGSCA         Real Exports of Goods & Services 
% EXPGSC96        Real Net Exports of Goods & Services 
% -----------     ----------------------------------------------------------------
% WAGES, HOURS AND UTILIZATION WORKED
% -----------     ----------------------------------------------------------------
% OPHNFB          Nonfarm Business Sector: Output Per Hour of All Persons 
% ULCNFB          Nonfarm Business Sector: Unit Labor Cost
% RCPHBS          Nonfarm Business Sector: Real Compensation Per Hour (COMPRNFB)
% UNRATE          Civilian Unemployment Rate (BLS)
% TCU             Capacity Utilization: Total Industry 
% COE             Paid compensation of employees in $ billions
% HOANBS          Nonfarm Business Sector: Hours of All Persons
% COMPRNFB        Nonfarm Business Sector: Real Compensation Per Hour ()
% -----------     ----------------------------------------------------------------
% FLOW OF FUNDS - PHYSICAL CAPITAL
% -----------     ----------------------------------------------------------------
% ESABSNNB        Nonfinancial Noncorporate Business; Equipment and Software, Current Cost Basis, Level ()
% ESABSNNCB       Nonfinancial Corporate Business; Equipment and Software, Current Cost Basis, Level ()
% -------------------- REAL ESTATE STRUCTURES
% RCVSRNWBSNNB    Nonfinancial Noncorporate Business; Residential Structures, Current Cost Basis, Level ()
% RCVSNWBSNNB     Nonfinancial Noncorporate Business; Nonresidential Structures, Current Cost Basis, Level ()
% RCSNNWMVBSNNCB  Nonfinancial Corporate Business; Nonresidential Structures, Current Cost Basis, Level ()
% RCVSRNWMVBSNNCB Nonfinancial Corporate Business; Residential Structures, Current Cost Basis, Level ()
% RCVSRNWBSHNO    Households and Nonprofit Organizations; Residential Structures, Current Cost Basis, Level ()
% -----------     ----------------------------------------------------------------
% BEA - NIPA INVESTMENT SUB-ACCOUNTS (following John Fernald) (Billions of Dollars)
% -----------     ----------------------------------------------------------------
% A679RC1Q027SBEA Private fixed investment in information processing equipment and software (Dep 13.0% annual)
% A771RC1Q027SBEA Private fixed investment in new structures: Nonresidential structures (Dep 2.6% annual)
% A756RC1Q027SBEA Private fixed investment in new structures: Residential structures ()
% B009RX1Q020SBEA Real gross private domestic investment: Fixed investment: Nonresidential: Structures (B009RX1Q020SBEA)
% A679RX1Q020SBEA Real gross private domestic investment: Fixed investment: Nonresidential: Information processing equipment and software ()
% W260RC1A027NBEA Gross domestic income: Net operating surplus: Private enterprises, Billions of Dollars ()
% A045RC1Q027SBEA Proprietors' income with inventory valuation and capital consumption adjustments: Nonfarm ()
% ----------------- Sub Accounts    ----------------------------------------------
  % |  B010RC1Q027SBEA Private fixed investment: Nonresidential: Equipment and software ()
  % |  A680RC1Q027SBEA Private fixed investment: Nonresidential: Equipment: Industrial equipment ()
  % |  A681RC1Q027SBEA Private fixed investment: Nonresidential: Equipment: Transportation equipment ()
  % |  B935RC1Q027SBEA Private fixed investment: Nonresidential: Information processing equipment and software: Computers and peripheral equipment ()  
  % |  B862RG3Q027SBEA Private fixed investment, chained price index: Nonresidential: Equipment: Other equipment ()
  % |  A937RZ2A224NBEA Contributions to percent change in real private fixed investment: Nonresidential: Equipment: Information processing equipment: Other ()
  % |  E318RC1Q027SBEA Private fixed investment: Nonresidential: Structures: Mining exploration, shafts, and wells ()
  % |  C307RC1Q027SBEA Private fixed investment: Nonresidential: Structures: Manufacturing ()
  % |  B985RC1Q027SBEA Private fixed investment: Nonresidential: Intellectual property products: Software ()
% -----------     ----------------------------------------------------------------
% MANUFACTURING - INVENTORY
% -----------     ----------------------------------------------------------------
% ---- ORDERS ----
% AMTMNO	 Value of Manufacturers' New Orders for All Manufacturing Industries	 Current	 Mil. of $	 M	 SA	 2013-08-02
% DGORDER    Manufacturers' New Orders: Durable Goods		 Current	 Mil. of $	 M	 SA	 2013-08-26
% NEWORDER   Manufacturers' New Orders: Nondefense Capital Goods Excluding Aircraft	 Current	 Mil. of $	 M	 SA	 2013-08-26
% ---- INVENTORIES ----
% AMTMTI	 Value of Manufacturers' Total Inventories for All Manufacturing Industries	 Current	 Mil. of $	 M	 SA	 2013-08-02
% AMDMTI	 Value of Manufacturers' Total Inventories for Durable Goods Industries	 Current	 Mil. of $	 M	 SA	 2013-08-26
% ANXATI     Value of Manufacturers' Total Inventories for Capital Goods: Nondefense Capital Goods Excluding Aircraft Industries (ANXATI)
% ---- SHIPMENTS ----
% AMTMVS	 Value of Manufacturers' Shipments for All Manufacturing Industries	 Current	 Mil. of $	 M	 SA	 2013-08-02
% AMDMVS	 Value of Manufacturers' Shipments for Durable Goods Industries	 Current	 Mil. of $	 M	 SA	 2013-08-26
% ANDEVS	 Value of Manufacturers' Shipments for Capital Goods: Nondefense Capital Goods Industries	 Current	 Mil. of $	 M	 SA	 2013-08-26
% ---- UNFILLED ORDERS ----
% AMTMUO     Value of Manufacturers' Unfilled Orders for All Manufacturing Industries
% AMDMUO	 Value of Manufacturers' Unfilled Orders for Durable Goods Industries	 Current	 Mil. of $	 M	 SA	 2013-08-26
% ANXAUO	 Value of Manufacturers' Unfilled Orders for Capital Goods: Nondefense Capital Goods Excluding Aircraft Industries	 Current	 Mil. of $	 M	 SA	 2013-08-26
% ---- RATOPS  ----
% AMTMIS	 Ratio of Manufacturers' Total Inventories to Shipments for All Manufacturing Industries	 Current	 Ratio	 M	 SA	 2013-08-02
% AMDMIS	 Ratio of Manufacturers' Total Inventories to Shipments for Durable Goods Industries	 Current	 Ratio	 M	 SA	 2013-08-02
% ANXAIS (Not Available)	 Ratio of Manufacturers' Total Inventories to Shipments for All Manufacturing Industries
% -----------  PENN WORLD TABLES   ----------------------------------------------------------------
% RTFPNAUSA632NRUG Total Factor Productivity at Constant National Prices for United States ()
% Feenstra, Robert C., Robert Inklaar and Marcel P. Timmer (2013), "The Next Generation of the Penn World Table" available 
% -----------     ----------------------------------------------------------------


%% Compute Program Preferences
% clear;
% close all;
begin_date='1-Apr-1952'; % Initial Date for Data
margin=150;              % Margin Date-Numeric for plots

% Code Preferences
lambda_hp=1600           ; % Hodrick and Prescott Filter 1600 recommended by Harald Uhilig and Morten Ravn

% Plot Preferences
margin=150               ; % Margin Date-Numeric for plots

% Color Specifications
BDP_plotspecs; % Code that chooses colors for plots

%% Begin Download
% For 96 price series, 
% RGDP_series ={'GDPC96','GPDIC96','PCNDGC96','PCDGCC96','PNFIC96','PRFIC96','A262RX1A020NBEA','PCECC96','GCEC96','GDPPOT','NETEXC96','EXPGSC96'};Using
NGDP_series = {'GDP','GPDI','PNFI','PRFI','COFC','GDINOS','PCEC','PCND','PCEDG','GCE','USAGFCFQDSMEI','NETEXP','BOPXGS','TTLCONS','PCESV'};
RGDP_series = {'GDPC1','GPDIC1','PCNDGC96','PCDGCC96','PNFIC1','PRFIC1','A262RX1A020NBEA','PCECC96','GCEC1','GDPPOT','NETEXC','EXPGSC1','PPICPE','IPMAN','GDPDEF'};
inv_series = {'AMTMNO','DGORDER','NEWORDER','AMTMTI','AMDMTI','ANXATI','AMTMVS','AMDMVS','ANDEVS','AMTMUO','AMDMUO','ANXAUO'};	
FoFSeries   = {'ESABSNNB','ESABSNNCB','RCVSNWBSNNB','RCSNNWMVBSNNCB','RCVSRNWBSNNB','RCVSRNWBSHNO','RCVSRNWMVBSNNCB','RTFPNAUSA632NRUG'};
cap_series = {'OPHNFB','ULCNFB','COMPRNFB','HOANBS','UNRATE','COE','W260RC1A027NBEA','A045RC1Q027SBEA','TCU'};
bea_series = {'A679RC1Q027SBEA','A771RC1Q027SBEA','A756RC1Q027SBEA','B009RX1Q020SBEA','A679RX1Q020SBEA'}; 

% Collect Series
series = [NGDP_series RGDP_series FoFSeries inv_series cap_series bea_series];

% Download list in series
FRED_downloads;

%% Upload John Fernald's TFP Data
% Include Data from John Fernald
newData = importdata('FernaldTFP_raw.csv');
% Create new variables in the base workspace from those fields.
vars = fieldnames(newData);
for i = 1:length(vars)
    assignin('base', vars{i}, newData.(vars{i}));
end

clear i vars newData;

% Obtains Matrix with dates, series code and description
names_code=textdata(1,2:end)   ; 
dates=textdata(2:end,1)        ;
dates=char(dates)              ;
clear textdata                 ;

% Transforms Dates 
yy=char(cellstr(dates))        ;
qq=str2num(yy(:,end))       ;
yy=str2num(yy(:,1:4))       ;
mm=qq*3                        ;
dates=lbusdate(yy, mm)         ;	
v=numel(names_code)            ;
for i=1:v; % To avoid conflict, will jump ahead to detail
        tag=cellstr(names_code(i))                  ;
        series=[series, tag]                        ;
        % Generate Series Name from Table
        fts = fints(dates, (data(:,i)), tag)         ;

        % Add every possible variable
        Universe = merge(fts, Universe)             ;
end
Universe.desc = 'Flow of Funds Data'        ;
Universe.freq = 'quarterly'                 ;

% Trim date range to period from 'begin_date' to present
StartDate = datenum(begin_date);
EndDate = datenum(Universe.dates(end));

% Convert combined time series into date and data arrays		
dates = Universe.dates;
Data = fts2mat(Universe.(series));
Dataset = dataset([{Data},series],'ObsNames',cellstr(datestr(dates,'QQ-YY')));
Fernald_List=names_code;
clear names_code;

%% Call - Recession Indicators to Setup Dates
Space=14;
FRED_RecessionIndicators;
T = length(Dataset);

% Truncate Dates
var_dates='GDP'; % Variable dates used for truncation
%eval(['t_init= min((1-isnan(Dataset.' char(var_dates) ')).*(1:T)'') ']);
eval(['t_end = max((1-isnan(Dataset.' char(var_dates) ')).*(1:T)'');']);
eval(['t_beg =81']);
index_s=1:T;
index_t=(1:t_end);
dates_t=dates(index_t);

%% Display that all variable finished downloading
clc;
disp('*******************************************************************');
disp('************* All Variables Finished Downloading ******************');
disp('*******************************************************************');

%% Redifining Series Names 
% Nominal Series for GDP Components by Expenditure Side 
GDP   = Dataset.GDP                   ; % Rename Nominal GDP series
INV  = Dataset.GPDI                   ; % Gross Private Domestic Investment (NIPA)
PNRI  = Dataset.PNFI                  ; % Gross Private NonResidential Fixed Investment (NIPA)
PRI  = Dataset.PRFI                   ; % Gross Private Residential Fixed Investment (NIPA)
COFC  = Dataset.COFC                  ; % Consumption of Fixed Capital (NIPA)
GDINOS = Dataset.GDINOS               ; % Gross Domestic Income: Net Operating Surplus
CONS   = Dataset.PCEC                 ; % Personal Consumption Expenditures
NONDURCO= Dataset.PCND                ; % Personal Consumption Expenditures: Non-Durable Goods
DURCO   = Dataset.PCEDG               ; % Personal Consumption Expenditures: Durable Goods
GOV   = Dataset.GCE                   ; % Goverment Consumption and Investment Expenditures
NX    = Dataset.NETEXP                ; % Net Exports of Goods & Services
EXP   = Dataset.BOPXGS                ; % Total Exports of Goods and Services
IPMAN = Dataset.IPMAN                 ; % Industrial Production of Manufactured Goods
TTLCONS = Dataset.TTLCONS             ; % Total Construction
PCESV   = Dataset.PCESV               ; % Expenditures on Services

% Deflator and Components
GDPDEF= Dataset.GDPDEF/100            ; % Rename GDP deflator
PPICPE= Dataset.PPICPE                ; % Producer Price Index

% USAGFCFQDSMEI   Gross Capital Formation in the United States (OECD)

% -----------     ----------------------------------------------------------------
% CORE REAL QUANTITIES - Swith with 96 to 96 constant prices
% -----------     ----------------------------------------------------------------       
RGDP =Dataset.GDPC1              ; % Real Gross Domestic Product, 3 Decimal (GDPC96)
RINV =Dataset.GPDIC1             ; % Real Gross Private Domestic Investment
RPNRI = Dataset.PNFIC1           ; % Real Private Nonresidential Fixed Investment 
RPRI  = Dataset.PRFIC1           ; % Real Private residential Fixed Investment 
RCOFC  = Dataset.A262RX1A020NBEA ; % Real Consumption of Fixed Capital (NIPA)
RCONS  = Dataset.PCECC96         ; % Real Personal Consumption Expenditures 
RNONDURCO= Dataset.PCNDGC96      ; % Real Personal Consumption Expenditures: Nondurable Goods 
RDURCO   = Dataset.PCDGCC96      ; % Real Personal Consumption Expenditures: Durable Goods 
RGOV     = Dataset.GCEC1         ; % Real Goverment Consumption Expenditures  
RNX      = Dataset.NETEXC        ; % Real Exports of Goods & Services 
REXP     = Dataset.EXPGSC1       ; % Real Net Exports of Goods & Services       
GDP_pot  = Dataset.GDPPOT        ; % Real Potential Gross Domestic Product


% Hours, Unemployment, Utilization
OPH   = Dataset.OPHNFB  ; % Nonfarm Business Sector: Output Per Hour of All Persons (index)
ULC   = Dataset.ULCNFB  ; % Nonfarm Business Sector: Unit Labor Cost
RCPH  = Dataset.COMPRNFB; % Nonfarm Business Sector: Real Compensation Per Hour 
HOURS = Dataset.HOANBS  ; % Total Non-Farm Hours
UNRATE= Dataset.UNRATE  ; % Civilian Unemployment Rate (BLS)
COE   = Dataset.COE     ; % Paid compensation of employees in $ billions
UTIL  = Dataset.TCU     ; % Capacity Utilization: Total Industry 
OPSURP = Dataset.W260RC1A027NBEA;
PROPINC= Dataset.A045RC1Q027SBEA;


% Labor Productivity
Y_L=RGDP./HOURS;

% Productivity Measures
TFPPWT = Dataset.RTFPNAUSA632NRUG     ; % TFP Penn World Tables
GROSSCAPFOR = Dataset.USAGFCFQDSMEI   ; % Gross Capital Formation in the United States (OECD)

% -----------     ----------------------------------------------------------------
% MANUFACTURING - INVENTORY
% -----------     ----------------------------------------------------------------
% ---- ORDERS ----
AORD= Dataset.AMTMNO   ; % Value of Manufacturers' New Orders for All Manufacturing Industries	 Current	 Mil. of $	 M	 SA	 2013-08-02
DORD= Dataset.DGORDER  ; % Manufacturers' New Orders: Durable Goods		 Current	 Mil. of $	 M	 SA	 2013-08-26
CORD= Dataset.NEWORDER ; % Manufacturers' New Orders: Nondefense Capital Goods Excluding Aircraft	 Current	 Mil. of $	 M	 SA	 2013-08-26
% ---- INVENTORIES ----
AINV	= Dataset.AMTMTI ; % Value of Manufacturers' Total Inventories for All Manufacturing Industries	 Current	 Mil. of $	 M	 SA	 2013-08-02
DINV	= Dataset.AMDMTI ; % Value of Manufacturers' Total Inventories for Durable Goods Industries	 Current	 Mil. of $	 M	 SA	 2013-08-26
CINV    = Dataset.ANXATI ; % Value of Manufacturers' Total Inventories for Capital Goods: Nondefense Capital Goods Excluding Aircraft Industries (ANXATI)
% ---- SHIPMENTS ----
ASHI	= Dataset.AMTMVS ; % Value of Manufacturers' Shipments for All Manufacturing Industries	 Current	 Mil. of $	 M	 SA	 2013-08-02
DSHI	= Dataset.AMDMTI ; % Value of Manufacturers' Shipments for Durable Goods Industries	 Current	 Mil. of $	 M	 SA	 2013-08-26
CSHI	= Dataset.ANXATI ; % Value of Manufacturers' Shipments for Capital Goods: Nondefense Capital Goods Industries	 Current	 Mil. of $	 M	 SA	 2013-08-26
% ---- UNFILLED ORDERS ----
AUO = Dataset.AMTMUO     ; % Value of Manufacturers' Unfilled Orders for All Manufacturing Industries
DUO = Dataset.AMDMUO	 ; % Value of Manufacturers' Unfilled Orders for Durable Goods Industries	 Current	 Mil. of $	 M	 SA	 2013-08-26
CUO = Dataset.ANXAUO	 ; % Value of Manufacturers' Unfilled Orders for Capital Goods: Nondefense Capital Goods Excluding Aircraft Industries	 Current	 Mil. of $	 M	 SA	 2013-08-26

% Inventory Variable List
inv_list={'AORD','DORD','CORD','AINV','DINV','CINV','ASHI','DSHI','CSHI','AUO','DUO','CUO'};

% Capital Variables from Flow of Funds
ESNB=Dataset.ESABSNNB           ; % Nonfinancial Noncorporate Business; Equipment and Software, Current Cost Basis, Level ()
ESCB=Dataset.ESABSNNCB          ; % Nonfinancial Corporate Business; Equipment and Software, Current Cost Basis, Level ()
NRNB=Dataset.RCVSNWBSNNB        ; % Nonfinancial Noncorporate Business; Nonresidential Structures, Current Cost Basis, Level ()
NRCB=Dataset.RCSNNWMVBSNNCB     ; % Nonfinancial Corporate Business; Nonresidential Structures, Current Cost Basis, Level ()
RSNB=Dataset.RCVSRNWBSNNB       ; % Nonfinancial Noncorporate Business; Residential Structures, Current Cost Basis, Level ()
RSCB=Dataset.RCVSRNWMVBSNNCB    ; % Nonfinancial Corporate Business; Residential Structures, Current Cost Basis, Level ()
RSH=Dataset.RCVSRNWBSHNO        ; % Households and Nonprofit Organizations; Residential Structures, Current Cost Basis, Level ()
cap_list={'ESNB','ESCB','NRNB','NRCB','RSNB','RSCB','RSH'};

% BEA accounts
BEA_ES=Dataset.A679RC1Q027SBEA  ; % Private fixed investment in information processing equipment and software (Dep 13.0% annual)
BEA_NRST=Dataset.A771RC1Q027SBEA; % Private fixed investment in new structures: Nonresidential structures (Dep 2.6% annual)
BEA_REST=Dataset.A756RC1Q027SBEA; % Private fixed investment in new structures: Residential structures
BEA_ST=BEA_REST+BEA_NRST; % All Structures
% BEA_RST=Dataset.B009RX1Q020SBEA % Real gross private domestic investment: Fixed investment: Nonresidential: Structures (B009RX1Q020SBEA)
% BEA_RES=Dataset.A679RX1Q020SBEA % Real gross private domestic investment: Fixed investment: Nonresidential: Information processing equipment and software ()
BEA_RST=BEA_ST./GDPDEF; % Real gross private domestic investment: Fixed investment: Nonresidential: Structures (B009RX1Q020SBEA)
BEA_RES=BEA_ES./GDPDEF; % Real gross private domestic investment: Fixed investment: Nonresidential: Information processing equipment and software ()

% Labor Share Robert Shimer
LabShareShimer=COE./(COE+GDINOS+COFC-PROPINC);

% Reconstructing John Fernald's Data
FernaldName_List={'Yprod_fer','Yinc_fer','Y_fer','HOURS_fer','LP_fer','K_fer','LQ_BLS_fer','LQ_AS','LQ_fer'...
    'alpha_fer','A_fer','UTIL_fer','AU_fer','Q_fer','invshare_fer','tfp_I_fer','tfp_C_fer','u_invest_fer',...
    'u_consumption_fer','tfp_I_util_fer','tfp_C_util_fer'};

for i=1:numel(Fernald_List)
    eval([ FernaldName_List{i} '=(Dataset.' Fernald_List{i} '/400+1);']);
    eval(['index=find(' FernaldName_List{i} '>0,1,''first'');']);
    if index==1
        eval([ FernaldName_List{i} '(index)=1;']);
    else
        eval([ FernaldName_List{i} '(index-1)=1;']);
    end
    eval([FernaldName_List{i} '(' FernaldName_List{i} '>0)=cumprod(' FernaldName_List{i} '(' FernaldName_List{i} '>0));']);
end
alpha_fer=Dataset.alpha;
invshare_fer=Dataset.invShare;
I_fer=invshare_fer.*Y_fer;

%% Transformation and Indices
% Building Imports
M=EXP-NX;
RM=REXP-RNX;

% Transformations and Indices
Q     = GDPDEF./PPICPE                ; % Relative Consumer-to-Producer prices
WAGES   = Dataset.ULCNFB;
% Y_L       = GDPC96./exp(HOURS);

%% Recomputing Variables with longer Horizon by deviding by deflator
R_NONDURCO=NONDURCO./GDPDEF                         ;
R_DURCO=DURCO./GDPDEF                               ;
R_PRI =PRI./GDPDEF                                  ;
R_PNRI=PNRI./GDPDEF                                 ;
% Should be: but longer series unavailable
%RDURINV=RINV+RDURCO             ; % Broad Investment Measure
RDURINV=RINV+R_DURCO;

%% Transforming Nominals to Reals
% This Section Tests the GDP Deflator
% Convert to Real
n2rlist={'COE','TTLCONS','PCESV'};  
n2rlist=[n2rlist inv_list cap_list];

% Nominal2Real
BDP_nom2real;
rinv_list={'RAORD','RDORD','RCORD','RAINV','RDINV','RCINV','RASHI','RDSHI','RCSHI','RAUO','RDUO','RCUO'};

% Constructing Real flows from FoF
RES=RESNB+RESCB; % All software and equipment
RST=RNRNB+RNRCB+RRSNB+RRSCB+RRSH; % All Structures
cap_list={'RES','RST','RESNB','RESCB','RNRNB','RNRCB'};

%% Potencial OUTPUT Measures CBO
% Computing 2009/2005 Dollars
potdate='31-Mar-2004';
mm=month(potdate);
yy=year(potdate);
potdate = lbusdate(yy, mm);
[~,potIndex]   = min(abs(potdate-dates));
refdate='31-Dec-2009';
mm=month(refdate);
yy=year(refdate);
refdate = lbusdate(yy, mm);
[junk,refIndex]   = min(abs(refdate-dates));
potcurr=GDPDEF(refIndex)/GDPDEF(potIndex);

% Computing Implied Potentials
logGDP_pot=log(potcurr*GDP_pot);
logINV_pot=logGDP_pot+log(mean(INV(isfinite(GDP))./GDP(isfinite(GDP)))); % Compute Potential Investment 
logCONS_pot=logGDP_pot+log(mean(CONS(isfinite(GDP))./GDP(isfinite(GDP)))); % Compute Potential Investment 
devpot_RGDP=log(RGDP)-logGDP_pot;
devpot_RINV=log(RINV)-logINV_pot;
devpot_RCONS=log(RCONS)-logCONS_pot;

%% Reconstructing Capital Stocks
% Depreciation rates
delta_res=1-(1-0.125)^(1/4) ;
delta_nres=1-(1-0.025)^(1/4);
delta_all=1-(1-0.1)^(1/4);

% [1] NIPA
% Perpetual calendar method
init_aux=min(index_s(logical(1-isnan(R_PRI)))); %
KRES_NIPA=NaN*zeros(T,1);
KRST_NIPA=NaN*zeros(T,1);
KRES_NIPA(init_aux:T,1)=R_PNRI(init_aux)/(delta_res);
KRST_NIPA(init_aux:T,1)=R_PRI(init_aux)/(delta_nres);
for ii=init_aux+1:T
     KRST_NIPA(ii)=(1-delta_nres)*KRST_NIPA(ii-1)+R_PRI(ii-1);
     KRES_NIPA(ii)=(1-delta_res)*KRES_NIPA(ii-1)+R_PNRI(ii-1);
end
K_NIPA=KRES_NIPA+KRST_NIPA;

% From Real Investment Series in NIPA
K_NIPA1=NaN*zeros(T,1);
init_aux=min(index_s(logical(1-isnan(RINV)))); %
K_NIPA1(init_aux:T)=RINV(init_aux)/delta_all;
for ii=init_aux+1:T
     K_NIPA1(ii,1)=(1-delta_all)*K_NIPA1(ii-1)+RINV(ii-1) ;
end
I_NIPA1=RINV;

% Flow of Funds - Not Seasonally Adjusted
%RI_FoF=RES+RST;                                               % Constructing measure from FoF
% KRES_FoF(1:T)=RES(1)/delta_res;
% KRST_FoF(1:T)=RST(1)/delta_nres;
for ii=2:T
%     KRES_FoF(ii)=KRST_FoF(ii-1)+(1-delta_res)*RST(ii-1);
%     KRST_FoF(ii)=KRES_FoF(ii-1)+(1-delta_nres)*RES(ii-1);
end
%K_FoF=KRES_FoF+KRST_FoF;
K_FoF=RES+RST;
I_RES=RES(2:end)-(1-delta_res)*RES(1:end-1);
I_RST=RST(2:end)-(1-delta_nres)*RST(1:end-1);
I_FoF=[NaN; I_RES+I_RST];

% BEA Following Fernald
init_aux=min(index_s(logical(1-isnan(BEA_RST)))); %
I_BEA=BEA_RST+BEA_RES;
KRES_BEA=NaN*zeros(T,1);
KRST_BEA=NaN*zeros(T,1);
KRES_BEA(init_aux:T,1)=BEA_RES(init_aux)/delta_res;
KRST_BEA(init_aux:T,1)=BEA_RST(init_aux)/delta_nres;
for ii=init_aux+1:T
     KRST_BEA(ii,1)=(1-delta_nres)*KRST_BEA(ii-1)+BEA_RST(ii-1) ;
     KRES_BEA(ii,1)=(1-delta_res)*KRES_BEA(ii-1)+BEA_RES(ii-1);
end
K_BEA=KRES_BEA+KRST_BEA;

% Investment From OECD - OECD measure of Investment
I_OECD=Dataset.USAGFCFQDSMEI./GDPDEF; %  not deflated
K_OECD=NaN*zeros(T,1);;
init_aux=min(index_s(logical(1-isnan(I_OECD)))); %
K_OECD(init_aux:T,1)=I_OECD(init_aux)/delta_all;
for ii=init_aux+1:T
     K_OECD(ii,1)=(1-delta_all)*K_OECD(ii-1)+I_OECD(ii-1) ;
end

%% Filter To Obtain A_t process
% Preference for TFP Process
AK=0;
alpha=1/3; % Benchmark Capital Coefficient Coefficiente

% Constructing Total Factor Productivity Measures
TFPlist={'NIPA','NIPA1','BEA','OECD','FoF'};
NCTFP=0.01; % Normalizing Constant TFP
if AK==1;
else
    % Compute Growth Rates
    for ii=1:numel(TFPlist)
        eval(['F_' char(TFPlist(ii)) '=NCTFP*HOURS.^(1-alpha).*K_' char(TFPlist(ii)) '.*alpha;']);
        eval(['FU_' char(TFPlist(ii)) '=NCTFP*HOURS.^(1-alpha).*(K_' char(TFPlist(ii)) ').*alpha.*UTIL;']);
        eval(['A_' char(TFPlist(ii)) '= GDP./F_' char(TFPlist(ii)) ';']);
        eval(['AU_' char(TFPlist(ii)) '= GDP./FU_' char(TFPlist(ii)) ';']);
%         eval(['rA_' char(TFPlist(ii)) '= [4*mean(diff(log(A_' char(TFPlist(ii)) '(1:5))))   ; 4*diff(log(A_' char(TFPlist(ii)) '))];' ]);
%         eval(['rAU_' char(TFPlist(ii)) '= [4*mean(diff(log(AU_' char(TFPlist(ii)) '(1:5))))   ; 4*diff(log(AU_' char(TFPlist(ii)) '))];' ]);
    end
end
Alist={'A_fer','AU_fer','A_NIPA','AU_NIPA','A_BEA','AU_BEA','alpha_fer'};

%% Trends and Filters
% Computing Linear Trends + HPFilters
% List of Variables we want to manipulate
% Do for Non-Stationary, Nominal and Series Cointegrated with GDP
%NomList={'GDP','INV','PNRI','PRI','COFC','CONS','NONDURCO','DURCO','GOV','NX','EXP','M','HOURS'}; 
NomList={'COE','WAGES','GDP','INV','PNRI','PRI','COFC','CONS','NONDURCO','DURCO','GOV','NX','EXP','M','HOURS','GDPDEF'};  
varlist=[Alist FernaldName_List rinv_list cap_list NomList {'IPMAN','RTTLCONS','RPCESV','RGDP','RINV','RDURINV','RPNRI','RPRI','R_PNRI','R_PRI','RCOFC','RCONS','R_NONDURCO','R_DURCO','RGOV','RNX','REXP','RM','RCPH','HOURS','Y_L','GDPDEF'}];  

% This Section Tests the GDP Deflator
% Computing Log Differences and real Log Differences for annualized rates
% Use Var List
BDP_logdiff;
% for ii=1:numel(varlist)
%     eval(['ld_' char(varlist(ii)) '= [mean(diff(log(' char(varlist(ii)) '(1:5))))   ; diff(log(' char(varlist(ii)) '))];' ]);
% end

% Computing Deflated growth
% Use Nom List
% BDP_rlogdiff
% for ii=1:numel(NomList)
%     eval(['rld_' char(NomList(ii)) '= ld_' char(NomList(ii)) '-ld_GDPDEF;']);
% end

% Growth Rates and trends
varlist=[Alist FernaldName_List rinv_list cap_list NomList {'RGDP','RINV','RDURINV','RPNRI','RPRI',...
            'IPMAN','RTTLCONS','RPCESV','R_PNRI','R_PRI','RCOFC','RCONS','R_NONDURCO','R_DURCO',...
            'RGOV','RNX','REXP','RM','RCPH','HOURS','Y_L','GDPDEF'}];  
DateEndTrend=End_GreatRec+12; % Date for end of linear trend
initlindate=Beg_GreatRec-1; % Beginning of linear t
% datenum('31-Sept-1980');
pl=6; pu=32;
BDP_transformations;
% for ii=1:numel(varlist)-1
% %     eval([char(varlist(ii)) '_g= [mean(diff(log(R' char(varlist(ii)) '(1:5))))   ; diff(log(R' char(varlist(ii)) '))];' ]);
%     eval([char(varlist(ii)) '_g= [diff(log(' char(varlist(ii)) '(1:5)))   ; diff(log(' char(varlist(ii)) '))];' ]);   
%     eval(['range            = isfinite(' char(varlist(ii)) ');']);
%     %eval(['[hp_' char(varlist(ii)) ',c_' char(varlist(ii))  ']=hpfilter_ext(' char(varlist(ii)) '(range),lambda_hp);' ]);
%     
%     eval(['[hp_aux,c_aux]=hpfilter_ext(' char(varlist(ii)) '(range),lambda_hp);' ]);
%     eval(['hp_' char(varlist(ii)) '=[NaN*ones(T,1)];']);
%     eval(['c_' char(varlist(ii)) '=[NaN*ones(T,1)];']);
%     eval(['hp_' char(varlist(ii)) '(range)=[hp_aux];']);
%     eval(['c_' char(varlist(ii)) '(range)=[c_aux];']);
%     %eval(['hp_' char(varlist(ii)) '=[NaN(init_aux-1,1); hp_' char(varlist(ii)) '];']);
%     eval(['l_' char(varlist(ii)) '= log(' char(varlist(ii)) ');']);
%     eval(['lhp_' char(varlist(ii)) '= log(hp_' char(varlist(ii)) ');']);
%     eval(['devhp_' char(varlist(ii)) '= log(c_' char(varlist(ii)) './hp_' char(varlist(ii)) '+1);']);
%     
%     % Band-Pass Filter
% %    [fX] = bandpass(X,pl,pu)
%     eval(['[cp_aux]=bpass(' char(varlist(ii)) '(range),pl,pu);']);
%     eval(['bp_aux=' char(varlist(ii)) '(range)-cp_aux;']);
%     eval(['bp_' char(varlist(ii)) '=[NaN*ones(T,1)];']);
%     eval(['cp_' char(varlist(ii)) '=[NaN*ones(T,1)];']);
%     eval(['bp_' char(varlist(ii)) '(range)=[bp_aux];']);
%     eval(['cp_' char(varlist(ii)) '(range)=[cp_aux];']);
%     
%     %eval(['hp_' char(varlist(ii)) '=[NaN(init_aux-1,1); hp_' char(varlist(ii)) '];']);
% %     eval(['l_' char(varlist(ii)) '= log(' char(varlist(ii)) ');']);
% %     eval(['lhp_' char(varlist(ii)) '= log(hp_' char(varlist(ii)) ');']);
%     eval(['devbp_' char(varlist(ii)) '= log(cp_' char(varlist(ii)) './bp_' char(varlist(ii)) '+1);']);
%     
%     % First Real
%     % Pick the first element
%     firstdate=0;
%     if firstdate==1
%         eval(['init_aux=min(index_s(logical(1-isnan(' char(varlist(ii)) '))));']);    
%     else
%         init_aux=min(index_s(logical(dates>initlindate)));    
%     end
%     eval(['lt_' char(varlist(ii)) '= (l_' char(varlist(ii)) '(DateEndTrend)-l_' char(varlist(ii)) '(init_aux))*((init_aux:T)-init_aux)/(DateEndTrend-init_aux)+l_' char(varlist(ii)) '(init_aux);']);    
%     eval(['lt_' char(varlist(ii)) '=[NaN(init_aux-1,1); lt_' char(varlist(ii)) '''];']);
%     eval(['ldev_' char(varlist(ii)) '= log(' char(varlist(ii)) ')-lt_' char(varlist(ii)) ';']);
%     
%     % Auxiliary Data
%     eval([char(varlist(ii)) '_art=l_' char(varlist(ii)) ';']);
%     eval([char(varlist(ii)) '_art(init_aux:end)=lt_' char(varlist(ii)) '(init_aux:end);']);
%     eval(['[hp_aux,c_aux]=hpfilter_ext(' char(varlist(ii)) '_art(range),lambda_hp);' ]);
%     eval(['hpart_' char(varlist(ii)) '=[NaN*ones(T,1)];']);
%     eval(['cart_' char(varlist(ii)) '=[NaN*ones(T,1)];']);
%     eval(['hpart_' char(varlist(ii)) '(range)=[hp_aux];']);
%     eval(['cart_' char(varlist(ii)) '(range)=l_' char(varlist(ii)) '(range)-hp_aux;']);
%     %eval(['hp_' char(varlist(ii)) '=[NaN(init_aux-1,1); hp_' char(varlist(ii)) '];']);
% %     eval(['lart_' char(varlist(ii)) '= log(' char(varlist(ii)) ');']);
% %     eval(['lhpart_' char(varlist(ii)) '= log(hpart_' char(varlist(ii)) ');']);
%     eval(['devhpart_' char(varlist(ii)) '= (cart_' char(varlist(ii)) ');']);
% end 
% List of Variables that feature trend but seem to be log-stationary
% Includes TFP, Inventory and NIPA
I1_list= [Alist FernaldName_List rinv_list {'RGDP','RINV','RDURINV','RPNRI','RPRI','R_PNRI','R_PRI',...
    'IPMAN','RPCESV','RTTLCONS','RCOFC','RCONS','R_NONDURCO','R_DURCO','RGOV','RNX','REXP','RM','RCPH','HOURS','Y_L'}];

%% Key Ratios
RatioList=[];

% Ratios for Investment
% I_NIPA=RINV;
I_NIPA=R_PNRI;
TFPlist={'NIPA','NIPA1','BEA','OECD','FoF'};
for ii=1:numel(TFPlist)
    eval(['I_K_' char(TFPlist(ii)) '=I_' char(TFPlist(ii)) './K_' char(TFPlist(ii)) ';']);
    eval(['I_Y_' char(TFPlist(ii)) '=I_' char(TFPlist(ii)) './RGDP;']);
    eval(['RatioList=[RatioList {''I_K_' char(TFPlist(ii)) ''',''I_Y_' char(TFPlist(ii)) '''}];']);
end

% Smooth Ratio Series
RatioSmooth_list={'I_K_NIPA'};
for ii=1:numel(RatioSmooth_list);
    eval(['range            = isfinite(' char(RatioSmooth_list(ii)) ');']);
    %eval(['[hp_' char(varlist(ii)) ',c_' char(varlist(ii))  ']=hpfilter_ext(' char(varlist(ii)) '(range),lambda_hp);' ]);
    eval(['[hp_aux,c_aux]=hpfilter_ext(' char(RatioSmooth_list(ii)) '(range),lambda_hp);' ]);
    eval(['hp_' char(RatioSmooth_list(ii)) '=[NaN*ones(T,1)];']);
    eval(['c_' char(RatioSmooth_list(ii)) '=[NaN*ones(T,1)];']);
    eval(['hp_' char(RatioSmooth_list(ii)) '(range)=[hp_aux];']);
    eval(['c_' char(RatioSmooth_list(ii)) '(range)=[c_aux];']);
end

% Stucture Investment and Software and Equipment
aux_list={'RPRI','RPNRI','R_PRI','R_PNRI','RCONS','RNONDURCO','RDURCO','RGOV','RNX','REXP'};
for ii=1:numel(aux_list)
    eval([char(aux_list(ii)) '_I=' char(aux_list(ii)) './RINV;']);
    eval([char(aux_list(ii)) '_Y=' char(aux_list(ii)) './RGDP;']);
    eval(['RatioList=[RatioList {''' char(aux_list(ii)) '_I'',''' char(aux_list(ii)) '_Y''}];']);
end

% Inventory Ratios
aux_list=rinv_list; % All inventory Items {'RAORD','RDORD','RCORD','RAINV','RDINV','RCINV','RASHI','RDSHI','RCSHI','RAUO','RDUO','RCUO'};
inv_scale=1000;
for ii=1:numel(aux_list)
    eval([ char(aux_list(ii)) '_I=' char(aux_list(ii)) './RINV/inv_scale;']);
    eval([ char(aux_list(ii)) '_Y=' char(aux_list(ii)) './RGDP/inv_scale;']);
    eval(['RatioList=[RatioList {''' char(aux_list(ii)) '_I'',''' char(aux_list(ii)) '_Y''}];']);
end

% Inventory Ratios
aux_list={'A','D','C'};
for ii=1:numel(aux_list)
    % New Orders relative to Inventory
    eval([char(aux_list(ii)) 'ORD_INV=' char(aux_list(ii)) 'ORD./' char(aux_list(ii)) 'INV;']);
    % Shipments to Inventory
    eval([char(aux_list(ii)) 'SHI_INV=' char(aux_list(ii)) 'SHI./' char(aux_list(ii)) 'INV;']);
    % Unfilled over total orders
    eval([char(aux_list(ii)) 'UO_INV=' char(aux_list(ii)) 'UO./' char(aux_list(ii)) 'INV;']);
    % New orders over unfilled
    eval([char(aux_list(ii)) 'ORD_UO=' char(aux_list(ii)) 'ORD./' char(aux_list(ii)) 'UO;']);
    % Add to Ratio List
    eval(['RatioList=[RatioList {''' char(aux_list(ii)) 'ORD_INV'',''' char(aux_list(ii)) 'SHI_INV''}];']);
    eval(['RatioList=[RatioList {''' char(aux_list(ii)) 'UO_INV'',''' char(aux_list(ii)) 'ORD_UO''}];']);
end

%Relative to Investment and Output
aux_list=rinv_list; % All inventory Items {'AORD','DORD','CORD','AINV','DINV','CINV','ASHI','DSHI','CSHI','AUO','DUO','CUO'};
for ii=1:numel(aux_list)
    eval([char(aux_list(ii)) '_I=' char(aux_list(ii)) './INV/inv_scale;']);
    eval([char(aux_list(ii)) '_Y=' char(aux_list(ii)) './GDP/inv_scale;']);
end

% Labor Income over Output
LabShare=COE./GDP ; % Paid compensation of employees in $ billions of GDP
NLabShare=COE./(GDP-GOV) ; % Paid compensation of employees in $ billions of GDP
RatioList=[RatioList {'LabShare','NLabShare'}];

% Display Measures
disp('*******************************************');
disp('****  LABOR MARKET SHARES *****************');
disp('*******************************************');
disp(['Labor Income Share: ' num2str(mean(LabShare(LabShare>0)))]);
disp(['Labor Income Share: ' num2str(mean(NLabShare(NLabShare>0)))]);

%% Wedge Analysis
% Labor Wedge
nu=1/2; % Inverse Frisch-Elasticity
nu_bar=1.1;
nu_bar_shimer=0.001;
GHH=1;
H2M=1;
WorkCons=COE*H2M+(1-H2M)*CONS;
FLabWedge=(1-alpha)-LabShareShimer;
NLabWedge=((1-alpha)*(GDP-GOV)-COE)./COE;
HLabWedge=1-nu_bar*WorkCons.^(1-GHH).*HOURS.^(1+nu)./COE;
LabWedge =1-(1-HLabWedge)./(1+FLabWedge);
ShimerLabWedge=1-nu_bar_shimer/(1-alpha)*LabShareShimer.*HOURS.^(1+nu); % Equation 

% Demand Shock in Bianchi Bigio paper:
epsilon_bar=(1+nu)/(nu*(1-alpha));
% Theta_t=FLabWedge./((1-alpha).*A_fer).^(epsilon_bar);
Theta_t=1./((1-alpha).*(1+devhpart_A_fer)*100).^(epsilon_bar);
DataTheta=Theta_t;
tags_Theta={'Theta'};
fts = fints(dates,DataTheta,tags_Theta);
fts_Theta=toquarterly(fts);
save DataTheta.mat fts_Theta tags_Theta;

figure
% close all;
pseries={'Theta_t'};
% 'ShimerLabWedge',
date_types='gr';
FRED_fix_dates;
BDP_autoplot
Example_RecessionPlot2(dates);
title(['\bf Measured \Theta_t (\nu=' num2str(nu) ')']);
ylabel('%'); 
% legend('\Theta_t');
saveas(gcf,'F_Theta','pdf')
orient landscape;

% Labor Wedge
figure
% close all;
pseries={'devhpart_A_fer'};
% 'ShimerLabWedge',
date_types='gr';
FRED_fix_dates;
BDP_autoplot
title('\bf Labor Wedge Measurement');
ylabel('%'); 
legend('FLabWedge','A_fer');
orient landscape;

% Bigio Labor Liquidity Measure
theta_l=0.35;
Y_K_NIPA1=I_K_NIPA1./I_Y_NIPA1;
x_l_data=(1-alpha_fer)./GDP-theta_l;

RatioSmooth_list={'I_K_NIPA','x_l_data'};
for ii=1:numel(RatioSmooth_list);
    eval(['range            = isfinite(' char(RatioSmooth_list(ii)) ');']);
    %eval(['[hp_' char(varlist(ii)) ',c_' char(varlist(ii))  ']=hpfilter_ext(' char(varlist(ii)) '(range),lambda_hp);' ]);
    eval(['[hp_aux,c_aux]=hpfilter_ext(' char(RatioSmooth_list(ii)) '(range),100);' ]);
    eval(['hp_' char(RatioSmooth_list(ii)) '=[NaN*ones(T,1)];']);
    eval(['c_' char(RatioSmooth_list(ii)) '=[NaN*ones(T,1)];']);
    eval(['hp_' char(RatioSmooth_list(ii)) '(range)=[hp_aux];']);
    eval(['c_' char(RatioSmooth_list(ii)) '(range)=[c_aux];']);
end
x_l_data=x_l_data;
% I_K_data=I_K_NIPA;
aux=invshare_fer.*Yprod_fer./K_fer;
I_K_data=aux./mean(aux(aux>0))*(1-0.9^(1/4));

NonSalCost=ULC./RCPH; % Should measure additional cost beyond direct labor costs
varlist={'NonSalCost'};
for ii=1:numel(varlist)
    eval(['nl' char(varlist(ii)) '= [mean(diff(log(' char(varlist(ii)) '(1:5))))   ; diff(log(' char(varlist(ii)) '))];' ]);
end
% OPH   = Dataset.OPHNFB  ; % Nonfarm Business Sector: Output Per Hour of All Persons (index)
% ULC   = Dataset.ULCNFB  ; % Nonfarm Business Sector: Unit Labor Cost 2009=100
% RCPH  = Dataset.COMPRNFB  ; % Business Sector: Real Compensation Per Hour
RatioList=[RatioList {'LabWedge','NLabWedge'}];
disp(['Shimer Labor Wedge: ' num2str(mean(ShimerLabWedge(ShimerLabWedge>0)))]);
disp(['Bigio Labor Wedge : ' num2str(mean(LabWedge(LabWedge>0)))]);
disp(['Firm Side Labor Wedge : ' num2str(mean(FLabWedge(FLabWedge>0)))]);
disp(['Household Side Labor Wedge : ' num2str(mean(HLabWedge(HLabWedge>0)))]);


%% Business Cycle  Moments
% Business Cycle Occupation Times
Occupation        = sum(RecIndic(1:T))/T;

% Works if first period not recession and last period is not recession
N_recs =0;
N_nrecs=1;
Dur_rec=3 ;
Dur_nrec=25;
count  =0;
for ii=2:length(RecIndic);
    count=count+1;
    if RecIndic(ii-1)==1&&RecIndic(ii)==0;
        N_recs=N_recs+1;        
        Dur_rec=Dur_rec*(N_recs-1)/N_recs+(count)/N_recs;
        count=0        ;
    elseif RecIndic(ii-1)==0&&RecIndic(ii)==1;
        N_nrecs=N_nrecs+1;        
        Dur_nrec=Dur_nrec*(N_nrecs-1)/N_nrecs+(count)/N_nrecs;        
        count=0;
    end
end
BoomDuration      = Dur_nrec;
RecDuration       = Dur_rec;
GreatRecDuration  = 6;
disp('*******************************************');
disp('****  RECESSION DURATIONS *****************');
disp('*******************************************');
disp(['Duration of Booms: ' num2str(BoomDuration)]);
disp(['Duration of Recessions: ' num2str(RecDuration)]);

%% Estimation of Process for TFP
% Average Growth Rates
TFPlist={'A','AU'};

% Estimating TFP process 
% Flow of Funds Estimates
aux=devhp_A_BEA(logical(HistIndic));
[ar_coeffs,NoiseVariance,reflect_coeffs] = aryule(aux(isfinite(aux)),1);
mu_NIPA=0;
rho_NIPA=-ar_coeffs(2);
sigma_NIPA=sqrt(NoiseVariance);

aux=devhp_A_fer(logical(HistIndic));
[ar_coeffs,NoiseVariance,reflect_coeffs] = aryule(aux(isfinite(aux)),1);
mu_fer=0;
rho_fer=-ar_coeffs(2);
sigma_fer=sqrt(NoiseVariance);

aux=devhp_AU_fer(logical(HistIndic));
[ar_coeffs,NoiseVariance,reflect_coeffs] = aryule(aux(isfinite(aux)),1);
mu_ufer=0;
rho_ufer=-ar_coeffs(2);
sigma_ufer=sqrt(NoiseVariance);

aux=c_RGDP(logical(HistIndic))./hp_RGDP(logical(HistIndic));
[ar_coeffs,NoiseVariance,reflect_coeffs] = aryule(aux(isfinite(aux)),1);
mu_RGDP=0;
rho_RGDP=-ar_coeffs(2);
sigma_RGDP=sqrt(NoiseVariance);
% Yfit_FoF=exp(mu_FoF*(1-rho_FoF)+rho_FoF*log(A_FoF(1:end-1))).*K_FoF(2:end);

% Display
disp('*******************************************');
disp('****  AR(1) Estimates of TFP Process ******');
disp('*******************************************');
disp('*******************************************');
disp('****  NIPA **************');
disp('*******************************************');
disp(['mu    A: ' num2str(mu_NIPA)]);
disp(['rho   A: ' num2str(rho_NIPA)]);
disp(['sigma A: ' num2str(sigma_NIPA)]);
disp('*******************************************');
disp('****  FERNALD **************');
disp('*******************************************');
disp(['mu    A: ' num2str(mu_fer)]);
disp(['rho   A: ' num2str(rho_fer)]);
disp(['sigma A: ' num2str(sigma_fer)]);
disp('*******************************************');
disp('*******************************************');
disp('****  FERNALD **************');
disp('*******************************************');
disp(['mu    A: ' num2str(mu_fer)]);
disp(['rho   A: ' num2str(rho_fer)]);
disp(['sigma A: ' num2str(sigma_fer)]);
disp('*******************************************');
disp('*******************************************');
disp('****  FERNALD TFP w/ UTILIZATION **************');
disp('*******************************************');
disp(['mu    A: ' num2str(mu_ufer)]);
disp(['rho   A: ' num2str(rho_ufer)]);
disp(['sigma A: ' num2str(sigma_ufer)]);
disp('*******************************************');

%% Constructing KEY Business Cycle Ratios

%-------------------------
% For Ratio Variables 
%-------------------------
% Means and Deviations, Average Sample, Pre-90's, Post90's, Boom, Bust, GR
aux_list=RatioList;
for ii=1:numel(aux_list)    
    for dd=1:5
        % All the Sample
         switch dd
          case 1 % historical
            eval(['range            = isfinite(' char(aux_list(ii)) ');']);
            str={'h'};
          case 2 % Expansion
            eval(['range            = logical(isfinite(' char(aux_list(ii)) ').*(NotRecIndic==1));']);
            str={'ex'};
          case 3 % Recession
            eval(['range            = logical(isfinite(' char(aux_list(ii)) ').*(RecIndic==1));']);
            str={'rec'};
          case 4 % Last Decade
            eval(['range            = logical(isfinite(' char(aux_list(ii)) ').*(DecIndic==1));']);
            str={'dec'};
          case 5 % Great Recession
            eval(['range            = logical(isfinite(' char(aux_list(ii)) ').*(GreatRecIndic==1));']);
            str={'gr'};
         end        
         eval(['mu_' char(str) '_' char(aux_list(ii))          '= mean(' char(aux_list(ii)) '(range))                       ;']);
         eval(['sd_' char(str) '_' char(aux_list(ii))          '= sqrt(mean((' char(aux_list(ii)) '(range)-mu_' char(str) '_' char(aux_list(ii)) ').^2))/mu_' char(str) '_' char(aux_list(ii)) ';']);
    end        
end

%-------------------------
% For I1 Variables 
%-------------------------
% Means and Deviations, Average Sample, Pre-90's, Post90's, Boom, Bust, GR
aux_list=I1_list;
% Linear Deviations
for ii=1:numel(aux_list)    
    for dd=1:5
        % All the Sample
         switch dd
          case 1 % historical
            eval(['range            = isfinite(ld_' char(aux_list(ii)) ');']);
            str={'h'};
          case 2 % Expansion
            eval(['range            = logical(isfinite(ld_' char(aux_list(ii)) ').*(NotRecIndic==1));']);
            str={'ex'};
          case 3 % Recession
            eval(['range            = logical(isfinite(ld_' char(aux_list(ii)) ').*(RecIndic==1));']);
            str={'rec'};
          case 4 % Last Decade
            eval(['range            = logical(isfinite(ld_' char(aux_list(ii)) ').*(DecIndic==1));']);
            str={'dec'};
          case 5 % Great Recession
            eval(['range            = logical(isfinite(ld_' char(aux_list(ii)) ').*(GreatRecIndic==1));']);
            str={'gr'};
         end
         
         % Average Linear Growth
         eval(['mu_' char(str) '_ld_' char(aux_list(ii))          '= mean(ld_' char(aux_list(ii)) '(range))                       ;']);
         eval(['sd_' char(str) '_ld_' char(aux_list(ii))          '= sqrt(mean((ld_' char(aux_list(ii)) '(range)-mu_' char(str) '_ld_' char(aux_list(ii)) ').^2))/mu_' char(str) '_ld_' char(aux_list(ii)) ';']);
     end        
end

% Linear Deviations
for ii=1:numel(aux_list)    
    for dd=1:5
        % All the Sample
         switch dd
          case 1 % historical
            eval(['range            = isfinite(ldev_' char(aux_list(ii)) ');']);
            str={'h'};
          case 2 % Expansion
            eval(['range            = logical(isfinite(ldev_' char(aux_list(ii)) ').*(NotRecIndic==1));']);
            str={'ex'};
          case 3 % Recession
            eval(['range            = logical(isfinite(ldev_' char(aux_list(ii)) ').*(RecIndic==1));']);
            str={'rec'};
          case 4 % Last Decade
            eval(['range            = logical(isfinite(ldev_' char(aux_list(ii)) ').*(DecIndic==1));']);
            str={'dec'};
          case 5 % Great Recession
            eval(['range            = logical(isfinite(ldev_' char(aux_list(ii)) ').*(GreatRecIndic==1));']);
            str={'gr'};
         end
         
         % Deviation from Trend
         eval(['mu_' char(str) '_ldev_' char(aux_list(ii))          '= mean(ldev_' char(aux_list(ii)) '(range))                       ;']);
         eval(['sd_' char(str) '_ldev_' char(aux_list(ii))          '= sqrt(mean((ldev_' char(aux_list(ii)) '(range)-mu_' char(str) '_ldev_' char(aux_list(ii)) ').^2))/mu_' char(str) '_ldev_' char(aux_list(ii)) ';']);
     end        
end

% Hodrick-Prescott Deviations
artcorr=1;
if artcorr==0
for ii=1:numel(aux_list)    
    for dd=1:5
        % All the Sample
         switch dd
          case 1 % historical
            eval(['range            = isfinite(devhp_' char(aux_list(ii)) ');']);
            str={'h'};
          case 2 % Expansion
            eval(['range            = logical(isfinite(devhp_' char(aux_list(ii)) ').*(NotRecIndic==1));']);
            str={'ex'};
          case 3 % Recession
            eval(['range            = logical(isfinite(devhp_' char(aux_list(ii)) ').*(RecIndic==1));']);
            str={'rec'};
          case 4 % Last Decade
            eval(['range            = logical(isfinite(devhp_' char(aux_list(ii)) ').*(DecIndic==1));']);
            str={'dec'};
          case 5 % Great Recession
            eval(['range            = logical(isfinite(devhp_' char(aux_list(ii)) ').*(GreatRecIndic==1));']);
            str={'gr'};
         end
         
         % Deviation from Trend
         eval(['mu_' char(str) '_devhp_' char(aux_list(ii))          '= mean(devhp_' char(aux_list(ii)) '(range))                       ;']);
         % eval(['sd_' char(str) '_devhp_' char(aux_list(ii))          '= sqrt(mean((devhp_' char(aux_list(ii)) '(range)-mu_' char(str) '_devhp_' char(aux_list(ii)) ').^2))/mu_' char(str) '_devhp_' char(aux_list(ii)) ';']);
         eval(['sd_' char(str) '_devhp_' char(aux_list(ii))          '= sqrt(mean((devhp_' char(aux_list(ii)) '(range)-mu_' char(str) '_devhp_' char(aux_list(ii)) ').^2));']);
     end        
end
else
for ii=1:numel(aux_list)    
    for dd=1:5
        % All the Sample
         switch dd
          case 1 % historical
            eval(['range            = isfinite(devhpart_' char(aux_list(ii)) ');']);
            str={'h'};
          case 2 % Expansion
            eval(['range            = logical(isfinite(devhpart_' char(aux_list(ii)) ').*(NotRecIndic==1));']);
            str={'ex'};
          case 3 % Recession
            eval(['range            = logical(isfinite(devhpart_' char(aux_list(ii)) ').*(RecIndic==1));']);
            str={'rec'};
          case 4 % Last Decade
            eval(['range            = logical(isfinite(devhpart_' char(aux_list(ii)) ').*(DecIndic==1));']);
            str={'dec'};
          case 5 % Great Recession
            eval(['range            = logical(isfinite(devhpart_' char(aux_list(ii)) ').*(GreatRecIndic==1));']);
            str={'gr'};
         end
         
         % Deviation from Trend
         eval(['mu_' char(str) '_devhpart_' char(aux_list(ii))          '= mean(devhpart_' char(aux_list(ii)) '(range))                       ;']);
         % eval(['sd_' char(str) '_devhp_' char(aux_list(ii))          '= sqrt(mean((devhp_' char(aux_list(ii)) '(range)-mu_' char(str) '_devhp_' char(aux_list(ii)) ').^2))/mu_' char(str) '_devhp_' char(aux_list(ii)) ';']);
         eval(['sd_' char(str) '_devhpart_' char(aux_list(ii))          '= std(devhpart_' char(aux_list(ii)) '(range));']);
     end        
end
    
end
%-------------------------
% Relative Volatility 
%-------------------------
artcorr=1;
if artcorr==0
    for ii=1:numel(aux_list)    
        for dd=1:5
            % All the Sample
             switch dd
              case 1 % historical
                str={'h'};
              case 2 % Expansion
                str={'ex'};
              case 3 % Recession
                str={'rec'};
              case 4 % Last Decade
                str={'dec'};
              case 5 % Great Recession
                str={'gr'};
             end         
             % eval(['sd_' char(str) '_devhp_' char(aux_list(ii))          '= sqrt(mean((devhp_' char(aux_list(ii)) '(range)-mu_' char(str) '_devhp_' char(aux_list(ii)) ').^2))/mu_' char(str) '_devhp_' char(aux_list(ii)) ';']);
             eval(['sigma_' char(str) '_' char(aux_list(ii)) '_Y=sd_' char(str) '_devhp_'  char(aux_list(ii)) '/sd_' char(str) '_devhp_RGDP;']);
         end        
    end
else
    for ii=1:numel(aux_list)    
        for dd=1:5
            % All the Sample
             switch dd
              case 1 % historical
                str={'h'};
              case 2 % Expansion
                str={'ex'};
              case 3 % Recession
                str={'rec'};
              case 4 % Last Decade
                str={'dec'};
              case 5 % Great Recession
                str={'gr'};
             end         
             % eval(['sd_' char(str) '_devhp_' char(aux_list(ii))          '= sqrt(mean((devhp_' char(aux_list(ii)) '(range)-mu_' char(str) '_devhp_' char(aux_list(ii)) ').^2))/mu_' char(str) '_devhp_' char(aux_list(ii)) ';']);
             eval(['sigma_' char(str) '_' char(aux_list(ii)) '_Y=sd_' char(str) '_devhpart_'  char(aux_list(ii)) '/sd_' char(str) '_devhpart_RGDP;']);
         end        
    end
end
    
%% Correlations
maxcorr=4; % Number of Correlations
artcorr=1;
if artcorr==0
    for ii=1:numel(aux_list)
        eval(['range_1=isfinite(devhp_' char(aux_list(ii)) ');']);
        eval(['range_2=isfinite(devhp_RGDP);']);
        range=range_1.*range_2;
        eval(['corr_' char(aux_list(ii)) '=xcorr(devhp_RGDP(logical(range)),devhp_' char(aux_list(ii)) '(logical(range)),maxcorr,''coeff'');']);
        eval(['corrh_' char(aux_list(ii)) '=xcorr(devhp_HOURS(logical(range)),devhp_' char(aux_list(ii)) '(logical(range)),maxcorr,''coeff'');']);
        eval(['corri_' char(aux_list(ii)) '=xcorr(devhp_RINV(logical(range)),devhp_' char(aux_list(ii)) '(logical(range)),maxcorr,''coeff'');']);
        eval(['corrc_' char(aux_list(ii)) '=xcorr(devhp_RCONS(logical(range)),devhp_' char(aux_list(ii)) '(logical(range)),maxcorr,''coeff'');']);
        eval(['range_2=isfinite(devhp_RDURINV);']);
        range=range_1.*range_2;
        eval(['corrz_' char(aux_list(ii)) '=xcorr(devhp_RDURINV(logical(range)),devhp_' char(aux_list(ii)) '(logical(range)),maxcorr,''coeff'');']);
        eval(['bar(-maxcorr:1:maxcorr,corr_' char(aux_list(ii)) ')']);
        eval(['title(''' char(aux_list(ii)) ''');']);
    end
else
    for ii=1:numel(aux_list)
        eval(['range_1=isfinite(devhpart_' char(aux_list(ii)) ');']);
        eval(['range_2=isfinite(devhpart_RGDP);']);
        range=range_1.*range_2;
        eval(['corr_' char(aux_list(ii)) '=xcorr(devhpart_RGDP(logical(range)),devhpart_' char(aux_list(ii)) '(logical(range)),maxcorr,''coeff'');']);
        eval(['corrh_' char(aux_list(ii)) '=xcorr(devhpart_HOURS(logical(range)),devhpart_' char(aux_list(ii)) '(logical(range)),maxcorr,''coeff'');']);
        eval(['corri_' char(aux_list(ii)) '=xcorr(devhpart_RINV(logical(range)),devhpart_' char(aux_list(ii)) '(logical(range)),maxcorr,''coeff'');']);
        eval(['corrc_' char(aux_list(ii)) '=xcorr(devhpart_RCONS(logical(range)),devhpart_' char(aux_list(ii)) '(logical(range)),maxcorr,''coeff'');']);
        eval(['range_2=isfinite(devhpart_RDURINV);']);
        range=range_1.*range_2;
        eval(['corrz_' char(aux_list(ii)) '=xcorr(devhpart_RDURINV(logical(range)),devhpart_' char(aux_list(ii)) '(logical(range)),maxcorr,''coeff'');']);
%         eval(['bar(-maxcorr:1:maxcorr,corr_' char(aux_list(ii)) ')']);
%         eval(['title(''' char(aux_list(ii)) ''');']);
    end
end



% Define Investor's Liquidity
x_i_data=R_PNRI_Y*(1-0.3*1.5);
range=isfinite(x_i_data);
corr(x_i_data(range),x_l_data(range));
%% Plots for GDP Components
plotit=0;
if plotit==0
    % Ploting HP-Filter, Levels, Linear Trend, CBO
    for zz=1:0
        figure
        pseries={'RGDP','hp_RGDP'};
        date_types='dec';
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real GDP and Trends');
        ylabel('Log Billion (chained 2009 US$)'); 
        legend('Value','HP-Filter','Linear Trend','Potential Output CBO','Location','NorthWest')        
        orient landscape;
        
        figure
        pseries={'l_RGDP','hpart_RGDP','RGDP_art','lhp_RGDP','logGDP_pot'};
        date_types='dec';
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real GDP and Trends');
        ylabel('Log Billion (chained 2009 US$)'); 
        legend('Log GDP','HP-Filter (original)','Artificial Series','HP-Filter (artificial)','Potential Output (CBO)','Location','NorthWest')        
        orient landscape;
        saveas(gcf,'F_Detrending','pdf');
        
        figure
        pseries={'devbp_RGDP','devhp_RGDP','devhpart_RGDP'};
        date_types='dec';
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real GDP and Trends');
        ylabel('Log Billion (chained 2009 US$)'); 
        legend('BP-Filter','HP-Filter','artificial','Location','NorthWest')        
        orient landscape;
        
        figure
        pseries={'ldev_RGDP','devhp_RGDP','devhpart_RGDP'};
        date_types='dec';
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real GDP and Trends');
        ylabel('Log Billion (chained 2009 US$)'); 
        legend('Diff Linear Tredn','Diff HP','Band-Pass','Location','NorthWest')

        % Crisis Snapshot
        figure
        pseries={'l_RGDP','lhp_RGDP','lt_RGDP','logGDP_pot'};
        date_types='gr';
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real GDP and Trends');
        ylabel('Log Billion (chained 2009 US$)'); 
        legend('Value','HP-Filter','Linear Trend','Potential Output CBO','Location','NorthWest')
        orient landscape;

        % Private Investment 
        figure
        pseries={'l_RINV','lhp_RINV','lt_RINV','logINV_pot'};
        date_types='dec';
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real Investment and Trends');
        ylabel('Log Billion (chained 2009 US$)'); 
        legend('Value','HP-Filter','Linear Trend','Potential CBO','Location','NorthWest')
        orient landscape;

        % Private Investment 
        figure
        pseries={'l_RPNRI','lhp_RPNRI','lt_RPNRI'};
        date_types='dec';
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real Non-Residential Investment and Trends');
        ylabel('Log Billion (chained 2009 US$)'); 
        legend('Value','HP-Filter','Linear Trend','Location','NorthWest')
        orient landscape;

        figure
        pseries={'l_RPRI','lhp_RPRI','lt_RPRI'};
        date_types='dec';
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real Residential Investment and Trends');
        ylabel('Log Billion (chained 2009 US$)'); 
        legend('Value','HP-Filter','Linear Trend','Location','NorthWest')
        orient landscape;

        figure
        pseries={'l_RCONS','lhp_RCONS','lt_RCONS','logCONS_pot'};
        date_types='gr';
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real Consumption and Trends');
        ylabel('Log Billion (chained 2009 US$)'); 
        legend('Value','HP-Filter','Linear Trend','CBO estimate','Location','NorthWest')
        orient landscape;

        figure
        pseries={'l_R_NONDURCO','lhp_R_NONDURCO','lt_R_NONDURCO'};
        date_types='gr';
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real Non-Durable Consumption and Trends');
        ylabel('Log Billion (chained 2009 US$)'); 
        legend('Value','HP-Filter','Linear Trend','Location','NorthWest')
        orient landscape;

        figure
        pseries={'l_R_DURCO','lhp_R_DURCO','lt_R_DURCO'};
        date_types='gr';
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real Durable Consumption and Trends');
        ylabel('Log Billion (chained 2009 US$)'); 
        legend('Value','HP-Filter','Linear Trend','Location','NorthWest')
        orient landscape;

        figure
        pseries={'l_REXP','lhp_REXP','lt_REXP'};
        date_types='gr';
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real Exports and Trends');
        ylabel('Log Billion (chained 2009 US$)'); 
        legend('Value','HP-Filter','Linear Trend','Location','NorthWest')
        orient landscape;

        
        % Comovement Plot
        
        figure
        pseries={'l_RM','lhp_RM','lt_RM'};
        date_types='gr';
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real Imports and Trends');
        ylabel('Log Billion (chained 2009 US$)'); 
        legend('Value','HP-Filter','Linear Trend','Location','NorthWest')
        orient landscape;

        figure
        pseries={'l_RGOV','lhp_RGOV','lt_RGOV'};
        date_types='gr';
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real Government Absortion');
        ylabel('Log Billion (chained 2009 US$)'); 
        legend('Value','HP-Filter','Linear Trend','Location','NorthWest')
        orient landscape;

        figure
        pseries={'l_RCPH','lhp_RCPH','lt_RCPH'};
        date_types='all';;;
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real Government Absortion');
        ylabel('Log Billion (chained 2009 US$)'); 
        legend('Value','HP-Filter','Linear Trend','Location','NorthWest')
        orient landscape;

        figure
        pseries={'l_HOURS','lhp_HOURS','lt_HOURS'};
        date_types='gr';
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real Government Absortion');
        ylabel('Log Billion (chained 2009 US$)'); 
        legend('Value','HP-Filter','Linear Trend','Location','NorthWest')
        orient landscape;
        
        figure
        pseries={'devbp_HOURS','devhp_HOURS','devhpart_HOURS'};
        date_types='dec'
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real GDP and Trends');
        ylabel('Log Billion (chained 2009 US$)'); 
        legend('BP-Filter','HP-Filter','Location','NorthWest')        
        orient landscape;
    end

    %% Figures Relative to initial Value
    % Close all Graphs
    close all;
    pbench=Beg_GreatRec-1;
    for zz=1:0
    figure
    subplot(3,2,1:2);
    pseries={'RGDP'};
    date_types='gr';
    FRED_fix_dates;
    BDP_benchautoplot
    title('\bf Real GDP ');
    ylabel('% of pre-crisis level)'); 

    subplot(3,2,3);
    pseries={'RCONS'};
    date_types='gr';
    FRED_fix_dates;
    BDP_benchautoplot
    title('\bf Real Consumption ');
    ylabel('% of pre-crisis level)');

    subplot(3,2,4);
    pseries={'RINV','RDURINV'};
    date_types='gr';
    FRED_fix_dates;
    BDP_benchautoplot
    title('\bf Real Investment ');
    ylabel('% of pre-crisis level)');

    subplot(3,2,5);
    pseries={'HOURS'};
    date_types='gr';
    FRED_fix_dates;
    BDP_benchautoplot
    title('\bf Hours ');
    ylabel('% of pre-crisis level)');

    subplot(3,2,6);
    pseries={'RCPH'};
    date_types='gr';
    FRED_fix_dates;
    BDP_benchautoplot
    title('\bf Real Hourly Compensation');
    ylabel('% of pre-crisis level)');
    orient landscape;

    % GDP Deflator
    figure
    pseries={'GDPDEF'};
    date_types='decade';
    FRED_fix_dates;
    BDP_benchautoplot
    title('\bf GDP Deflator');
    ylabel('% of pre-crisis level)'); 
    end

    %% Begining Plots for Measures of Utilization and Unemployment
    plotit=0;
    pbench=Beg_GreatRec-1;
    for zz=1:0
        figure
        subplot(3,2,3);
        pseries={'OPH'};
        date_types='gr';
        FRED_fix_dates;
        BDP_benchautoplot
        title('\bf Output per Hour (non farm) ');
        ylabel('% of pre-crisis level)'); 

        subplot(3,2,5);
        pseries={'ULC'};
        date_types='gr';
        FRED_fix_dates;
        BDP_benchautoplot
        title('\bf Unit Labor Costs');
        ylabel('% of pre-crisis level)');

        subplot(3,2,6);
        pseries={'RCPH'};
        date_types='gr';
        FRED_fix_dates;
        BDP_benchautoplot
        title('\bf Real Compensation per Hour ');
        ylabel('% of pre-crisis level)');

        subplot(3,2,1);
        pseries={'UNRATE'};
        date_types='gr';
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Unemployment Rate');
        ylabel('% ');

        subplot(3,2,2);
        pseries={'HOURS'};
        date_types='gr';
        FRED_fix_dates;
        BDP_benchautoplot
        title('\bf Total Hours');
        ylabel('% of pre-crisis level)');
        orient landscape;

        subplot(3,2,4);
        pseries={'UTIL'};
        date_types='gr';
        FRED_fix_dates;
        BDP_benchautoplot
        title('\bf Total Utilitzation');
        ylabel('% of pre-crisis level)');
        orient landscape;
    end

    %% Plots for Inventory
    % {'RAORD','RDORD','RCORD','RAINV','RDINV','RCINV','RASHI','RDSHI','RCSHI','RAUO','RDUO','RCUO'};
    pbench=Beg_GreatRec-1;
    for zz=1:0
        figure
        pseries={'l_RAORD','lhp_RAORD','lt_RAORD'};
        date_types='dec'
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real GDP and Trends');
        ylabel('Log Billion (chained 2009 US$)'); 
        legend('Value','HP-Filter','Linear Trend','Location','NorthWest')
        orient landscape;    

        figure
        pseries={'RAORD'};
        date_types='gr';
        FRED_fix_dates;
        BDP_benchautoplot
        title('\bf New Orders (all manufacturing)');
        ylabel('% of pre-crisis level)'); 

        figure
        pseries={'l_RDORD','lhp_RDORD','lt_RDORD'};
        date_types='dec'
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real GDP and Trends');
        ylabel('Log Billion (chained 2009 US$)'); 
        legend('Value','HP-Filter','Linear Trend','Location','NorthWest')
        orient landscape;    

        figure
        pseries={'RDORD'};
        date_types='gr';
        FRED_fix_dates;
        BDP_benchautoplot
        title('\bf New Orders (all manufacturing)');
        ylabel('% of pre-crisis level)'); 

        figure
        pseries={'RCORD'};
        date_types='gr';
        FRED_fix_dates;
        BDP_benchautoplot
        title('\bf Orders Capital Goods');
        ylabel('% of pre-crisis level)'); 

        figure
        pseries={'RAINV'};
        date_types='gr';
        FRED_fix_dates;
        BDP_benchautoplot
        title('\bf All Inventory');
        ylabel('% of pre-crisis level)'); 

        figure
        pseries={'RDINV'};
        date_types='gr';
        FRED_fix_dates;
        BDP_benchautoplot
        title('\bf Durable Inventory');
        ylabel('% of pre-crisis level)'); 

        figure
        pseries={'RCINV'};
        date_types='gr';
        FRED_fix_dates;
        BDP_benchautoplot
        title('\bf Capital Inventory');
        ylabel('% of pre-crisis level)'); 

        figure
        pseries={'RASHI'};
        date_types='gr';
        FRED_fix_dates;
        BDP_benchautoplot
        title('\bf All Shipments');
        ylabel('% of pre-crisis level)'); 

        figure
        pseries={'RDSHI'};
        date_types='gr';
        FRED_fix_dates;
        BDP_benchautoplot
        title('\bf Durable Shipments');
        ylabel('% of pre-crisis level)'); 

        figure
        pseries={'RCSHI'};
        date_types='gr';
        FRED_fix_dates;
        BDP_benchautoplot
        title('\bf Capital Shipments');
        ylabel('% of pre-crisis level)'); 

        figure
        pseries={'RAUO'};
        date_types='dec';
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Un Finished Orders');
        ylabel('% of pre-crisis level)'); 

        figure
        pseries={'RDUO'};
        date_types='gr';
        FRED_fix_dates;
        BDP_benchautoplot
        title('\bf Durable Shipments');
        ylabel('% of pre-crisis level)'); 

        figure
        pseries={'RCUO'};
        date_types='gr';
        FRED_fix_dates;
        BDP_benchautoplot
        title('\bf Capital Shipments');
        ylabel('% of pre-crisis level)'); 
        
        figure
        pseries={'RAORD','RAINV','RASHI','RAUO'};
        date_types='gr';
        FRED_fix_dates;
        BDP_benchautoplot
        title('\bf Capital Shipments');
        legend('Orders','Inventory','Shipments','Unfinished Orders')
        ylabel('% of pre-crisis level)'); 
        
        figure
        pseries={'RAORD','RAINV','RASHI','RAUO'};
        date_types='dec';
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Capital Shipments');
        legend('Orders','Inventory','Shipments','Unfinished Orders')
        ylabel('% of pre-crisis level)'); 

    end

    %% Plots for Capital Stock
    pbench=Beg_GreatRec-1;
    for zz=1:0
%         figure
%         pseries={'RINV','R_I_FoF'};
%         date_types='all';;
%         FRED_fix_dates;
%         BDP_autoplot
%         title('\bf Log - Real GDP and Trends');
%         ylabel('Log Billion (chained 2009 US$)'); 
%         legend('Value','HP-Filter','Linear Trend','Location','NorthWest')
%         orient landscape;    

        figure
        pseries={'l_RES','lt_RES'};
        date_types='all';;
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real GDP and Trends');
        ylabel('Log Billion (chained 2009 US$)'); 
        legend('Value','HP-Filter','Linear Trend','Location','NorthWest')
        orient landscape;    

        figure
        pseries={'l_RPNRI','hp_RPNRI','lt_RPNRI'};
        date_types='dec'
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real GDP and Trends');
        ylabel('Log Billion (chained 2009 US$)'); 
        legend('Value','HP-Filter','Linear Trend','Location','NorthWest')
        orient landscape;  
        
        
    end
    
    %% Plots for TFP measures
    for zz=1:1
        % Plotting All investment Figures
        figure
        subplot(2,2,1:2)
        pseries={'I_NIPA','RINV','I_BEA','I_OECD','I_FoF'};
        date_types='all';;
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Investment Measures');
        ylabel('Billion (chained 2009 US$)'); 
        legend('NIPA','RINV','BEA','OECD','FoF','Location','NorthWest')
        orient landscape;

        subplot(2,2,3:4)
        pseries={'RGDP'};
        date_types='all';;
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real GDP and Trends');
        ylabel('Billion (chained 2009 US$)'); 
        legend('RGDP','Location','NorthWest')
        orient landscape;

        figure
        % pseries={'I_K_NIPA','I_K_NIPA1','I_K_BEA','I_K_OECD','I_K_FoF'};
        pseries={'I_K_NIPA','I_K_NIPA1','I_K_BEA','I_K_OECD'};
        date_types='all';;
        FRED_fix_dates;
        BDP_benchautoplot
        title('\bf Investment Measures');
        ylabel('Billion (chained 2009 US$)'); 
        legend('NIPA','NIPA1','BEA','OECD','FoF','Location','NorthWest')
        orient landscape;               
        
        figure
        pseries={'K_NIPA','K_NIPA1','K_BEA','K_OECD','K_FoF'};
        date_types='all';;
        FRED_fix_dates;
        BDP_benchautoplot
        title('\bf Investment Measures');
        ylabel('Billion (chained 2009 US$)'); 
        legend('NIPA','NIPA1','BEA','OECD','FoF','Location','NorthWest')
        orient landscape;
        

        figure
        pseries={'RGDP','F_NIPA','F_NIPA1','F_BEA'};
        date_types='all';;
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Constant TFP and GDP');
        ylabel('Billion (chained 2009 US$)'); 
        legend('Real GDP','NIPA','NIPA1','BEA','Location','NorthWest')
        orient landscape;

        figure
       
        pseries={'A_NIPA','A_NIPA1','A_BEA','A_fer'};
        date_types='dec'
        FRED_fix_dates;
        BDP_autoplot
        title('\bf TFP Measures');
        ylabel('Billion (chained 2009 US$)'); 
        legend('NIPA','NIPA1','BEA','Fernald','Location','NorthWest') 
        orient landscape;
        
        figure
        pseries={'lt_A_fer','l_A_fer'};
        date_types='dec'
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Linear TFP Measures');
        ylabel('Billion (chained 2009 US$)'); 
        % legend('NIPA','NIPA1','BEA','Fernald','Location','NorthWest') 
        orient landscape;
        
        figure
        pseries={'l_AU_fer','lt_AU_fer'};
        date_types='dec'
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real GDP and Trends');
        ylabel('Log Billion (chained 2009 US$)'); 
        legend('Value','HP-Filter','Linear Trend','Location','NorthWest')
        orient landscape;  
        
        figure
        pseries={'devhpart_A_fer'};
        date_types='dec'
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real GDP and Trends');
        ylabel('Log Billion (chained 2009 US$)'); 
        legend('Value','HP-Filter','Linear Trend','Location','NorthWest')
        orient landscape;

        figure
        pseries={'devhp_A_NIPA','devhp_A_BEA','devhp_RGDP'};
        date_types='dec'
        FRED_fix_dates;
        BDP_autoplot
        title('\bf TFP Measures vs. GDP');
        ylabel('Deviations from HP Trend'); 
        legend('A_NIPA','A_BEA','Real GDP','A (Fernald)','Location','NorthWest')
        orient landscape;
        
        figure
        pseries={'A_NIPA','A_BEA','A_fer'};
        date_types='dec'
        FRED_fix_dates;
        BDP_autoplot
        title('\bf TFP Measures vs. GDP');
        ylabel('Deviations from HP Trend'); 
        legend('A (NIPA)','A (BEA)','Fernald','Real GDP','Location','NorthWest')
        orient landscape;
        
        
         figure
        pseries={'A_fer'};
        date_types='all';;
        FRED_fix_dates;
        BDP_autoplot
        title('\bf TFP Measures vs. GDP');
        ylabel('Deviations from HP Trend'); 
        legend('A (NIPA)','A (BEA)','Fernald','Real GDP','Location','NorthWest')
        orient landscape;
        
        figure
        pseries={'AU_fer'};
        date_types='dec'
        FRED_fix_dates;
        BDP_autoplot
        title('\bf TFP Measures vs. GDP');
        ylabel('Deviations from HP Trend'); 
        legend('A (NIPA)','A (BEA)','Fernald','Real GDP','Location','NorthWest')
        orient landscape;
        
        figure
        pseries={'devhp_A_NIPA','devhp_A_BEA','devhp_RGDP','devhp_A_fer'};
        date_types='all';;
        FRED_fix_dates;
        BDP_autoplot
        title('\bf TFP Measures');
        ylabel('Billion (chained 2009 US$)'); 
        legend('A_NIPA','A_BEA','Real GDP','A (Fernald)','Location','NorthWest')
        orient landscape;

        
        figure
        pseries={'devhp_A_NIPA','devhp_A_BEA','devhp_RGDP'};
        date_types='all';;
        FRED_fix_dates;
        BDP_autoplot
        title('\bf TFP Measures');
        ylabel('Billion (chained 2009 US$)'); 
        legend('A_NIPA','A_BEA','Location','NorthWest')
        orient landscape;
        
        figure
        pseries={'AU_NIPA','AU_NIPA1','AU_BEA'};
        date_types='dec'
        FRED_fix_dates;
        BDP_autoplot
        title('\bf TFP Measures - Adjusting Utilization');
        ylabel('Billion (chained 2009 US$)'); 
        legend('NIPA','NIPA1','BEA','Location','NorthWest')
        orient landscape;

        figure
        pseries={'A_NIPA_g','A_BEA_g'};
        date_types='all';;
        FRED_fix_dates;
        BDP_autoplot
        title('\bf TFP - Annualized Growth Rates');
        ylabel('Billion (chained 2009 US$)'); 
        legend('NIPA','BEA','Location','NorthWest')
        orient landscape;

        figure
        pseries={'AU_NIPA_g','AU_BEA_g'};
        date_types='dec'
        FRED_fix_dates;
        BDP_autoplot
        title('\bf TFP (with Utilization) - Annualized Growth Rates');
        ylabel('Billion (chained 2009 US$)'); 
        legend('NIPA','BEA','Location','NorthWest')
        orient landscape;
    end
    
    %% Plots for Labor Productivity
    for zz=1:1
        % Plotting All investment Figures
        figure
        subplot(2,2,1:2)
        pseries={'Y_L'};
        date_types='all';;
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Labor Productivity');
        ylabel('Output per Hour'); 
        orient landscape;
        
        subplot(2,2,3:4)
        pseries={'devhp_Y_L','devhp_RGDP'};
        date_types='all';;
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Labor Productivity');
        ylabel('Output per Hour (deviations)'); 
        orient landscape;

        figure
        pseries={'x_l_data','devhp_A_fer'};
        date_types='all';;
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Measures x_l');
        ylabel('Output per Hour'); 
        orient landscape;

        figure
        pseries={'x_l_data'};
        date_types='all';;
        FRED_fix_dates;
        BDP_benchautoplot
        title('\bf Measures x_l');
        ylabel('Output per Hour'); 
        orient landscape;

    end
    
    %% Labor Wedge
    for zz=1:1
        figure
        % close all;
        pseries={'LabShareShimer'};
        date_types='dec';
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Shimer Labor-Share');
        ylabel('%'); 
        orient landscape;
        
        figure
        % close all;
        pseries={'LabWedge','FLabWedge'};
        % 'ShimerLabWedge',
        date_types='all';
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Labor Wedge Measurement');
        ylabel('%'); 
        legend('LabWedge','F Lab Wedge');
        orient landscape;
        
        figure
        % close all;
        pseries={'ShimerLabWedge','LabWedge','FLabWedge'};
        date_types='all';
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Labor Wedge Measurement');
        ylabel('%'); 
        legend('Shimer','GHH','F Lab Wedge');
        orient landscape;

        figure
        pseries={'nlNonSalCost'};
        date_types='dec';
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real GDP and Trends');
        ylabel('% Annualized'); 
        legend('Value','Location','NorthWest')
        orient landscape;
    end
    
    %% Plots for Endogenous Liqudity
    for zz=1:1
        figure
        pseries={'I_K_NIPA','hp_I_K_NIPA'};
        date_types='all';;
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Investment Measures');
        ylabel('Billion (chained 2009 US$)'); 
        legend('NIPA','Filtered','Location','NorthWest')
        orient landscape; 

        figure
        pseries={'x_l_data'};
        date_types='all';;
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Investment Measures');
        ylabel('Billion (chained 2009 US$)'); 
        legend('NIPA','Filtered','Location','NorthWest')
        orient landscape; 
        
                
        figure
        pseries={'l_RGDP','RGDP_art','hpart_RGDP','lhp_RGDP'};
        date_types='dec'
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real GDP and Trends');
        ylabel('Log Billion (chained 2009 US$)'); 
        legend('Value','Artificial','HP-Artificial','HP-Filter','Location','NorthWest')        
        orient landscape;
        
        figure
        pseries={'devhpart_RGDP','devhp_RGDP'};
        date_types='dec'
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real GDP and Trends');
        ylabel('Log Billion (chained 2009 US$)'); 
        legend('Bigio Filter','HP-Filter','Location','NorthWest')        
        orient landscape;
        
                
        figure
        pseries={'l_A_fer','A_fer_art','lhp_A_fer',};
        date_types='dec'
        FRED_fix_dates;
        BDP_autoplot
        title('\bf Log - Real GDP and Trends');
        ylabel('Log Billion (chained 2009 US$)'); 
        legend('Value','Artificial','HP-Filter','Linear Trend','Potential Output CBO','Location','NorthWest')        
        orient landscape;
    end
end
 
figure
pseries={'RGDP','RINV','RCONS'};
date_types='dec';
FRED_fix_dates;
BDP_benchautoplot
title('\bf Real GDP, Consumption and Investment (Normalized)','FontSize',16);
ylabel('% Deviation from 2007Q4 Value','FontSize',16); 
legend('Real GDP','Investment','Consumption','Location','NorthWest');
orient landscape;
saveas(gcf,'F_YIC','pdf')

figure
pseries={'RGDP','RCONS','R_DURCO'};
date_types='dec';
FRED_fix_dates;
BDP_benchautoplot
title('\bf Real GDP, Durable Consumption and Total Consumption ');
ylabel('% Deviation from 2007Q4 Value'); 
legend('Real GDP','Consumption','Durable Consumption');
orient landscape;
saveas(gcf,'F_YCDURCO','pdf')

figure
pseries={'RGDP','AU_fer','HOURS'};
date_types='dec';
FRED_fix_dates;
BDP_benchautoplot
title('\bf Real GDP, Durable Consumption and Total Consumption ');
ylabel('% Deviation from 2007Q4 Value'); 
legend('Real GDP','Consumption','Durable Consumption');
orient landscape;
saveas(gcf,'F_YCDURCO','pdf')

% figure
% pseries={'RGDP','UNRATE'};
% date_types='all';;;
% FRED_fix_dates;
% BDP_benchautoplot
% title('\bf Log - Real GDP and Trends');
% ylabel('Log Billion (chained 2009 US$)'); 
% orient landscape;
        
%-------------------------
% Recession Averages + plots
%-------------------------
% Search in Dates, which is the first recession.
RecsInSample  = sum(dates(1)<Recessions(:,1))         ; % Number of Recessions in our Sample
FirstInSample = length(Recessions(:,1))-RecsInSample+1; % First of Recessions in our Sample
% Change FirstInSample if want less...

RecPlotsLength= 16; % First of Recessions in our Sample
comp_list={'RGDP','RINV','RDURINV','RCONS','HOURS','UNRATE','UTIL','A_NIPA','A_BEA','A_fer','AU_fer','ShimerLabWedge','LabWedge','FLabWedge'};
% comp_titlist={'Real GDP','Real Investment','Real Consumption','Total Hours','Unemployment','Utilization','A NIPA','A BEA'};
% comp_list={'RGDP','RINV','RDURINV','RCONS','HOURS','UNRATE','UTIL','A_NIPA','A_BEA','A_fer','AU_fer','ShimerLabWedge','LabWedge','FLabWedge'};
% comp_titlist={'Real GDP','Real Investment','Real Consumption','Total Hours','Unemployment','Utilization','A NIPA','A BEA'};
% comp_list={'RAORD','RAINV','RASHI','RAUO'};
comp_titlist={'Orders','Inventory','Shipments','Unfilled Orders'};

for ii=1:numel(comp_list)
    eval([char(comp_list(ii)) '_comps=[];']);
end

for ii=1:RecsInSample
    RecNum=FirstInSample-1+ii; % Recession we are talking about
    
    % Recession Dates
    ThisRecession = busdate([datenum(Recessions(RecNum,1)), datenum(Recessions(RecNum,2))]);
    [~,Beg_ThisRec]   = min(abs(ThisRecession(1)-dates))                    ;
   
    % Begining and End of GR
    Beg_date=Beg_ThisRec-1             ;
    End_date=Beg_ThisRec+RecPlotsLength;

    % Dates
    pindex=(Beg_date:End_date)     ;
    pdate=1:length(pindex);
    % dates_gr=dates(index_gr)     ;

    pbench=Beg_date;
    for qq=1:numel(comp_list)
        eval(['aux=(' char(comp_list(qq)) '(pindex)/' char(comp_list(qq)) '(pbench)-1)''*100;']); 
        eval([char(comp_list(qq)) '_comps=[' char(comp_list(qq)) '_comps; aux];']); 
    end
    %  Example_RecessionPlot(pdate, Recessions); 
    hold on;
end

% Minimal and Maximal Series and Average
for qq=1:numel(comp_list)
    eval([char(comp_list(qq)) '_MinComp=min(' char(comp_list(qq)) '_comps(1:end-1,:));']);
    eval([char(comp_list(qq)) '_MaxComp=max(' char(comp_list(qq)) '_comps(1:end-1,:));']);
    eval([char(comp_list(qq)) '_MeanComp=nanmean(' char(comp_list(qq)) '_comps(1:end-1,:));']);
end

% No Date
pindex=pdate;
figure 
pseries={'RGDP_MeanComp','RINV_MeanComp','RCONS_MeanComp','HOURS_MeanComp'};
hold on;
for qq=1:numel(pseries)
    eval(['plot(pdate-2,' char(pseries(qq)) '(pindex),''LineWidth'',Width' num2str(qq) ',''Color'',DataColor' num2str(qq) ',''Marker'',Marker' num2str(qq) ',''MarkerSize'',MkS' num2str(qq) ');']) 
end
grid on;
title('\bf Average Recession Path'); xlabel('Quarters Since Beginning')
legend('Output','Investment','Consumption','Hours','Location','NorthWest')
orient landscape;
xlim([pdate(1)-2 pdate(end)-2]); 

% MultiRecession Plots
if 1==1
for qq=1:numel(comp_list)
    figure
    eval(['plot(pdate-2,' char(comp_list(qq)) '_comps(end,:),''LineWidth'',3,''Color'',[0.7 0 0]); hold on;']);
    eval(['plot(pdate-2,' char(comp_list(qq)) '_comps(end,:),''LineWidth'',3,''Color'',''k''); hold on;']);
    eval(['h = area(pdate-2,[' char(comp_list(qq)) '_MinComp; ' char(comp_list(qq)) '_MaxComp-' char(comp_list(qq)) '_MinComp]'');']);
    set(h(1),'FaceColor','None');
    set(h(2),'FaceColor',[.7 0.7 0.7])
    eval(['plot(pdate-2,' char(comp_list(qq)) '_comps,''LineWidth'',1);']);
    eval(['plot(pdate-2,' char(comp_list(qq)) '_comps(end,:),''LineWidth'',3,''Color'',[0.7 0 0]);']);
    eval(['plot(pdate-2,' char(comp_list(qq)) '_MeanComp(end,:),''LineWidth'',3,''Color'',''k''); hold on;']);
    hold off; grid on;
    xlim([pdate(1)-2 pdate(end)-2]);    
    ylabel('% of pre-crisis level)'); xlabel('Periods Since Recession Starts');
    legend('Great Recession Path','Average');
    eval(['title(''\bf' char(comp_list(qq)) ''');']);
    % SaveAs
end
end

%% Table for Key Statistics
display('***********************************');
display('Correlations with HP deviations (NIPA)');
display('***********************************');
display('Contemporaneous TFP Correlation with Output');
display(num2str(corr_A_NIPA(5)));
display('Contemporaneous TFP Correlation with Hours');
display(num2str(corrh_A_NIPA(5)));
display('Contemporaneous TFP Correlation with Investment');
display(num2str(corri_A_NIPA(5)));
display('***********************************');
display('Correlations with HP deviations (BEA)');
display('***********************************');
display('Contemporaneous TFP Correlation with Output');
display([num2str(corr_A_BEA(5))]);
display('Contemporaneous TFP Correlation with Hours');
display([num2str(corrh_A_BEA(5))]);
display('Contemporaneous TFP Correlation with Investment');
display([num2str(corri_A_BEA(5))]);
display('***********************************');
display('Correlations with HP deviations (FERNALD)');
display('***********************************');
display('Contemporaneous TFP Correlation with Output');
display([num2str(corr_AU_fer(5))]);
display('Contemporaneous TFP Correlation with Hours');
display([num2str(corrh_AU_fer(5))]);
display('Contemporaneous TFP Correlation with Investment');
display([num2str(corri_AU_fer(5))]);
display('Contemporaneous TFP Correlation with Durables + Investment');
display([num2str(corrz_AU_fer(5))]);
display('***********************************');
display('Correlations with HP deviations');
display('***********************************');
display('Contemporaneous HOUR Correlation with Output');
display(num2str(corr_HOURS(5)));
display('Contemporaneous INVESTMENT Correlation with Output');
display(num2str(corr_RINV(5)));
display('Contemporaneous Private Non-Residential INVESTMENT Correlation with Output');
display(num2str(corr_RPNRI(5)));
display('Contemporaneous DURABLES+INVESTMENT Correlation with Output');
display(num2str(corr_RDURINV(5)));
display('Contemporaneous Non-DURABLE Consumption with Output');
display(num2str(corr_R_NONDURCO(5)));
display('Contemporaneous Real Consumption');
display(num2str(corr_RCONS(5)));
display('Contemporaneous Labor Productivity Correlation');
display(num2str(corr_Y_L(5)));
display('Contemporaneous TFP Correlation with Output');
display(num2str(corr_A_fer(5)));
display('***********************************');
display('Great Ratios');
display('***********************************');
display(['Investment to Capital: ' num2str(mu_h_I_K_NIPA)]);
display(['Investment to Output: ' num2str(mu_h_I_Y_NIPA)]);
display(['Investment to Output: ' num2str(mu_h_RDURCO_Y+mu_h_I_Y_NIPA)]);
display('***********************************');
display('Relative Volatilities (historical)');
display('***********************************');
display('Hours:     ');
display(num2str(sigma_h_HOURS_Y));
display('Investment:');
display(num2str(sigma_h_RINV_Y));
display('Private Non-Residential Investment:');
display(num2str(sigma_h_RPNRI_Y));
display('Durables +Investment:');
display(num2str(sigma_h_RDURINV_Y));
display('Consumption:');
display(num2str(sigma_h_RCONS_Y));
display('Non-Durco Consumption:');
display(num2str(sigma_h_R_NONDURCO_Y));
display('A NIPA:');
display(num2str(sigma_h_A_NIPA_Y));
display('A FERNALD:');
display(num2str(sigma_h_AU_fer_Y));
display('Labor Productivity:');
display(num2str(sigma_h_Y_L_Y));
display('***********************************');
display('Relative Volatilities (decade)');
display('***********************************');
display('Hours:     ');
display(num2str(sigma_dec_HOURS_Y));
display('Investment:');
display(num2str(sigma_dec_RINV_Y));
display('Private Non-Residential Investment:');
display(num2str(sigma_dec_RPNRI_Y));
display('Durable Consumption + Investment:');
display(num2str(sigma_dec_RDURINV_Y));
display('Consumption:');
display(num2str(sigma_dec_RCONS_Y));
% display('Non-Durco Consumption:');
% display(num2str(sigma_dec_RNONDURCO_Y));
display('A FERNALD:');
display(num2str(sigma_dec_AU_fer_Y));
display('***********************************');
display('Relative Volatilities (expansions)');
display('***********************************');
display('Hours:     ');
display(num2str(sigma_ex_HOURS_Y));
display('Investment:');
display(num2str(sigma_ex_RINV_Y));
display('Private Non-Residential Investment:');
display(num2str(sigma_ex_RPNRI_Y));
display('Durable Consumption + Investment:');
display(num2str(sigma_ex_RDURINV_Y));
display('Consumption:');
display(num2str(sigma_ex_RCONS_Y));
display('***********************************');
display('Relative Volatilities (Recessions)');
display('***********************************');
display('Hours:     ');
display(num2str(sigma_rec_HOURS_Y));
display('Investment:');
display(num2str(sigma_rec_RINV_Y));
display('Private Non-Residential Investment:');
display(num2str(sigma_rec_RPNRI_Y));
display('Durable Consumption + Investment:');
display(num2str(sigma_rec_RDURINV_Y));
display('Consumption:');
display(num2str(sigma_rec_RCONS_Y));

% Key Moments
% ->
%filename='C:\Users\sb3439\Documents\Data\US Data\USData_Moments.txt'  ;                                                                          ;
filename='C:\Users\Saki Bigio\Documents\Data\US Data\USData_Moments.txt';
[fid, message] = fopen(filename,'w+')                                                                                  ;
fprintf(fid,'\n \\begin{tabular}{|l|l|c|c|c|c|c|} \\hline ')                                                        ;
% fprintf(fid,'\n \\cellcolor{blue!10}  & \\cellcolor{blue!10} \\textbf{Short } & \\cellcolor{blue!10} \\textbf{Long }&\\cellcolor{blue!10} \\textbf{All} \\\\ \\hline ');
fprintf(fid,'\n \\cellcolor{blue!5} \\textbf{ Correlation at t} &  \\cellcolor{blue!5} $Y_{t}$ & \\cellcolor{blue!5} $A_{t}$ & \\cellcolor{blue!5} $l_{t}$ & \\cellcolor{blue!5} $c_{t}$ & \\cellcolor{blue!5} $I_{t}$ \\\\ \\hline')               ;
fprintf(fid,'\n $A_{t}$          & %0.3g & 1     & %0.3g  & %0.3g  & %0.3g  \\\\ \\hline',corr_A_fer(5),corrc_A_fer(5),corrh_A_fer(5),corri_A_fer(5))               ;
fprintf(fid,'\n $Y_{t}$          & 1     & %0.3g & %0.3g  & %0.3g  & %0.3g  \\\\ \\hline',corr_A_fer(5),corr_HOURS(5),corr_RCONS(5),corr_RINV(5))               ;
fprintf(fid,'\n \\cellcolor{blue!5} \\textbf{ Relative Volatility } &  \\cellcolor{blue!5} $Y_{t}$ & \\cellcolor{blue!5} $A_{t}$ & \\cellcolor{blue!5} $l_{t}$ & \\cellcolor{blue!5} $c_{t}$ & \\cellcolor{blue!5} $I_{t}$ \\\\ \\hline')               ;
fprintf(fid,'\n & 1 & %0.3g & %0.3g & %0.3g & %0.3g \\\\ \\hline',sigma_h_A_fer_Y,sigma_h_HOURS_Y,sigma_h_RCONS_Y,sigma_h_RINV_Y)               ;
fclose('all');

% fprintf(fid,'\n \\cellcolor{blue!5} \\textbf{Contemporaneous Correlation of } &  \\cellcolor{blue!5}    to Output             & \\cellcolor{blue!5} to Hours & \\cellcolor{blue!5} to Investment \\\\ \\hline')               ;
% 
% fprintf(fid,'\n Investment     & %0.3g & %0.3g & %0.3g \\\\ \\hline',corr_RINV(5),corrh_RINV(5),corri_RINV(5))               ;
% % fprintf(fid,'\n \\cellcolor{blue!10} \\textbf{Relative Volatility } & \\cellcolor{blue!10} \\textbf{Short } & \\cellcolor{blue!10} \\textbf{Long }&\\cellcolor{blue!10} \\textbf{All} \\\\ \\hline ');
% fprintf(fid,'\n \\cellcolor{blue!5} \\textbf{Relative Volatility of} &  \\cellcolor{blue!5}     to Output             & \\cellcolor{blue!5} \\textbf{Ratio of} & \\cellcolor{blue!5} Investment \\\\ \\hline')               ;
% fprintf(fid,'\n Hours      & %0.3g & to Capital       & %0.3g \\\\ \\hline',sigma_h_HOURS_Y,mu_h_I_K_NIPA)               ;
% fprintf(fid,'\n \\cellcolor{blue!5}  Average Loan Size   &  \\cellcolor{blue!5}                  & \\cellcolor{blue!5}                 & \\cellcolor{blue!5} \\\\ \\hline')               ;
% fprintf(fid,'\n All  Risks   & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(16),AuxTab(21),AuxTab(26))               ;
% fprintf(fid,'\n Minimal Risk & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(17),AuxTab(22),AuxTab(27))               ;
% fprintf(fid,'\n Low Risk     & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(18),AuxTab(23),AuxTab(28))               ;
% fprintf(fid,'\n Medium Risk  & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(19),AuxTab(24),AuxTab(29))               ; 
% fprintf(fid,'\n High Risk    & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(20),AuxTab(25),AuxTab(30))               ;
% fprintf(fid,'\n \\cellcolor{blue!5}  Interest Rate      &  \\cellcolor{blue!5}                  & \\cellcolor{blue!5}                  & \\cellcolor{blue!5} \\\\ \\hline')               ;
% fprintf(fid,'\n All  Risks   & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(46),AuxTab(51),AuxTab(56))               ;
% fprintf(fid,'\n Minimal Risk & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(47),AuxTab(52),AuxTab(57))               ;
% fprintf(fid,'\n Low Risk     & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(48),AuxTab(53),AuxTab(58))               ;
% fprintf(fid,'\n Medium Risk  & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(49),AuxTab(54),AuxTab(59))               ; 
% fprintf(fid,'\n High Risk    & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(50),AuxTab(55),AuxTab(60))               ;
% fprintf(fid,'\n \\cellcolor{blue!5}  Average Maturity   &  \\cellcolor{blue!5}                  & \\cellcolor{blue!5}                  & \\cellcolor{blue!5} \\\\ \\hline')               ;
% fprintf(fid,'\n All  Risks   & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(31),AuxTab(36),AuxTab(41))               ;
% fprintf(fid,'\n Minimal Risk & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(32),AuxTab(37),AuxTab(42))               ;
% fprintf(fid,'\n Low Risk     & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(33),AuxTab(38),AuxTab(43))               ;
% fprintf(fid,'\n Medium Risk  & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(34),AuxTab(39),AuxTab(44))               ; 
% fprintf(fid,'\n High Risk    & %0.3g\\%% & %0.3g\\%% & %0.3g\\%% \\\\ \\hline',AuxTab(35),AuxTab(40),AuxTab(45))               ;


% Save Vector of Data to be used in Estimation
M_data=[corr_A_fer(5),corr_HOURS(5),corr_RINV(5),sigma_h_RINV_Y,sigma_h_HOURS_Y,mu_h_I_Y_NIPA,mu_h_I_K_NIPA];
save M_data.mat M_data;
clear M_data;

%% Display Key Statistics...
% DescList={};
% for ii=1:numel(DispList)
%    eval(['disp([char(DescList(ii)) '':& '' num2str(mean(' char(DispList(ii)) '(Beg_GreatRec-1))) '' & '' num2str(mean(' char(RatioList((ii-1)*2+1)) '(index_gr))) '' & '' num2str(mean(' char(RatioList((ii-1)*2+2)) '(Beg_GreatRec-1))) '' & '' num2str(mean(' char(RatioList((ii-1)*2+2)) '(index_gr))) ])']) 
% end

% Write Key-Statistics in Text and LaTeX

%% Discretizing Space
% From Past Versions

% N_grid=24;
% [prob_FoF,eps,z_FoF]=tauchen(N_grid,mu_FoF,rho_FoF,sigma_FoF);
% [prob_NIPA,eps,z_NIPA]=tauchen(N_grid,mu_NIPA,rho_NIPA,sigma_NIPA);
% [prob_OECD,eps,z_OECD]=tauchen(N_grid,mu_OECD,rho_OECD,sigma_OECD);
% z_FoF=exp(z_FoF);
% z_NIPA=exp(z_NIPA);
% z_OECD=exp(z_OECD);
% 
% % Find Closes Point
% N_A=length(A_FoF);
% A_bar_FoF =zeros(N_A,1);
% A_bar_NIPA=zeros(N_A,1);
% A_bar_OECD=zeros(N_A,1);
% Index_FoF =zeros(N_A,1);
% Index_NIPA=zeros(N_A,1);
% Index_OECD=zeros(N_A,1);
% for tt=1:length(A_FoF);
%     [A_bar_FoF(tt) , Index_FoF(tt)] =min(abs(A_FoF(tt)-z_FoF))  ;
%     A_bar_FoF(tt)=z_FoF(Index_FoF(tt));
%     [A_bar_NIPA(tt), Index_NIPA(tt)]=min(abs(A_NIPA(tt)-z_NIPA));
%     A_bar_NIPA(tt)=z_NIPA(Index_NIPA(tt));
%     [A_bar_OECD(tt), Index_OECD(tt)]=min(abs(A_OECD(tt)-z_OECD));
%     A_bar_OECD(tt)=z_OECD(Index_OECD(tt));
% end
% 
% figure
% subplot(3,1,1)
% plot(dates(rango),exp(mu_FoF*(1-rho_FoF)+rho_FoF*log(A_FoF(rango_lag))),'LineWidth',3); hold on;
% plot(dates(rango),A_FoF(rango),'k--','LineWidth',3);
% plot(dates(rango),A_bar_FoF(rango),'g:','LineWidth',3);
% Example_RecessionPlot(dates, Recessions);
% title('\bf Flow of Funds');
% dateaxis('x',12); grid on;
% h=legend('AR(1)','Actual','Discrete Approx','Location','Best');
% set(h,'FontSize',7,'Box','off');
% hold off;
% 
% subplot(3,1,2)
% plot(dates(rango),exp(mu_NIPA*(1-rho_NIPA)+rho_NIPA*log(A_NIPA(rango_lag))),'LineWidth',3); hold on;
% plot(dates(rango),A_NIPA(rango),'k--','LineWidth',3); 
% plot(dates(rango),A_bar_NIPA(rango),'g:','LineWidth',3); 
% Example_RecessionPlot(dates, Recessions);
% title('\bf NIPA');
% dateaxis('x',12); grid on;
% h=legend('AR(1)','Actual','Discrete Approx','Location','Best');
% set(h,'FontSize',7,'Box','off');
% hold off;
% 
% subplot(3,1,3)
% plot(dates(rango),exp(mu_OECD*(1-rho_OECD)+rho_OECD*log(A_OECD(rango_lag))),'LineWidth',3); hold on;
% plot(dates(rango),A_OECD(rango),'k--','LineWidth',3); 
% plot(dates(rango),A_bar_OECD(rango),'g:','LineWidth',3);
% Example_RecessionPlot(dates, Recessions);
% title('\bf OECD');
% dateaxis('x',12); grid on;
% h=legend('AR(1)','Actual','Discrete Approx','Location','Best');
% set(h,'FontSize',7,'Box','off');
% hold off;
% 
% %% Figure close-up
% figure
% plot(dates_gr,A_NIPA(dates_path),'k--','LineWidth',3);
% % plot(dates_gr,A_bar_NIPA(dates_path),'g:','LineWidth',3);
% Example_RecessionPlot(dates_gr, Recessions);
% title('\bf Flow of Funds');
% dateaxis('x',12); grid on;
% h=legend('Actual','Location','Best');
% set(h,'FontSize',7,'Box','off');
% hold off;
% 
% %% Save as financial time sieres
% CapitalMeasures=fints(dates, [K_FoF K_NIPA K_OECD A_FoF A_NIPA A_OECD Q...
%     I_K_FoF I_K_NIPA I_K_OECD...
%     rK_FoF rK_NIPA rK_OECD...
%     rGDP GDP PNFI],...
%     {'K_FoF','K_NIPA','K_OECD','A_FoF','A_NIPA','A_OECD','Q'...
%     'I_K_FoF','I_K_NIPA','I_K_OECD'...
%     'rK_FoF','rK_NIPA','rK_OECD'...
%     'rGDP','GDP','PNFI'});
% CapitalMeasures.desc = 'U.S. Macroeconomic Data';
% CapitalMeasures.freq = 'quarterly';
% 
% % Convert combined time series into date and data arrays		
% save CapitalMeasures.mat CapitalMeasures;
% 
% % Save TFP path
% N_NIPA=N_grid;
% tfp_path=A_NIPA(dates_path);
% Index_NIPA=Index_NIPA(dates_path);
% save TFP_path.mat tfp_path Index_NIPA N_NIPA;
% 
% % TFPlist={'NIPA','NIPA1','BEA','OECD','FoF'};
% % NCTFP=0.01; % Normalizing Constant TFP
% % if AK==1;
% % else
% %     % Compute Growth Rates
% %     for ii=1:numel(TFPlist)
% %         eval(['F_' char(TFPlist(ii)) '=NCTFP*HOURS.^(1-alpha).*K_' char(TFPlist(ii)) '.*alpha;']);
% %         eval(['FU_' char(TFPlist(ii)) '=NCTFP*HOURS.^(1-alpha).*(K_' char(TFPlist(ii)) ').*alpha.*UTIL;']);
% %         eval(['A_' char(TFPlist(ii)) '= GDP./F_' char(TFPlist(ii)) ';']);
% %         eval(['AU_' char(TFPlist(ii)) '= GDP./FU_' char(TFPlist(ii)) ';']);
% % %         eval(['rA_' char(TFPlist(ii)) '= [4*mean(diff(log(A_' char(TFPlist(ii)) '(1:5))))   ; 4*diff(log(A_' char(TFPlist(ii)) '))];' ]);
% % %         eval(['rAU_' char(TFPlist(ii)) '= [4*mean(diff(log(AU_' char(TFPlist(ii)) '(1:5))))   ; 4*diff(log(AU_' char(TFPlist(ii)) '))];' ]);
% %     end
% % end
% % Alist={'A_NIPA','AU_NIPA','A_BEA','AU_BEA'};


% save CapitalMoments.mat I_K_hist I_K_boom I_K_rec I_K_greatrec 
% save CapitalMoments.mat I_Y_hist I_Y_boom I_Y_rec I_Y_greatrec -append
% save Data_RealMoments.mat Occupation BoomDuration RecDuration GreatRecDuration...
%     Elg_y_hist Vlg_y_hist Elg_y_GR Vlg_y_GR... 
%     Elg_phi_hist Powerphi_hist Elg_phi_GR Powerphi_GR...
%     EI_K_hist EI_K_GR EI_Y_hist EI_Y_GR






