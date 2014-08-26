### All packages needed
packages<-c("pwt8","WDI","ggplot2","googleVis",
            "gdata","reshape","reshape2","stringr",
            "quantmod","Quandl","SmarterPoland",
            "directlabels","plyr","extrafont","mFilter",
            "lubridate","foreign","XLConnect","rjson",
            "data.table")

gitcd<-"C:/Users/sv2307/Documents/GitHub/BigioCode/"

### Source functions needed
source(paste(gitcd, "R Programs/RChartFuncs.r", sep=""))

### Quandl API key to download data
Quandl.auth("ncNy7saz6QdDjeBDKAcg")

### Creating series ID vectors
## Paste function to create series ID name from combinations of strings
pastec<-function(x) {paste(x,collapse="")}

# Fed loan data
v<-c("EV","EA","ED","EE")
m<-c("A","S","M")
r<-c("","N","L","M","O")
loanseries<-paste(apply(expand.grid(v,m,r),1,pastec),"NQ",sep="")

# Fed standards for commercial banks
q<-c("DRTS","DRSD")
t<-c("CILM","CIS","PM","CREL")
sloseries<-apply(expand.grid(q,t),1,pastec)

# Yields by rating
bondseries<-c()
bondseries<-c(bondseries,paste("BAMLC0A",c(1:4),"C",c("AAA","AA","A","BBB"),"EY",sep=""))
bondseries<-c(bondseries,paste("BAMLH0A",c(1:3),"HY",c("BB","B","C"),"EY",sep=""))
bondseries<-c(bondseries,"AAA","BAA")

# Data by type of business
bcseries<-c()
bt<-c("NNB","NNCB")
w<-c("TABS","TFAABS","TRABS",
     "TTAABS","IABS","ESABS","REABS",
     "TLBS","TCMILBS","BLNECLBS","MLBS","TPLBS")
bcseries<-apply(expand.grid(w,bt),1,pastec)

bcseries<-c(bcseries,"TXLBSNNB","TXPLBSNNCB","CPLBSNNCB","CBLBSNNCB")

# Commercial paper
cpseries<-c("FINCP","COMPAPER","ABCOMP","CPN1M","CPN2M","CPN3M","CPF1M","CPF2M","CPF3M")

# Real data
realqs<-c("GDPC96","GDPPOT","GPDIC96","PNFIC96","PCECC96","OPHNFB","ULCNFB",
          "PRFIC96","A262RX1A020NBEA","PCNDGC96","PCDGCC96","GCEC96","NETEXC96",
          "EXPGSC96")

table<-c("ADJRESNS","DEMDEPSL","IBLACBM027SBOG")

# Housing data
hprices<-c("SPCS20RSA","USHOWN")
cities<-c("BO","CH","LX","MI","NY","SF","WD")
hprices<-c(hprices,paste(cities,"XRSA",sep=""))

# All data available through Quandl's API
quandlseries<-c(cpseries,realqs,sloseries,table,
          "GDP","FEDFUNDS","DFF","COE","CPIAUCSL","GCE",
          "GDPDEF", "GPDI", "GS10", "HOANBS", "BASE", 
          "M1SL", "M2SL", "MZMSL", "NFINCP", "PCEC", 
          "TB3MS", "EXCRESNS", "UNRATE", "EQTA", "USROE", 
          "CORBLACBS", "USROA", "USNIM", "NPCMCM", "NCOCMC", 
          "TOTLL", "BUSLOANS", "REALLN", "CONSUMER", "LOANS", 
          "LOANINV", "USGSEC", "DRISCFLM", "DRISCFS","DTB3")

# Data in FRED not on Quandl
fredseries<-c(loanseries,bondseries,hprices,bcseries,
              "VIXCLS","DJIA")

# Data in Quandl not from FRED
nonfredseries<-c("BCB/UDJIAD1","UMICH/SOC1","YAHOO/INDEX_GSPC")

# In quandl: cpseries, realqs, sloseries, table
# Not in quandl: loanseries, bondseries, bcseries, VIXCLS, DJIA, SP500

# Downloading data from quandl in xts format
quandlnames<-paste("FRED",quandlseries,sep="/")
tsobj<-Quandl(c(quandlnames,nonfredseries),type='xts')
###NOTE: This should only be run when new variables are added,
###otherwise will wipe out the whole download limit.
# write.csv(do.call("rbind", lapply(as.list(c(quandlnames,nonfredseries)), getDescription)),
#           file="datadict.csv"
# )

