gitcd<-"C:/Users/sv2307/Documents/GitHub/BigioCode/"
outputcd<-"C:/Users/sv2307/Dropbox/Crisis_Slides (1)/"

source(paste(gitcd, "R Programs/SakiDataFRED.r", sep=""))

### Plots
pct<- function(x) {return(x*100)}
st_date<-2007
p1<-plotrecessions("GDP.RPATH","Output","Percent",datelimits(st_date),FUNC=pct)
p2<-plotrecessions("CONS.RPATH","Consumption","Percent",datelimits(st_date),FUNC=pct)
p3<-plotrecessions("INV.RPATH","Investment","Percent",datelimits(st_date),FUNC=pct)
p4<-plotrecessions("HOURS.RPATH","Hours","Percent",datelimits(st_date),FUNC=pct)
p5<-plotrecessions("MPL.PATH","Marginal Product of Labor","Percent",datelimits(st_date),FUNC=pct)
pdf(file=paste(outputcd, "R_realside_tit.pdf"), width=10,height=7)
multiplot(p1,p2,p3,p4,p5,layout=matrix(c(1,1,2,3,4,5),nrow=3,byrow=TRUE), title="Deviation from Historical Growth Rates")
dev.off()

plotrecessions("GPDI","Investment","US$ Billions",datelimits(2008))
p<-plotrecessions(c("GDP.GRPATH","GDP"),"Log GDP and Path","Log Output",datelimits(2000),labs=c("Pre-GR Path","Realized path"),FUNC=log)+
  theme(legend.position="none")
ggsave(filename=paste(outputcd,"R_output.pdf"),p, width=7,height=5)

dt<-2000
p1<-plotrecessions("USROE","Return on Equity","Percent",datelimits(dt))
p2<-plotrecessions("USROA","Return on Assets","Percent",datelimits(dt))
p3<-plotrecessions("EQTA","Equity to Assets","Percent",datelimits(dt))
p4<-plotrecessions("USNIM","Net Interst Margin","Percent",datelimits(dt))
p5<-plotrecessions("NPCMCM","Non Performing Commercial Loans","Percent",datelimits(dt))
p6<-plotrecessions("NCOCMC","Commercial Loans Right-Offs","Percent",datelimits(dt))
multiplot(p1,p2,p3,p4,p5,p6,layout=matrix(c(1,2,3,4,5,6),nrow=3,byrow=TRUE), title="Key Banking Indicators")

p<-plotrecessions(c("FEDFUNDS","TB3MS","GS10"), "Treasury Bill Rates", "Percent", 
               datelimits(2001), 
               labs=c("Fed Funds Rate","3 Month T-Bill Rate","10 Year Treasury Rate"))+
  place_legend(.8,.8)
ggsave(filename=paste(outputcd,"R_rates.pdf"),p,width=7,height=5)

dt<-2000
p1<-plotrecessions("SPCS20RSA","Case-Shiller Price Index","",datelimits(dt))
citylabels<-c("Boston","Chicago","Los Angeles","Miami","New York","San Francisco","Washington, D.C.")
p2<-plotrecessions(paste(hprices[3:9],"diff",sep="."),"Growth of Home Prices","12-Month % Change ",datelimits(dt),labs=citylabels,FUNC=function(x) {return(x*12)})+
  theme(legend.position=c(.2,.25), legend.key.size=unit(0.4,"cm"))
p3<-plotrecessions("USHOWN","US Home Ownership","Percent",datelimits(dt))

pdf(file=paste(outputcd, "R_housing.pdf"), width=10,height=7)
multiplot(p1,p2,p3,layout=matrix(c(1,1,2,3), nrow=2, byrow=TRUE))
dev.off()

dt<-1999
p1<-plotrecessions("DJIA","Dow Jones Industrial Average","Index",datelimits(dt))
p2<-plotrecessions("SP500","Standard & Poor's 500","Index",datelimits(dt))
pdf(file=paste(outputcd, "R_stocks.pdf"), width=10,height=7)
multiplot(p1,p2,layout=matrix(c(1,2), nrow=2, byrow=TRUE))
dev.off()

l.df<-data.frame(variable=loanseries)
l.df$plot<-rep(c(1:12),5)
x<-split(l.df$variable,l.df$plot)
fun<-function(x) {return(plotrecessions(as.character(x),"","",datelimits(2000))+theme(legend.position="none"))}
graphslist<-lapply(x,fun)

