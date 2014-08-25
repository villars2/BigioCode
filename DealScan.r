packages<-list("foreign","reshape2","plyr","dplyr")
sapply(packages, require, character.only=TRUE)

cd<-"C:/Users/sv2307/Downloads/"
link<-read.csv(paste(cd,"DealScan COMPUSTAT Link August 2012.csv", sep=""))
Compustat<-read.csv(paste(cd,"a0682355275bbbf8.csv", sep=""))

### Load DealScan sets (Company, Facility, Package, Lenders)
DealScanP<-read.dta(paste(cd,"9c10fb6e84ca2ef8.dta",sep=""))
DealScanC<-read.dta(paste(cd,"decfdb797bdedda8.dta",sep=""))
DealScanF<-read.dta(paste(cd,"6edf39a134dc4148.dta",sep=""))
DealScanL<-read.dta(paste(cd,"494a41c9c62f187f.dta",sep=""))

# DealScanF.P<-summarise(group_by(DealScanF, packageid), dealamt=sum(facilityamt))

# bla<-merge(DealScanP, DealScanF.P)


# names(DealScan)[names(DealScan)=="borrowercompanyid"]<-"bcoid"

# DealScan.linked<-merge(DealScan, link, all.x=TRUE)

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


