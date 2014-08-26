getFoF <- function(ser, labels) {
  todate<-format(Sys.Date(), "%m/%d/%Y")
  fromdate<-"03/01/1974"
  FoF.url<-paste("http://www.federalreserve.gov/datadownload/Output.aspx?",
                 "rel=Z1&series=", ser, "&lastObs=",
                 "&from=", fromdate, "&to=", todate, "&filetype=csv&label=",
                 "include&layout=seriesrow", sep="")
  
  FoF.df<-data.frame(t(read.csv(url(FoF.url))))
  if (length(FoF.df[1,])==length(labels)) {
    FoF.df$date<-row.names(FoF.df)
    FoF.df<-subset(FoF.df, substr(date,1,1)=="X")
    FoF.df$y<-as.numeric(substr(FoF.df$date,2,5))
    FoF.df$m<-as.numeric(substr(FoF.df$date,7,7))*3-2
    FoF.df$date<-as.Date(ISOdate(FoF.df$y,FoF.df$m,1))
    labels<-c(labels,"date")
    names(FoF.df)<-labels
    FoF.df<-subset(FoF.df,select=labels)
    FoF.dfl<-melt(FoF.df,id="date")
    FoF.dfl$value<-as.numeric(as.character(FoF.dfl$value))
    FoF.dfl<-subset(FoF.dfl, !is.na(value))
    return(FoF.dfl)
  } else {
    errormsg<-paste("Length of series is ", 
                    as.character(length(FoF.df[1,])), sep="")
    descs<<-FoF.df[1,]
    stop(errormsg)
  }
}

nameseries<-c("FEDABSMMF","CDABSMMF","TSDABSMMF",
              "GSEABSMMF","MUNIABSMMF","BONDSABSMMF",
              "OMPABSMMF","FDABSMMF","UABSMMF",
              "IRAABSMMF","CMIABSMMF","TOTFINABSMMF")
bla<-getFoF("39538d0ebcf22e1ccf42cc1bcb7428e6",nameseries)

bla<-getFoF("c75ae00636a23a20429d44ce60f204c5","test")

bla<-getFoF("3e2927bda3e89c60495bc2ceedb4c3bd","test")
