ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}
ipak(packages)
# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL, title=NULL) {
  require(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    if (length(title)>0) {
      pushViewport(viewport(layout = grid.layout(nrow(layout)+1, ncol(layout), heights=unit(c(1,rep(6,nrow(layout))), "null"))))
      grid.text(title, 
                just="centre", 
                vp = viewport(layout.pos.row = 1, layout.pos.col = 1:ncol(layout)),
                gp = gpar(fontsize=16, fontface="bold"))
      add<-1
    } else {
      pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
      add<-0
    }
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row+add,
                                      layout.pos.col = matchidx$col))
    }
  }
}

recessions.df <- read.table(textConnection(
  "Peak, Trough
1857-06-01, 1858-12-01
  1860-10-01, 1861-06-01
  1865-04-01, 1867-12-01
  1869-06-01, 1870-12-01
  1873-10-01, 1879-03-01
  1882-03-01, 1885-05-01
  1887-03-01, 1888-04-01
  1890-07-01, 1891-05-01
  1893-01-01, 1894-06-01
  1895-12-01, 1897-06-01
  1899-06-01, 1900-12-01
  1902-09-01, 1904-08-01
  1907-05-01, 1908-06-01
  1910-01-01, 1912-01-01
  1913-01-01, 1914-12-01
  1918-08-01, 1919-03-01
  1920-01-01, 1921-07-01
  1923-05-01, 1924-07-01
  1926-10-01, 1927-11-01
  1929-08-01, 1933-03-01
  1937-05-01, 1938-06-01
  1945-02-01, 1945-10-01
  1948-11-01, 1949-10-01
  1953-07-01, 1954-05-01
  1957-08-01, 1958-04-01
  1960-04-01, 1961-02-01
  1969-12-01, 1970-11-01
  1973-11-01, 1975-03-01
  1980-01-01, 1980-07-01
  1981-07-01, 1982-11-01
  1990-07-01, 1991-03-01
  2001-03-01, 2001-11-01
  2007-12-01, 2009-06-01"), sep=',',
colClasses=c('Date', 'Date'), header=TRUE)

bench <- function(dframe) {
  newdf<-dframe
  newdf$value<-newdf$value/newdf$value[min(which(newdf$date>=as.Date(benchdate)))]*100
  return(newdf)
}

benchdf<- function(df) {
  return(ddply(df,.(variable),"bench"))
}

graphstheme<-theme_bw()+
  theme(plot.title=element_text(face="bold", size=12), 
        axis.title.x=element_blank(), 
        axis.title.y=element_text(size=12),
        panel.grid.major=element_line(size=1))

plotrecessions <- function(series,name,unit,dates,logplot=FALSE,labs=series,bench=FALSE,FUNC=function(x) {return(x)}) {
  dates<-as.Date(dates)
  ybot<<-log(logplot)
  FUN<<-FUNC
  df<-subset(df.l, variable %in% series & date>=dates[1] & date<=dates[2])
  if (bench) {df<-benchdf(df)}
  ord<-data.frame(variable=series,order=c(1:length(series)))
  df<-merge(df,ord)
  df<-df[order(df$order,df$date),]
  df$variable<-as.character(df$variable)
  g<-ggplot(df)+
    geom_line(aes(x=date,y=FUN(value),colour=as.factor(order)),size=1)+
    graphstheme+
    ggtitle(name)+
    ylab(unit)
  if (dates[1]<tail(recessions.df$Trough,n=1)) {
    g<-g+geom_rect(data=subset(recessions.df, Peak>=min(df$date) | 
                                 (Peak<min(df$date) 
                                  & Trough>min(df$date))), 
                   aes(xmin=Peak, xmax=Trough, ymin=ybot, ymax=+Inf), alpha=0.3)
  }
  if (length(series)==1) { g<-g+theme(legend.position="none")}
  if (length(series)>1) {g<-g+scale_colour_discrete(labels=labs)+theme(legend.title=element_blank())}
  return(g)
}
datelimits<- function(year) {d<-c(paste(year,"-01-01",sep=""),as.character(Sys.Date())); return(d)}

place_legend <- function(xcoord,ycoord) {
  return(theme(legend.position=c(xcoord,ycoord)))
}

recPath <- function(ser,title,pers) {
  df<-subset(df.l, variable==ser)
  df$ind<-NA
  
  recessions.ind<-recessions.df
  recessions.ind$ind<-c(1:length(recessions.ind$Peak))
  
  recessions.indl<-melt(recessions.ind, id="ind")
  names(recessions.indl)<-c("ind","variable","date")
  recessions.indl$value<-NA
  recessions.indl<-subset(recessions.indl, variable=="Peak")
  
  merged<-rbind(recessions.indl,df)
  
  merged<-merged[order(merged$date),]
  merged$ind<-na.locf(merged$ind)
  
  clean<-subset(merged,variable==ser)
  clean.periods<-ddply(clean,.(ind),summarize,periods=c(1:length(ind)),value=(value/value[1]-1)*100)
  bla<-ddply(subset(clean.periods, ind!=33), .(periods), summarize, mean=mean(value), min=min(value),max=max(value))
  minmax<-subset(bla,select=c(periods,min,max))
  means<-subset(bla,select=c(periods,mean))
  names(means)<-c("periods","mean")
  gr<-subset(clean.periods, ind==33,select=c(periods,value))
  names(gr)<-c("periods","gr")
  
  whatever<-merge(merge(merge(subset(clean.periods, ind!=33),minmax),means),gr)
  
  g<-ggplot(subset(whatever,periods<=pers), aes(x=periods))+
    geom_ribbon(aes(ymin=min,ymax=max, alpha=.1))+
    geom_line(aes(y=value, colour=as.factor(ind)),size=1)+
    geom_line(aes(y=mean), colour='black',size=2)+
    geom_line(aes(y=gr), colour='red', size=2)+
    graphstheme+
    ylab("Percent of pre-crisis level")+
    theme(axis.title.x=element_text(size=12), legend.position="none")+
    xlab("Periods Since Recession Starts")+
    ggtitle(title)
  
  return(g)
}

getFoF <- function(ser) {
  todate<-format(Sys.Date(), "%m/%d/%Y")
  fromdate<-"03/01/1974"
  FoF.url<-paste("http://www.federalreserve.gov/datadownload/Output.aspx?",
                 "rel=Z1&series=", ser, "&lastObs=",
                 "&from=", fromdate, "&to=", todate, "&filetype=csv&label=",
                 "include&layout=seriesrow", sep="")
  
  FoF.df<-data.frame(t(read.csv(url(FoF.url))))
  serids<-as.character(t(FoF.df[6,]))
  labels<-getNames(serids)
  if (length(FoF.df[1,])==length(labels)) {
    FoF.df$date<-row.names(FoF.df)
    FoF.df<-subset(FoF.df, substr(date,1,1)=="X")
    FoF.df$y<-as.numeric(substr(FoF.df$date,2,5))
    FoF.df$m<-as.numeric(substr(FoF.df$date,7,7))*3-2
    FoF.df$date<-as.Date(ISOdate(FoF.df$y,FoF.df$m,1))
    FoF.df<-subset(FoF.df, select=-c(y,m))
    names(FoF.df)<-c(serids,"date")
    FoF.dfl<-melt(FoF.df,id="date")
    FoF.dfl$value<-as.numeric(as.character(FoF.dfl$value))
    FoF.dfl$variable<-as.character(FoF.dfl$variable)
    FoF.dfl<-subset(FoF.dfl, !is.na(value))
    names(FoF.dfl)<-c("date","id","value")
    ids<-data.frame(id=as.character(serids),variable=as.character(labels))
    FoF.dfl<-merge(FoF.dfl,ids,all.x=TRUE)
    FoF.dfl<-FoF.dfl[order(FoF.dfl$id, FoF.dfl$date),]
  } else {
    errormsg<-paste("Length of series is ", 
                    as.character(length(FoF.df[1,])), sep="")
    descs<<-serids
    stop(errormsg)
  }
}

getNames<- function(ids) {
  names.df<-data.frame(id=ids)
  names.df$pre<-substr(names.df$id,2,2)
  names.df$sec<-as.numeric(substr(names.df$id,3,4))
  names.df$instr<-as.numeric(substr(names.df$id,5,9))
  
  sectorMaster<-data.frame(sec=c(10,11,15,63,66,67,73,76), sector=c("CORP","NCORP","HH","MMMF","SBD","ABS","BHC","CB"))
  
  instrMaster <- read.table(textConnection(
    "instr, instrument
    20000,TA
    20500,FED
    20100,NFA
    20900,NWMV
    20901,NWHC
    20902,NW
    21500,FEDFUND
    30130,RES
    30200,CD
    30300,TSD
    30340,MMF
    30610,GS
    30611,TS
    30617,GESSEC
    30620,MUNSEC
    30621,HELA
    30630,CORSEC
    30641,COREQ
    30650,TMLOANS
    30651,HELA
    30670,SECDUE
    30680,NECLOANS
    30691,OMP
    30692,USDIA
    30698,CLNFCB
    30700,TR
    30900,TM
    30910,FD
    30930,U
    30947,EQTM
    31270,CHECKS
    31300,TSDEP
    31315,IRA
    31630,CORSECL
    31641,EQUITY
    31650,TOTM
    31670,SCOHW
    31680,LNEC
    31691,OMPL
    31700,TDPAY
    31780,TXPAY
    31900,TOTMIL
    31920,FDI
    31930,UML
    31940,FEQINV
    40040,CMI
    40050,TBC
    40220,DS
    40350,TOTLOANS
    40900,TFA
    41040,CMIL
    41100,NIL
    41120,NIUL
    41900,TOTL
    50132,NANFRES
    50133,CL
    50136,NONFRESA
    50138,FTNFA
    50152,SME
    50200,INV
    50350,REST
    50800,EQCAP
    51110,DUR
    60064,RE
    64090,FTFA"), sep=',',
    colClasses=c('numeric', 'character'), header=TRUE)
  
  names.df<-merge(names.df,instrMaster,all.x=TRUE)
  names.df<-merge(names.df,sectorMaster,all.x=TRUE)
  names.df$ticker<-paste(names.df$pre,names.df$instrument,names.df$sector,sep="")
  
  names.df[is.na(names.df$instrument),]$ticker<-"NA"
  names.df<-names.df[order(names.df$id),]
  return(names.df$ticker)
}

getDescription <- function(series) {
  url<-paste("http://www.quandl.com/api/v1/datasets/", series, ".json?exclude_data=true&auth_token=ncNy7saz6QdDjeBDKAcg",sep="")
  JSONfile<-fromJSON(file=url)
  descr<-JSONfile$description
  nm<-JSONfile$name
  descr.df<-data.frame(variable=series, name=nm, description=descr)
  return(descr.df)
}