# Adding FRED data to quandl data
# for (ser in fredseries) {
#   tsobj<-merge(tsobj,getSymbols(ser,src='FRED',auto.assign=FALSE))
# }
getFred<-function(ser) {
  df<-as.data.frame(getSymbols(ser,src='FRED',auto.assign=FALSE))
  df$date<-as.Date(row.names(df))
  df$variable<-ser
  names(df)[1]<-"value"
  return(df)
}
FRED<-do.call("rbind",lapply(as.list(fredseries), getFred))

# Reformat to data frame
df<-as.data.frame(tsobj)

# Name variables
nonfredseries<-c("DJIA","UMCSENT","O","H","L","SP500","V","AC")
names(df)<-c(quandlseries,nonfredseries)

# Add date variable
df$date<-index(tsobj)

# Reshape data to long
df.l<-subset(melt(df,id="date"),!is.na(value) & !(variable %in% c("O","H","L","V","AC")))
df.l<-rbind(df.l, subset(FRED,!is.na(value)))
rm(list=c("tsobj","FRED")) #Garbage collection


### Get growth rates
Mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}
# Get frequency of data series
freqs<-ddply(df.l, .(variable),summarize,freq=Mode(diff(date)))

## Get difference function
# getDiff<-function(var,num,log=TRUE) {
#   df<-subset(df.l,variable==var)
#   df$variable<-paste(var,".diff",sep="")
#   if (log) {
#     df$value<-c(rep(NA,num),diff(log(df$value),lag=num)*100)
#   }
#   else {
#     df$value<-c(rep(NA,num),diff(df$value,lag=num))
#   }
#   return(df)
# }

getDiff<-function(df,num,log=TRUE) {
  df$variable<-paste(df$variable,"diff",sep=".")
  if (log) {
    df$value<-c(rep(NA,num),diff(log(df$value),lag=num)*100)
  } else {
    df$value<-c(rep(NA,num),diff(df$value,lag=num))
  }
  return(df)
}

funcDiff<-function(df) {
  freq<-round(365/subset(freqs,variable==df$variable[1])$freq)
  return(getDiff(df,freq,TRUE))
}

# Series that we want to get difference for
diffseries<-c("GDP","TOTLL","BUSLOANS","REALLN",
              "CONSUMER","LOANS","LOANINV",
              "USGSEC","GDPDEF",hprices)
# diff.df<-data.frame(date=NULL,variable=NULL,value=NULL)

# Make growth rates and add to data frame
# Growth rate is Y-to-Y rate
# for (ser in diffseries) {
#   freq<-round(365/subset(freqs,variable==ser)$freq)
#   diff.df<-rbind(diff.df,getDiff(ser,freq,TRUE))
# }
# df.l<-rbind(df.l,diff.df)
df.l<-rbind(df.l, ddply(subset(df.l,variable %in% diffseries), .(variable), "funcDiff"))
# rm(diff.df)

### Get difference between rates and base rates
# Get daily and monthly series of 3-month T-bill rate and fed funds rate
ratesd<-dcast(subset(df.l,variable %in% c("DTB3","DFF")),date~variable)
ratesm<-dcast(subset(df.l,variable %in% c("TB3MS","FEDFUNDS")),date~variable)

# Get necessary series (daily and monthly)
toratesd<-bondseries[1:7]
toratesm<-c(bondseries[8:9], "CPN1M","CPN2M","CPN3M","CPF1M","CPF2M","CPF3M")

# Merge series with rates
toratesd.df<-merge(subset(df.l, variable %in% toratesd),ratesd)
toratesm.df<-merge(subset(df.l, variable %in% toratesm),ratesm)

# Create data frame with series substracted from 3-month T-bill rate (monthly)
temp<-data.frame(date=toratesm.df$date, 
                 variable=paste(toratesm.df$variable,".T",sep=""), 
                 value=toratesm.df$value-toratesm.df$TB3MS)

# Same for fed funds rate (monthly)
CPspreads<-subset(toratesm.df,variable %in% c("CPN1M","CPN2M","CPN3M","CPF1M","CPF2M","CPF3M"))
temp<-rbind(temp,
            data.frame(date=CPspreads$date,
                       variable=paste(CPspreads$variable,".F",sep=""),
                       value=CPspreads$value-CPspreads$FEDFUNDS))