graphslist[[1]]<-graphslist[[1]]+ggtitle("All Maturities")
graphslist[[5]]<-graphslist[[5]]+ggtitle("Short Maturities (1-30 days)")
graphslist[[9]]<-graphslist[[9]]+ggtitle("Long Maturities (31-365 days)")

graphslist[[1]]<-graphslist[[1]]+ylab("Total Amount Loan")
graphslist[[2]]<-graphslist[[2]]+ylab("Average Loan Size")
graphslist[[3]]<-graphslist[[3]]+ylab("Average Maturity in Days")
graphslist[[4]]<-graphslist[[4]]+ylab("Average Rate")

graphslist[[8]]<-graphslist[[8]]+
  theme(legend.position=c(0.8,0.7), legend.key.size=unit(0.4,"cm"), legend.title=element_text(face="bold"))+
  scale_colour_discrete(labels=c("All","Minimal","Low","Medium","High"), name="Risk Type")

pdf(file=paste(outputcd, "R_SLO.pdf"), width=15,height=12)
multiplot(plotlist=graphslist, layout=matrix(c(1:12), nrow=4, byrow=FALSE),title="Survey of Loans Officials")
dev.off()

p1<-plotrecessions("TL_A","Total Loans","US$ Millions",datelimits(2000))
p2<-plotrecessions("AL_S","Average Size","US$ Millions",datelimits(2000))
p3<-plotrecessions("R_S","Average Rates","Percent",datelimits(2000))
multiplot(p1,p2,p3,layout=matrix(c(1,1,2,3), nrow=2, byrow=TRUE), title="Survey Loan Officials")

dt<-1999
p1<-plotrecessions(c("BAMLC0A1CAAAEY.T","BAMLC0A2CAAEY.T","BAMLC0A3CAEY.T","BAMLC0A4CBBBEY.T"),
                   "Corporate Bond Spreads (Merrill Lynch BofA)","Percent",datelimits(dt),labs=c("AAA","AA","A","BBB"))
p2<-plotrecessions(c("BAMLH0A1HYBBEY.T","BAMLH0A2HYBEY.T","BAMLH0A3HYCEY.T"),
                   "High Yield Spreads (Merrill Lynch BofA)","Percent",datelimits(dt),labs=c("BB","B","C"))
p3<-plotrecessions(c("AAA.T","BAA.T"), "High Yield Spreads (Moody's)","Percent",datelimits(dt),labs=c("AAA","BA"))
pdf(file=paste(outputcd, "R_bonds.pdf"), width=10,height=7)
multiplot(p1,p2,p3,layout=matrix(c(1,2,3), nrow=3, byrow=TRUE), title="Corporate Bond Spreads")
dev.off()

p1<-plotrecessions("USROE","Return on Equity","Percent",datelimits(dt))
p2<-plotrecessions("USROA","Return on Assets","Percent",datelimits(dt))
p3<-plotrecessions("EQTA","Equity to Assets","Percent",datelimits(dt))
p4<-plotrecessions("USNIM","Net Interest Margin","Percent",datelimits(dt))
p5<-plotrecessions("NPCMCM","Non Performing Commercial Loans","Percent",datelimits(dt))
p6<-plotrecessions("NCOCMC","Commercial Loans Write-Offs","Percent",datelimits(dt))
multiplot(p1,p2,p3,p4,p5,p6,layout=matrix(c(1:6), nrow=3, byrow=TRUE), title="Key Banking Indicators")

dt<-2000
p1<-plotrecessions(c("ABCOMP","FINCP"),"Outstanding Commercial Paper","US$ Billions",datelimits(dt),labs=c("Asset Backed","Financial"))+place_legend(.8,.8)
p2<-plotrecessions("COMPAPER","Outstanding Non-Financial Non-ABS CP","US$ Billions",datelimits(dt))
p3<-plotrecessions(c("CPN1M.T","CPN2M.T","CPN3M.T"),"Spreads of Non-Financial Non-ABS CP","Percent",datelimits(dt),labs=c("1 Month","2 Months","3 Months"))+place_legend(.3,.7)
p4<-plotrecessions(c("CPF1M.T","CPF2M.T","CPF3M.T"), "Spreads of Financial CP","Percent",datelimits(dt),labs=c("1 Month","2 Month","3 Month"))+place_legend(.3,.7)
multiplot(p1,p2,p3,p4,layout=matrix(c(1:4), nrow=2, byrow=TRUE), title="Commercial paper")

