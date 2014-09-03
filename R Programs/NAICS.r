library(XLConnect)
library(zoo)
gitcd<-"C:/Users/sv2307/Documents/GitHub/BigioCode/"

cd<-"Data/NAICS/"

### Read in file from xls
file<-"IOUse_Before_Redefinitions_PRO_2007_Detail.xlsx"
xls.df<-readWorksheetFromFile(paste(gitcd, cd, file, sep=""), sheet=2)

### Function to convert range of numbers (103-4) to list (103, 104)
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

### Function to convert list of strings and ranges to list (103, 105-6->103, 105, 106)
getString <- function(string) {
  parts<-as.character(strsplit(string, ", ")[[1]])
  if (max(grepl("-",parts))==1) {
    parts[grepl("-",parts)]<-apply(as.matrix(parts[grepl("-",parts)]),1,expandString)
  }
  return(paste(parts, collapse=", "))
}

### Subset rows with data, and rename columns
xls.df<-xls.df[4:642,]
names(xls.df)<-c("sector","summary","detail","detailname","notes","naics")

### Extract names of larger sectors and carry forward
xls.df$summaryname<-NA
xls.df[!is.na(xls.df$summary),]$summaryname<-xls.df[!is.na(xls.df$summary),]$detail
xls.df[!is.na(xls.df$summary),]$detail<-NA

xls.df$sectorname<-NA
xls.df[!is.na(xls.df$sector),]$sectorname<-xls.df[!is.na(xls.df$sector),]$summary
xls.df[!is.na(xls.df$sector),]$summary<-NA

### Get rid of notes column
xls.df<-subset(xls.df, select=-c(notes))

### From data frame get the list of naics
xls.df[!is.na(xls.df$naics) & xls.df$naics!="n/a",]$naics<-apply(as.matrix(xls.df[!is.na(xls.df$naics) & xls.df$naics!="n/a",]$naics),1,getString)

### Function to expand list of naics (lengthen data frame)
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

### Get indicator for each row, to run function on each row
xls.df$rows<-as.numeric(row.names(xls.df))

### Apply function on each row
newnaics<-ddply(xls.df, .(rows), expandDF)

### Carry forward summary and sector variables only
newnaics<-cbind(subset(newnaics, select=c(detail,detailname,naics)),
                na.locf(subset(newnaics, select=-c(detail,detailname,naics,rows))))

### Throw away NA rows
newnaics<-subset(newnaics, !is.na(naics))

### Reorder the columns
newnaics<-newnaics[,c(4,7,5,6,1,2,3)]

### Export CSV
write.csv(newnaics, file=paste(gitcd, cd, "NAICSnames.csv", sep=""), row.names=FALSE)