# Same for daily 3-month T-bill rate
temp<-rbind(temp,
            data.frame(date=toratesd.df$date,
                       variable=paste(toratesd.df$variable,".T",sep=""),
                       value=toratesd.df$value-toratesd.df$DTB3))
# Add new series to old data frame
df.l<-rbind(df.l,temp)
rm(temp) #Garbage collection

# Sort data frame by variable and date
df.l<-df.l[order(df.l$variable,df.l$date),]

### Survey of loan officers data manipulations (average, total, etc.)
# Create wide data frame from loan data
slo<-dcast(subset(df.l, date>as.Date("1997-01-01") & variable %in% c(loanseries,"GDPDEF")), date~variable)
# Get "weights" of loans in each risk type
slo$Ls<-slo$EVANQ+slo$EVANNQ+slo$EVALNQ+slo$EVAMNQ+slo$EVAONQ
slo.new<-data.frame(date=slo$date,
                    EVANQws=slo$EVANQ/slo$Ls,
                    EVANNQws=slo$EVANNQ/slo$Ls,
                    EVALNQws=slo$EVALNQ/slo$Ls,
                    EVAMNQws=slo$EVAMNQ/slo$Ls,
                    EVAONQws=slo$EVAONQ/slo$Ls)

## Get matrix for data in each prefix 
getSLO<-function(prefix) {
  return(data.matrix(slo[,which(substr(names(slo),1,3)==prefix)]))
}

# Calculate weighted variables
ws.mat<-data.matrix(slo.new[,which(substr(names(slo.new),1,3)=="EVA")])
slo.new$TL_A<-rowSums(getSLO("EVA"))
slo.new$AL_A<-rowSums(getSLO("EAA")*ws.mat)
slo.new$M_A<-rowSums(getSLO("EDA")*ws.mat)
slo.new$R_A<-rowSums(getSLO("EEA")*ws.mat)

slo.new$TL_S<-rowSums(getSLO("EVS"))
slo.new$AL_S<-rowSums(getSLO("EAS")*ws.mat)
slo.new$M_S<-rowSums(getSLO("EDS")*ws.mat)
slo.new$R_S<-rowSums(getSLO("EES")*ws.mat)

slo.new$TL_M<-rowSums(getSLO("EVM"))
slo.new$AL_M<-rowSums(getSLO("EAM")*ws.mat)
slo.new$M_M<-rowSums(getSLO("EDM")*ws.mat)
slo.new$R_M<-rowSums(getSLO("EEM")*ws.mat)

# Add series to original data frame
df.l<-rbind(df.l,melt(slo.new, id="date"))

### Get "real" variables (substract inflation)
v<-c("TL","AL","M","R")
c<-c("_A","_S","_M")
sloseries<-apply(expand.grid(v,c),1,pastec)

slo.l<-subset(melt(slo.new, id="date"),variable %in% sloseries)
DEFL<-data.frame(date=subset(df.l, variable=="GDPDEF")$date,GDPDEF=subset(df.l, variable=="GDPDEF")$value)
slo.l<-merge(slo.l,DEFL)
slo.l.real<-data.frame(date=slo.l$date,variable=paste(slo.l$variable,"R",sep="."),value=slo.l$value/log(slo.l$GDPDEF))

df.l<-rbind(df.l, slo.l.real)

### Get HP-filtered series
## Function gives HP-filtered data frame
## and either gives filtered series or trend,
## and either HP-filters the log or not
getHP<-function(var,log=FALSE,dev=TRUE) {
  df<-subset(slo.l.real,variable==var)
  if (log) {value<-log(df$value); name<-paste(var,".L",sep="")
  } else {value<-df$value; name<-var}
  if (dev) {value<-residuals(hpfilter(df$value,1600)); name<-paste(name,".HPD",sep="")
  } else {value<-fitted(hpfilter(df$value,1600)); name<-paste(name, ".HP",sep="")}
  df$variable<-name
  df$value<-value
  return(df)
}

# Get HP, HP trend, log HP, log HP trend for real SLO variables
hp.df<-data.frame(date=as.Date(character()),variable=numeric(),value=numeric())
sloseries.R<-paste(sloseries,"R",sep=".")
for (ser in sloseries.R) {
  hp.df<-rbind(hp.df,getHP(ser,FALSE,FALSE))
  hp.df<-rbind(hp.df,getHP(ser,FALSE,TRUE))
  hp.df<-rbind(hp.df,getHP(ser,TRUE,FALSE))
  hp.df<-rbind(hp.df,getHP(ser,FALSE,FALSE))
}
# Add to original data frame
df.l<-rbind(df.l,hp.df,melt(slo.new,id="date"),slo.l.real)
rem<-c("CPspreads","DEFL","df","freqs","hp.df","ratesd","ratesm",
       "slo","slo.l","toratesd.df","toratesm.df","ws.mat")