dt<-1998
plotrecessions(c("LTFAMMMF","LFEDMMMF","LOMPMMMF","LCMIMMMF","LGESSECMMMF"),
               "Financial Assets Money Market Funds",
               "US$ Billions",
               datelimits(dt),
               labs=c("Total Assets","Fed Funds","Open Market Paper","Credit Instruments","GSE Securities"))+
  place_legend(.4,.8)

dt<-"2000-01-01"
ggplot(subset(df.l, date>as.Date(dt) & variable %in% c("BLNECLBSNNB","MLBSNNB","TCMILBSNNB","TPLBSNNB","TXLBSNNB")))+ 
  geom_area(aes(x=date, y=value, fill=variable), position="stack")+
  geom_rect(data=subset(recessions.df, Peak>=as.Date(dt)), aes(xmin=Peak, xmax=Trough, ymin=-Inf, ymax=+Inf), alpha=0.3)+
  graphstheme+
  scale_fill_discrete(labels=c("Loans N.E.C.","Commercial Mortgages","Credit Market Liabilities","Trade Payables","Tax Payables"))+
  theme(legend.title=element_blank())+
  place_legend(.3,.8)+
  ylab("US$ Billions")+
  ggtitle("Liabilities of Non-Corporate Sector")

recPath("UNRATE","Unemployment Rate",48)
recPath("GDPC96","Real GDP",16)

################################################################# Fed_SyS plots
dt<-1974
plotrecessions(c("LTFAMMMF","LFEDMMMF","LOMPMMMF","LCMIMMMF","LGESSECMMMF"),
               "Financial Assets Money Market Funds","US$ Billions",
               datelimits(dt),
               labs=c("Total Assets","Fed Funds","Open Market Paper",
                      "Credit Instruments","GSE Securities"))+
  place_legend(.2,.6)

p1<-plotrecessions(c("TOTBHC","LTOTLBHC"),
                   "Bank Holding Companies",
                   "US$ Billions",
                   datelimits(dt),
                   labs=c("Total Assets","Total Liabilities"))+
  place_legend(.2,.6)
p2<-plotrecessions(c("DSEQBHC","PSEQBHC","ESEQBHC"),
                   "Equity and Dividends",
                   "US$ Billions",
                   datelimits(dt),
                   labs=c("Dividends","Profits","Injections"))+
  place_legend(.2,.2)
p3<-ggplot(subset(df.l, date>as.Date(dt) & variable %in% c("LEQTMBHC","LGSBHC","LCMIBHC","MISCBHC","TNFABHC")))+ 
  geom_area(aes(x=date, y=value, fill=variable), position="stack")+
  geom_rect(data=subset(recessions.df, Peak>=as.Date(dt)), aes(xmin=Peak, xmax=Trough, ymin=-Inf, ymax=+Inf), alpha=0.3)+
  graphstheme+
  scale_fill_discrete(labels=c("Subsidiary Equity","Gov Secs","Credit Market","Misc","Physical"))+
  theme(legend.title=element_blank())+
  ylab("US$ Billions")+
  ggtitle("Bank Holding Companies- Asset Composition")+
  place_legend(.2,.6)
p4<-ggplot(subset(df.l, date>as.Date(dt) & variable %in% c("LUMLBHC","LCMILBHC")))+ 
  geom_area(aes(x=date, y=value, fill=variable), position="stack")+
  geom_rect(data=subset(recessions.df, Peak>=as.Date(dt)), aes(xmin=Peak, xmax=Trough, ymin=-Inf, ymax=+Inf), alpha=0.3)+
  graphstheme+
  scale_fill_discrete(labels=c("Miscellaneous Assets","Credit Market Instruments"))+
  theme(legend.title=element_blank())+
  ylab("US$ Billions")+
  ggtitle("Bank Holding Companies- Asset Composition")+
  place_legend(.2,.6)
multiplot(p1,p2,p3,p4,layout=matrix(c(1:4), nrow=2, byrow=TRUE))

p1<-plotrecessions(c("TOTCB","LTOTLCB"),
                   "Commercial Banks",
                   "US$ Thousand",
                   datelimits(dt),
                   labs=c("Total Assets","Total Liabilities"))+
  place_legend(.2,.6)
