packages<-list("foreign","reshape2","plyr","dplyr","XLConnect")
sapply(packages, require, character.only=TRUE)

gitcd<-"C:/Users/sv2307/Documents/GitHub/BigioCode/"

cd<-"Data/Compustat/"
### Load linking datasets
link<-read.csv(paste(gitcd, cd, "DealScan COMPUSTAT Link August 2012.csv", sep=""))
Chodorow<-readWorksheetFromFile(paste(gitcd,cd,"Dealscan-bank regulatory crosswalk.xlsx",sep=""),sheet=2)

### Load Compustat data
Compustat<-read.csv(paste(gitcd, cd, "a0682355275bbbf8.csv", sep=""))

### Merge two linking datasets (Chodorow & Roberts)
Chodorow.subset<-subset(Chodorow, !is.na(Compustat), select=c(Compustat, lenderid))
names(Chodorow.subset)<-c("gvkey","bcoid")
link<-rbind.fill(link,Chodorow.subset)

### Load DealScan sets (Company, Facility, Package, Lenders)
DealScanP<-read.dta(paste(gitcd, "Data/DealScan/","9c10fb6e84ca2ef8.dta",sep=""))
DealScanC<-read.dta(paste(gitcd, "Data/DealScan/","decfdb797bdedda8.dta",sep=""))
DealScanF<-read.dta(paste(gitcd, "Data/DealScan/","6edf39a134dc4148.dta",sep=""))
DealScanL<-read.dta(paste(gitcd, "Data/DealScan/","494a41c9c62f187f.dta",sep=""))

DealScanL.w<-summarize(group_by(DealScanL, facilityid), lender1=companyid[order(bankallocation, decreasing=TRUE)==1])
DealScanFL<-merge(DealScanF,DealScanL.w, all.x=TRUE)
DealScanP2<-summarize(group_by(DealScanFL, packageid), dealamt=sum(facilityamt), borrowercompanyid=borrowercompanyid[1],
                      facilitystartdate=facilitystartdate[1], facilityenddate=facilityenddate[1], currency=currency[1], 
                      exchangerate=exchangerate[1], lender1=lender1[1])
masterlink<-subset(link, select=c(bcoid, gvkey))[!duplicated(link$bcoid),]

names(masterlink)<-c("borrowercompanyid","bcogvkey")
DealScan.linked<-merge(DealScanP2, masterlink, all.x=TRUE)
names(masterlink)<-c("lender1","lendergvkey")
DealScan.linked<-merge(DealScan.linked, masterlink, all.x=TRUE)