rm(list=rem) # Garbage collection


### Get trends, etc for GDP and loan variables
GDPvars<-c("GDPC96","PNFIC96","PCECC96","ULCNFB","HOANBS","GDPPOT","COE",
           "GDP","GDPDEF")
LOANvars<-c("TOTLL","BUSLOANS","REALLN","CONSUMER")

LOAN.df<-subset(df.l,variable %in% LOANvars)
LOAN.df$date<-as.Date(ISOdate(year(LOAN.df$date),ceiling(month(LOAN.df$date)/3)*3-2,1))
LOAN.df<-ddply(LOAN.df,.(date,variable),summarize,variable=variable[1],value=sum(value))

GDP.df<-subset(df.l,variable %in% GDPvars)
GDP.df<-rbind(GDP.df,LOAN.df)
GDP.dfw<-dcast(GDP.df,date~variable)

beg_date<-as.Date("2007-12-15")
beg_index<-min(which(GDP.dfw$date>as.Date(beg_date)))-2

GDP.dfw$Y_L<-GDP.dfw$GDPC96/GDP.dfw$HOANBS

GDP.dfw$GDP.PATHG<-GDP.dfw$GDPC96/GDP.dfw$GDPC96[beg_index]
GDP.dfw$GDP.POTG<-c(NA,exp(diff(log(GDP.dfw$GDPPOT),lag=1)))
GDP.dfw$GDP.RPATH<-GDP.dfw$GDP.PATHG-GDP.dfw$GDP.POTG

GDP.dfw$INV.RPATHG<-GDP.dfw$PNFIC96/GDP.dfw$PNFIC96[beg_index]
GDP.dfw$INV.RPATH<-GDP.dfw$INV.RPATHG-GDP.dfw$GDP.POTG

GDP.dfw$CONS.RPATHG<-GDP.dfw$PCECC96/GDP.dfw$PCECC96[beg_index]
GDP.dfw$CONS.RPATH<-GDP.dfw$CONS.RPATHG-GDP.dfw$GDP.POTG

GDP.dfw$HOURS.PATHG<-GDP.dfw$HOANBS/GDP.dfw$HOANBS[beg_index]
GDP.dfw$HOURS.RPATH<-GDP.dfw$HOURS.PATHG-1

GDP.dfw$WAGES.RPATHG<-log(GDP.dfw$COE)/log(GDP.dfw$COE[beg_index])
GDP.dfw$WAGES.RPATH<-GDP.dfw$WAGES.RPATHG-GDP.dfw$GDP.POTG

GDP.dfw$MPL.PATH<-GDP.dfw$Y_L/GDP.dfw$Y_[beg_index]

GDP.G<-mean(c(diff(log(GDP.dfw$GDP),lag=1)[1:4],diff(log(GDP.dfw$GDP),lag=1)[1:beg_index-1]),na.rm=TRUE)
DEF.G<-mean(c(diff(log(GDP.dfw$GDPDEF),lag=1)[1:4],diff(log(GDP.dfw$GDPDEF),lag=1)[1:beg_index-1]),na.rm=TRUE)
LOANS.G<-mean(c(diff(log(GDP.dfw$TOTLL),lag=1)[1:4],diff(log(GDP.dfw$TOTLL),lag=1)[1:beg_index-1]),na.rm=TRUE)
TREND.G<-GDP.G-DEF.G

GDP.dfw$DEF.PATH<-log(GDP.dfw$GDPDEF)-log(GDP.dfw$GDPDEF[beg_index])
TREND.G<-LOANS.G-DEF.G
GDP.dfw$TREND<-TREND.G

GDP.dfw$TOTLL.PATH<-log(GDP.dfw$TOTLL)-log(GDP.dfw$TOTLL[beg_index])-GDP.dfw$DEF.PATH
GDP.dfw$TOTLL.RPATH<-GDP.dfw$TOTLL.PATH-TREND.G