p2<-plotrecessions(c("LNECLOANSCB","LTMLOANSCB","LSECDUECB"),
                   "Loans Composition",
                   "US$ Thousand",
                   datelimits(dt),
                   labs=c("Loans N.E.C.","Mortgages","Security Loans"))+
  place_legend(.2,.6)
p3<-ggplot(subset(df.l, date>as.Date(dt) & variable %in% c("LTSCB","LGESSECCB","LMUNSECCB","LCORSECCB")))+ 
  geom_area(aes(x=date, y=value, fill=variable), position="stack")+
  geom_rect(data=subset(recessions.df, Peak>=as.Date(dt)), aes(xmin=Peak, xmax=Trough, ymin=-Inf, ymax=+Inf), alpha=0.3)+
  graphstheme+
  scale_fill_discrete(labels=c("Treasuries","GSE-ABS","Munis","Corporate"))+
  theme(legend.title=element_blank())+
  ylab("US$ Thousand")+
  ggtitle("Commercial Banks- Security Composition")+
  place_legend(.2,.6)
p4<-ggplot(subset(df.l, date>as.Date(dt) & variable %in% c("LTSDEPCB","LCMILCB","LFEDFUNDCB","LUMLCB","LNILCB")))+ 
  geom_area(aes(x=date, y=value, fill=variable), position="stack")+
  geom_rect(data=subset(recessions.df, Peak>=as.Date(dt)), aes(xmin=Peak, xmax=Trough, ymin=-Inf, ymax=+Inf), alpha=0.3)+
  graphstheme+
  scale_fill_discrete(labels=c("Saving Deposits","Credit Inst.","FedFunds","Unclassified Liability","Net Interbank"))+
  theme(legend.title=element_blank())+
  ylab("US$ Thousand")+
  ggtitle("Commercial Banks- Liability Composition")+
  place_legend(.2,.6)
multiplot(p1,p2,p3,p4,layout=matrix(c(1:4), nrow=2, byrow=TRUE))

plotrecessions(c("DSEQBHC","PSEQBHC","ESEQBHC"),
               "Equity and Dividends",
               "US$ Thousands",
               datelimits(dt),
               labs=c("Dividends","Profits","Injections"))

ggplot(subset(df.l, date>as.Date(dt) & variable %in% c("LTSABS","","LCLNFCBABS","LTRABS","LCLABS")))+ 
  geom_area(aes(x=date, y=value, fill=variable), position="stack")+
  geom_rect(data=subset(recessions.df, Peak>=as.Date(dt)), aes(xmin=Peak, xmax=Trough, ymin=-Inf, ymax=+Inf), alpha=0.3)+
  graphstheme+
  scale_fill_discrete(labels=c("Government Sec.","Home Equity Loans","Syndicated Loans","Trade Receivables","Consumer Leases"))+
  theme(legend.title=element_blank())+
  ylab("US$ Thousand")+
  ggtitle("Asset-Backed Security Issuers- Assets")+
  place_legend(.3,.65)

p1<-plotrecessions(c("ABCOMP","FINCP"),"Outstanding ABCP","US$ Billion",datelimits(2007),
                   labs=c("Asset-Backed","Financial"))+place_legend(.8,.8)
p2<-plotrecessions("COMPAPER","Outstanding Non-Financial Non-AB CP","US$ Billion", datelimits(2007))
p3<-plotrecessions(c("CPF1M.F","CPF2M.F","CPF3M.F"),"Spreads of Financial CP","Percent",datelimits(2007),
                   labs=c("1-month","2-month","3-month"))+place_legend(.8,.8)
p4<-plotrecessions(c("CPN1M.F","CPN2M.F","CPN3M.F"),"Spreads of Non-Financial Non-ABS CP", "Percent", datelimits(2007),
                   labs=c("1-month","2-month","3-month"))+place_legend(.8,.8)

pdf(file=paste(outputcd, "R_CP.pdf"), width=10,height=7)
multiplot(p1,p2,p3,p4,layout=matrix(c(1:4), nrow=2, byrow=TRUE), title="Commercial Paper")
dev.off()

################################################################################NFNCB Plots
dt<-2000
seclabels<-c("Non-Corporate","Corporate","Households")
plotrecessions(c("MRNCORP","MRCORP","MRHH"), "Banking Rate", "% Mortgages / Total Liabilities",
               datelimits(dt),labs=seclabels)+
  place_legend(.8,.3)

