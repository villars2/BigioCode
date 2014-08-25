file<-"IOUse_Before_Redefinitions_PRO_2007_Detail"
xls.df<-readWorksheetFromFile(paste("C:/Users/sv2307/Downloads/", file, ".xlsx",sep=""), sheet=2)

expandString <- function(string) {
  if (!is.na(string)) {
    list<-strsplit(string,"-")
    dif<-as.numeric(list[[1]][2])-as.numeric(list[[1]][1]) %% 10
    start<-as.numeric(list[[1]][1])
    end<-start+dif
    newstring<-paste(as.character(c(start:end)), collapse=", ")
    return(newstring)
  } else {
    return(NA)
  }
}

getString <- function(string) {
  parts<-as.character(strsplit(string, ", ")[[1]])
  if (max(grepl("-",parts))==1) {
    parts[grepl("-",parts)]<-apply(as.matrix(parts[grepl("-",parts)]),1,expandString)
  }
  return(paste(parts, collapse=", "))
}

xls.df<-xls.df[4:642,]
names(xls.df)<-c("sector","summary","detail","detailname","notes","naics")

xls.df$summaryname<-NA
xls.df[!is.na(xls.df$summary),]$summaryname<-xls.df[!is.na(xls.df$summary),]$detail
xls.df[!is.na(xls.df$summary),]$detail<-NA

xls.df$sectorname<-NA
xls.df[!is.na(xls.df$sector),]$sectorname<-xls.df[!is.na(xls.df$sector),]$summary
xls.df[!is.na(xls.df$sector),]$summary<-NA

xls.df<-subset(xls.df, select=-c(notes))

xls.df[!is.na(xls.df$naics) & xls.df$naics!="n/a",]$naics<-apply(as.matrix(xls.df[!is.na(xls.df$naics) & xls.df$naics!="n/a",]$naics),1,getString)

expandDF <- function(df) {
  newdf<-data.frame(sector=df$sector[1], 
                    summary=df$summary[1], 
                    detail=df$detail[1], 
                    detailname=df$detailname[1], 
                    naics=strsplit(df$naics, ", ")[[1]], 
                    summaryname=df$summaryname[1], 
                    sectorname=df$sectorname[1])
  return(newdf)
}

xls.df$rows<-as.numeric(row.names(xls.df))
newnaics<-ddply(xls.df, .(rows), expandDF)
newnaics<-cbind(subset(newnaics, select=c(detail,detailname,naics)),
                na.locf(subset(newnaics, select=-c(detail,detailname,naics,rows))))
newnaics<-subset(newnaics, !is.na(naics))

newnaics<-newnaics[,c(4,7,5,6,1,2,3)]

write.csv(newnaics, file="C:/Users/sv2307/Dropbox/Saki/NAICSnames.csv", row.names=FALSE)