GDP.dfw$BUSLOANS.PATH<-log(GDP.dfw$BUSLOANS)/log(GDP.dfw$BUSLOANS[beg_index])-GDP.dfw$DEF.PATH
GDP.dfw$BUSLOANS.RPATH<-GDP.dfw$BUSLOANS.PATH-TREND.G

GDP.dfw$REALLN.PATH<-log(GDP.dfw$REALLN)-log(GDP.dfw$REALLN[beg_index])-GDP.dfw$DEF.PATH
GDP.dfw$REALLN.RPATH<-GDP.dfw$REALLN.PATH-TREND.G

GDP.dfw$CONSUMER.PATH<-log(GDP.dfw$CONSUMER)-log(GDP.dfw$CONSUMER[beg_index])-GDP.dfw$DEF.PATH
GDP.dfw$CONSUMER.RPATH<-GDP.dfw$CONSUMER.PATH-TREND.G

GDP.dfw$GDP.GRPATH<-c(GDP.dfw$GDP[1:beg_index], GDP.dfw$GDP[beg_index]*((TREND.G+1)^(c(1:(length(GDP.dfw$GDP)-beg_index)))))

# Add to old data frame
df.l<-rbind(df.l,melt(GDP.dfw,id="date"))
rem<-c("GDP.df","GDP.dfw","LOAN.df","slo.l.real","slo.new")
rm(list=rem) # Garbage collection

# Get rid of duplicates, sort data frame, keep only non-NA values
df.l<-df.l[!duplicated(df.l[c("variable", "date")]),]
df.l<-df.l[order(df.l$variable,df.l$date),]
df.l<-subset(df.l,!is.na(value))

###Flow of Funds data
#tryout<-getFoF("5863a0f30b6d35c053f2a42ab530b01f","test")
#FoF<-getFoF("5863a0f30b6d35c053f2a42ab530b01f", getNames(descs))
#tryout<-getFoF("500f8a4da83023b3c2e738041a43949e","test")
#FoFtemp<-getFoF("500f8a4da83023b3c2e738041a43949e",getNames(descs))
FoF<-getFoF("5863a0f30b6d35c053f2a42ab530b01f")
FoFtemp<-getFoF("500f8a4da83023b3c2e738041a43949e")

FoF<-rbind(FoF,FoFtemp)
rm(list=c("FoFtemp"))

FoF<-FoF[!duplicated(subset(FoF, select=c(date,variable,value))),]
FoF<-FoF[order(FoF$id,FoF$date),]
FoF$d<-duplicated(subset(FoF, select=c(date,variable))) & as.character(FoF$variable)!="NA"
FoF.dup<-subset(FoF,d)
FoF.dup$variable<-paste(FoF.dup$variable,substring(FoF.dup$id,10,11),sep="")
FoF<-subset(rbind(subset(FoF,!d),FoF.dup),select=-c(d))
rm(list=c("FoF.dup"))

###Add data from spreadsheet
# 1. Import using one of these
xls.df<-readWorksheetFromFile("C:/Users/sv2307/Downloads/Ejemplo.xlsx", sheet=1)
# csv.df<-read.csv("C:/Users/sv2307/Documents/test.csv")

# 2. create date variable from existing variables (as day)
# qtr2Month<-function(x) {return(x*3-2)}
# xls.df$date<-as.Date(ISOdate(xls.df$year,qtr2Month(xls.df$quarter),1))
xls.df$date<-as.Date(xls.df$Mnemonic)
xls.df$date<-as.Date(ISOdate(year(xls.df$date),month(xls.df$date)-2,1))

# 3. Clean up
xls.df$GGDPCVGDPF[xls.df$GGDPCVGDPF=="NA"]<-NA
xls.df$GGDPCVGDPF<-as.numeric(xls.df$GGDPCVGDPF)

# 4. Reshape to long (throwing away year and quarter variables)
xls.df.l<-subset(melt(subset(xls.df, select=-c(Mnemonic)),id="date"), !is.na(value))

# 5. Merge with full dataset
# df.l<-rbind(xls.df.l,df.l)

# 6. Garbage collecting
rm(list=c("xls.df","xls.df.l"))

# FoF
FoF.w<-dcast(subset(FoF, variable!="NA", select=-c(id)), date~variable)
FoF.w$TNFABHC<-FoF.w$LNANFRESBHC+FoF.w$LNONFRESABHC
FoF.w$FTNFABHC<-FoF.w$UNONFRESABHC+FoF.w$UNANFRESBHC