plotrecessions(c("BRNCORP","BRCORP","BRHH"), "Banking Rate", "% Mortages + Loans / Total Liabilities",
               datelimits(dt),labs=seclabels)+
  place_legend(.8,.3)

plotrecessions(c("BRCORP","BNDRCORP","CPRCORP"), "Funding Composition (Corporations)",
               "% of Liability",datelimits(dt),labs=c("Bank","Bonds","CP"))+
  place_legend(.8,.3)

plotrecessions(c("CIRNCORP","CIRCORP","CIRHH"), "Credit Instrument Rate",
               "Credit Instruments / Total Liabilities",
               datelimits(dt),labs=seclabels)

plotrecessions("NEF.R.Y", "Net-Credit to Businesses", "% From Great Recessions",
               datelimits(dt))

plotrecessions(c("NEFNCORP.R.Y","NEFCORP.R.Y","NEFHH.R.Y"), "Real Net External Finance by Sector",
               "% from Great Recession", datelimits(dt), labs=seclabels)

plotrecessions(c("EFNCORP.R.Y","EFCORP.R.Y","EFHH.R.Y"), "Liquid Holdings by Sector",
               "% from Great Recession", datelimits(dt), labs=seclabels)

plotrecessions(c("LANCORP","LACORP","LAHH"), "Liquid Holdings by Sector",
               "% from Great Recession", datelimits(dt), labs=seclabels)

plotrecessions(c("EFNCORP","EFCORP"), "Total External Financing",
               "Billions US$", datelimits(dt), labs=c("Non-Corporate", "Corporate"))

plotrecessions(c("NEFNCORP","NEFCORP","NEFHH"), "Total External Financing",
               "Billions US$", datelimits(dt), labs=seclabels)

plotrecessions(c("NEFF.R.Y","NEFHH.R.Y"), "Total External Financing over GDP",
               "Ratio", datelimits(dt), labs=c("Firms","Households"))

plotrecessions(c("EFNCORP.R.I","EFCORP.R.I","EFHH.R.I"), "Total External Financing over Investment",
               "Ratio", datelimits(dt), labs=seclabels)

plotrecessions(c("LTFANCORP","LTFACORP","LTFAHH"), "Balance Sheet- Total Financial Assets",
               "Billions US$", datelimits(dt), labs=seclabels)

plotrecessions(c("LGSNCORP","LGSCORP"), "Balance Sheet- Government Assets",
               "Billions US$", datelimits(dt), labs=seclabels)

plotrecessions(c("LTSDNCORP","LTSDCORP","LTSDHH"), "Balance Sheet- Non-Corporate Businesses",
               "Billions US$", datelimits(dt), labs=seclabels)

plotrecessions(c("LCDNCORP","LCDCORP","LCDHH"), "Balance Sheet- Chckable Deposits",
               "Billions US$", datelimits(dt), labs=seclabels)

plotrecessions(c("LMMFNCORP","LMMFCORP","LMMFHH"), "Balance Sheet- Money Market Funds",
               "Billions US$", datelimits(dt), labs=seclabels)

plotrecessions(c("LTRNCORP","LTRCORP"), "Balance Sheet- Accounts Receivable",
               "Billions US$", datelimits(dt), labs=c("Non-Corporate","Corporate"))

plotrecessions(c("LTACORP","LTOTLCORP"), "Balance Sheet- Corporate Businesses",
               "Billions US$", datelimits(dt), labs=c("Assets", "Liabilities"))

plotrecessions(c("LTACORP","LTANCORP"), "Balance Sheet- Total Assets",
               "Billions US$", datelimits(dt), labs=c("Corporate","Non-Corporate"))

benchdate<-as.Date("2000-01-01")
plotrecessions(c("LNWNCORP","LNWMVCORP"), "Balance Sheet- Equity",
               "Billions US$", datelimits(dt), labs=c("Non-Corporate","Corporate"),bench=TRUE)

plotrecessions(c("LINVNCORP","LSMENCORP","LRESTNCORP"), "Tangible Assets- Non-Corporate Businesses",
               "Billions US$", datelimits(dt), labs=c("Inventory","Mach + Eq","Real Estate"))

plotrecessions(c("LINVCORP","LSMECORP","LRESTCORP"), "Tangible Assets- Corporate Businesses",
               "Billions US$", datelimits(dt), labs=c("Inventory","Mach + Eq","Real Estate"))

