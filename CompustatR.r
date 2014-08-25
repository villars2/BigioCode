sapply(c("Quandl","XML"), require, character.only=TRUE)

Compustat<-read.csv("C:/Users/sv2307/Downloads/a0682355275bbbf8.csv")

URL<-"http://www.ssa.gov/oact/cola/awidevelop.html"
table<-readHTMLTable(URL)
n.rows <- unlist(lapply(table, function(t) dim(t)[1]))
NAWI<-table[[2]]
NAWI<-NAWI[4:length(NAWI[,1]),1:2]
names(NAWI)<-c("fyear","AWI")
NAWI$Year<-c(1985:2012)
NAWI$AWI<-as.numeric(gsub(",","",NAWI$AWI))

### Get from FRED
DataFRED<-data.frame(Quandl(c("FRED/GDPDEF","FRED/EXCAUS"), type='xts', collapse="annual"))
names(DataFRED)<-c("GDPDEF","EXCAUS")
DataFRED$fyear<-substr(row.names(DataFRED), 1, 4)

### Merging stuff
Compustat<-merge(Compustat, NAWI)

Compustat$wages<-Compustat$emp*Compustat$AWI*1000/1000000
Compustat$GVA<-rowSums(subset(Compustat, select=c(wages, oibdp)), na.rm=TRUE)
Compustat$markup<-Compustat$sale/Compustat$cogs-1
Compustat$lmarkup<-Compustat$sale/Compustat$wages-1

Compustat[Compustat$GVA<0,]$GVA<-NA

newnaics<-read.csv("C:/Users/sv2307/Dropbox/Saki/NAICSnames.csv")
Compustat<-merge(Compustat, newnaics)

Compustat<-merge(Compustat, DataFRED)
Compustat[Compustat$curcd=="CAD",]$GVA<-Compustat[Compustat$curcd=="CAD",]$GVA*Compustat[Compustat$curcd=="CAD",]$EXCAUS
Compustat$GVA<-Compustat$GVA/Compustat$GDPDEF*100

## Compustat.DT<-data.table(Compustat)
## Compustat.DT$date<-as.Date(ISOdate(substr(DT, 1, 4),substr(DT,5,6),substr(DT,7,8)))
## setkey(Compustat.DT, gvkey, date)

GDP<-ddply(Compustat, .(fyear, sector), summarize, GDP=sum(GVA, na.rm=TRUE), 
           Markup=mean(markup[!is.na(markup) & markup>=0 & markup<=1]),
           AggMarkup=sum(sale[!is.na(sale) & !is.na(cogs)])/sum(cogs[!is.na(sale) & !is.na(cogs)])-1,
           LMarkup=mean(lmarkup[!is.na(lmarkup) & lmarkup>=0 & lmarkup<=1]),
           AggLMarkup=sum(sale[!is.na(sale) & !is.na(wages)])/sum(wages[!is.na(sale) & !is.na(wages)])-1)
write.dta(GDP, "C:/Users/sv2307/Dropbox/Saki/CompustatAgg.dta")

plotnaics<- function(sec) {return(ggplot(subset(GDP, sector==sec), aes(x=fyear, y=GDP))+geom_line(size=1))}