FoF.w$TOTBHC<-FoF.w$LTFABHC+FoF.w$TNFABHC
FoF.w$FTOTBHC<-FoF.w$UTFABHC+FoF.w$FTNFABHC
FoF.w$EQUITYBHC<-FoF.w$TOTBHC-FoF.w$LTOTLBHC
FoF.w$PROFSBHC<-FoF.w$FTOTBHC-FoF.w$UTOTLBHC
FoF.w$DIVSBHC<-FoF.w$PROFSBHC-FoF.w$UREBHC
FoF.w$E_DBHC<-FoF.w$UEQUITYBHC-FoF.w$DIVSBHC
FoF.w$DBHC<-(FoF.w$DIVSBHC-FoF.w$UEQUITYBHC)*(FoF.w$DIVSBHC>=FoF.w$UEQUITYBHC)
FoF.w$EBHC<-(FoF.w$DIVSBHC-FoF.w$UEQUITYBHC)*(FoF.w$DIVSBHC<=FoF.w$UEQUITYBHC)
FoF.w$DSEQBHC<-FoF.w$E_DBHC/FoF.w$UEQCAPBHC
FoF.w$PSEQBHC<-FoF.w$PROFSBHC/FoF.w$UEQCAPBHC
FoF.w$ESEQBHC<-FoF.w$EBHC/FoF.w$UEQCAPBHC
FoF.w$E_DSEQBHC<-FoF.w$E_DBHC/FoF.w$UEQCAPBHC
FoF.w$MISCBHC<-FoF.w$LTMBHC-FoF.w$LEQTMBHC

FoF.w$TOTCB<-FoF.w$LTFACB-FoF.w$LTMCB
FoF.w$PROFSCB<-FoF.w$UTFACB-FoF.w$UTOTLCB
FoF.w$DCB<-(FoF.w$PROFSCB-FoF.w$UEQUITYCB)*(FoF.w$PROFSCB>=FoF.w$UEQUITYCB)
FoF.w$ECB<-(FoF.w$PROFSCB-FoF.w$UEQUITYCB)*(FoF.w$PROFSCB<=FoF.w$UEQUITYCB)
FoF.w$DSEQBHC<-FoF.w$DCB/FoF.w$LEQUITYCB
FoF.w$PSEQBHC<-FoF.w$PROFSBHC/FoF.w$LEQUITYCB
FoF.w$ESEQBHC<-FoF.w$ECB/FoF.w$LEQUITYCB

FoF.w$BRNCORP<-(FoF.w$LLNECNCORP+FoF.w$LTOTMNCORP)/FoF.w$LTOTLNCORP
FoF.w$BRCORP<-(FoF.w$LLNECCORP+FoF.w$LTOTMCORP)/FoF.w$LTOTLCORP
FoF.w$BRHH<-(FoF.w$LLNECHH+FoF.w$LTOTMHH)/FoF.w$LTOTLHH

FoF.w$MRNCORP<-FoF.w$LTOTMNCORP/FoF.w$LTOTLNCORP
FoF.w$MRCORP<-FoF.w$LTOTMCORP/FoF.w$LTOTLCORP
FoF.w$MRHH<-FoF.w$LTOTMHH/FoF.w$LTOTLHH

FoF.w$CIRNCORP<-FoF.w$LCMILNCORP/FoF.w$LTOTLNCORP
FoF.w$CIRCORP<-FoF.w$LCMILCORP/FoF.w$LTOTLCORP
FoF.w$CIRHH<-FoF.w$LCMILHH/FoF.w$LTOTLHH

FoF.w$BNDRCORP<-FoF.w$LCORSECLCORP/FoF.w$LCMILCORP
FoF.w$CPRCORP<-FoF.w$LOMPLCORP/FoF.w$LCMILCORP

FoF.w$EFNCORP<-FoF.w$LCMILNCORP+FoF.w$LNWNCORP
FoF.w$EFCORP<-FoF.w$LCMILCORP+FoF.w$LNWMVCORP
FoF.w$EFHH<-FoF.w$LCMILHH+FoF.w$LNWMVHH
FoF.w$EFF<-FoF.w$EFNCORP+FoF.w$EFCORP
FoF.w$EFT<-FoF.w$EFF+FoF.w$EFHH
FoF.w$EFCSTCORP<-FoF.w$LCMILCORP+FoF.w$LNWHCCORP
FoF.w$EFCSTF<-FoF.w$EFNCORP+FoF.w$EFCSTCORP

