test<-subset(df.l,variable %in% c("GDP","GDPDEF","UNRATE","CPIAUCSL","LTFAMMMF"))

isRec <- function(vec) {
  return(as.logical(sapply(vec, function(x) {return(max(x>recessions.df$Peak & x<recessions.df$Trough))})))
}

sdall<-function(df) {return(sd(subset(df,is.numeric(value))$value))}
sdnotrec<-function(df) {return(sd(subset(df,isRec(date)&is.numeric(value))$value))}
sdrec<-function(df) {return(sd(subset(df,!isRec(date)&is.numeric(value))$value))}
sddec<-function(df) {return(sd(subset(df,date>=Sys.Date()-3650 & is.numeric(value))$value))}
sdgr<-function(df) {return(sd(subset(df,date>=recessions.df[length(recessions.df$Peak),1] 
                                     & date<=recessions.df[length(recessions.df$Peak),2] 
                                     & is.numeric(value))$value))}

meanall<-function(df) {return(mean(subset(df,is.numeric(value))$value))}
meannotrec<-function(df) {return(mean(subset(df,isRec(date)&is.numeric(value))$value))}
meanrec<-function(df) {return(mean(subset(df,!isRec(date)&is.numeric(value))$value))}
meandec<-function(df) {return(mean(subset(df,date>=Sys.Date()-3650 & is.numeric(value))$value))}
meangr<-function(df) {return(mean(subset(df,date>=recessions.df[length(recessions.df$Peak),1] 
                                     & date<=recessions.df[length(recessions.df$Peak),2] 
                                     & is.numeric(value))$value))}

bla<-ddply(test,.(variable),c("sdall","sdnotrec","sdrec","sddec","sdgr",
                              "meanall","meannotrec","meanrec","meandec","meangr"))
names(bla)[1]<-"var"
bla<-dcast(melt(bla, id="var"),variable~var)