bils<-function(x) {return(log(x/1000))}
p1<-plotrecessions(c("LTACORP","LTOTLCORP"),"Balance Sheet",
                   "Log billion US$",datelimits(2001),labs=c("Assets","Liabilities"),
                   FUNC=bils)+place_legend(.2,.8)
p2<-plotrecessions(c("LINVCORP","LSMECORP","LRESTCORP"), "Tangible Assets", "Log billion US$", datelimits(2001),
                   labs=c("Inventory","Mach+Eq","Real Estate"),FUNC=bils)+place_legend(.2,.25)
p3<-plotrecessions(c("LLNECCORP","LOMPLCORP","LCORSECLCORP","LTOTMCORP"), "Credit Market Liabilities",
                   "Log billion US$", datelimits(2001), labs=c("Loans N.E.C.", "Commercial Paper", "Bonds", "Mortgages"),
                   FUNC=bils)+place_legend(.85,.7)
p4<-plotrecessions(c("LTFACORP","LTRCORP"),"Credit Market Assets and Trade Receivables","Log billion US$",datelimits(2001),
                   labs=c("Financial Assets","Trade Receivables"), FUNC=bils)+place_legend(.3,.5)
p5<-plotrecessions(c("LCMILCORP","LTDPAYCORP","LTXPAYCORP"), "Credit Market Liabilities", "Log billion US$", datelimits(2001),
                   labs=c("Credit Market and Other Liabilities","Trade Payables","Tax Payables"), FUNC=bils)+place_legend(.3,.4)
pdf(file=paste(outputcd, "R_corporate.pdf"), width=15,height=12)
multiplot(p1,p2,p3,p4,p5,layout=matrix(c(1,1,2:5), nrow=3, byrow=TRUE), title="Nonfinancial Corporate Business")
dev.off()

bils<-function(x) {return(log(x/1000))}
p1<-plotrecessions(c("LTANCORP","LTOTLNCORP"),"Balance Sheet",
                   "Log billion US$",datelimits(2001),labs=c("Assets","Liabilities"),
                   FUNC=bils)+place_legend(.2,.8)
p2<-plotrecessions(c("LINVNCORP","LSMENCORP","LRESTNCORP"), "Tangible Assets", "Log billion US$", datelimits(2001),
                   labs=c("Inventory","Mach+Eq","Real Estate"),FUNC=bils)+place_legend(.2,.25)
p3<-plotrecessions(c("LLNECNCORP","LTOTMNCORP"), "Credit Market Liabilities",
                   "Log billion US$", datelimits(2001), labs=c("Loans N.E.C.","Mortgages"),
                   FUNC=bils)+place_legend(.85,.7)
p4<-plotrecessions(c("LTFANCORP","LTRNCORP"),"Credit Market Assets and Trade Receivables","Log billion US$",datelimits(2001),
                   labs=c("Financial Assets","Trade Receivables"), FUNC=bils)+place_legend(.3,.5)
p5<-plotrecessions(c("LCMILNCORP","LTDPAYNCORP","LTXPAYNCORP"), "Credit Market Liabilities", "Log billion US$", datelimits(2001),
                   labs=c("Credit Market and Other Liabilities","Trade Payables","Tax Payables"), FUNC=bils)+place_legend(.3,.4)
pdf(file=paste(outputcd, "R_noncorporate.pdf"), width=15,height=12)
multiplot(p1,p2,p3,p4,p5,layout=matrix(c(1,1,2:5), nrow=3, byrow=TRUE), title="Nonfinancial Non-Corporate Business")
dev.off()

p1<-plotrecessions("USROE","Return on Equity","Percent",datelimits(2001))
p2<-plotrecessions("USROA","Return on Assets","Percent",datelimits(2001))
p3<-plotrecessions("EQTA","Equity to Assets","Percent",datelimits(2001))
p4<-plotrecessions("USNIM","Net Interest Margin","Percent",datelimits(2001))
p5<-plotrecessions("NPCMCM","Non Performing Commercial Loans","Percent",datelimits(2001))
p6<-plotrecessions("NCOCMC","Commercial Loans Write-Offs","Percent",datelimits(2001))
pdf(file=paste(outputcd, "R_bankingindicators.pdf"), width=15,height=12)
multiplot(p1,p2,p3,p4,p5,p6,layout=matrix(c(1:6), nrow=3, byrow=TRUE), title="Key Banking Indicators")
dev.off()