FoF.w$NEFNCORP<-FoF.w$EFNCORP-FoF.w$LTFANCORP
FoF.w$NEFCORP<-FoF.w$EFCORP-FoF.w$LTFACORP
FoF.w$NEFHH<-FoF.w$EFHH-FoF.w$LTFAHH
FoF.w$NEFF<-FoF.w$NEFNCORP+FoF.w$NEFCORP
FoF.w$NEFT<-FoF.w$NEFF+FoF.w$NEFHH

FoF.w$LANCORP<-FoF.w$LGSNCORP+FoF.w$LTSDNCORP+FoF.w$LMMFNCORP+FoF.w$LCDNCORP
FoF.w$LACORP<-FoF.w$LGSCORP+FoF.w$LTSDCORP+FoF.w$LMMFCORP+FoF.w$LCDCORP
FoF.w$LAHH<-FoF.w$LTSDHH+FoF.w$LMMFHH+FoF.w$LCDHH
FoF.w$LAF<-FoF.w$LANCORP+FoF.w$LACORP

# FoF<-melt(FoF.w,id="date")
df.l<-rbind(df.l, melt(FoF.w,id="date"))
rm(list=c("FoF.w","FoF"))

vars<-c("EFNCORP","EFCORP","EFCSTCORP","EFHH",
        "EFF","EFT","NEFNCORP","NEFCORP","NEFHH","NEFF","NEFT")
FoF.subset<-subset(df.l,variable %in% vars)

GDPDEF<-subset(df.l,variable=="GDPDEF",select=c(date,value))
names(GDPDEF)<-c("date","GDPDEF")
FoF.def<-merge(FoF.subset,GDPDEF)
FoF.def$value<-FoF.def$value/FoF.def$GDPDEF
FoF.def$variable<-paste(FoF.def$variable,"R",sep=".")
df.l<-rbind(df.l,subset(FoF.def, select=c(date,variable,value)))
rm(list=c("GDPDEF","FoF.def","FoF.subset"))

funcDiff<-function(df) {
  return(getDiff(df,4,TRUE))
}

df.l<-rbind(df.l, ddply(subset(df.l, variable %in% c(paste(vars,"R",sep="."),
                                                     realqs,bcseries)) , .(variable), "funcDiff"))

LGDPDEF<-subset(df.l, variable=="GDPDEF.diff",select=c(date,value))
names(LGDPDEF)<-c("date","LGDPDEF")
FoF.subset<-merge(subset(df.l, variable %in% paste(bcseries,"diff",sep=".")), LGDPDEF)
FoF.subset$value<-FoF.subset$value-FoF.subset$LGDPDEF
FoF.subset$variable<-paste(FoF.subset$variable,"R",sep=".")
df.l<-rbind(df.l, subset(FoF.subset, select=-c(LGDPDEF)))
rm(list=c("LGDPDEF","FoF.subset"))

vars<-paste(vars,"R",sep=".")
scale<-100
FoF.subset<-subset(df.l, variable %in% vars)
Ys<-dcast(subset(df.l, variable %in% c("GDPC96","GPDIC96")),date~variable)
FoF.subset<-merge(FoF.subset, Ys)
FoF.subset$GDPC96<-FoF.subset$value/FoF.subset$GDPC96*scale
FoF.subset$GPDIC96<-FoF.subset$value/FoF.subset$GPDIC96*scale
FoF.subset<-subset(FoF.subset, select=-c(value))
names(FoF.subset)<-c("date","var","Y","I")
FoF.subset<-melt(FoF.subset, id=c("date","var"))
FoF.subset$variable<-paste(FoF.subset$var,FoF.subset$variable,sep=".")
FoF.subset<-subset(FoF.subset, select=-c(var))
df.l<-rbind(df.l, FoF.subset)
rm(list=c("FoF.subset","Ys"))

# df.l<-rbind(df.l,FoF)
# rm(list=c("FoF","FoF.w"))
df.l<-df.l[!duplicated(df.l[c("variable", "date")]),]

df.l<-rbind(df.l, data.frame(date=subset(df.l, variable=="NEFNCORP.R.Y")$date,
                             variable="NEF.R.Y",
                             value=subset(df.l, variable == "NEFNCORP.R.Y")$value+
                               subset(df.l, variable=="NEFCORP.R.Y")$value))



