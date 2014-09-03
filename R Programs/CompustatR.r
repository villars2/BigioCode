sapply(c("Quandl","XML","dplyr"), require, character.only=TRUE)
gitcd<-"C:/Users/sv2307/Documents/GitHub/BigioCode/"

cd<-"Data/Compustat/"
file<-"a0682355275bbbf8.csv"

Compustat<-read.csv(paste(gitcd, cd, file, sep=""))

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
rm(NAWI)

Compustat$wages<-Compustat$emp*Compustat$AWI*1000/1000000
Compustat$GVA<-rowSums(subset(Compustat, select=c(wages, oibdp)), na.rm=TRUE)
Compustat$markup<-Compustat$sale/Compustat$cogs-1
Compustat$lmarkup<-Compustat$sale/Compustat$wages-1

Compustat[Compustat$GVA<0,]$GVA<-NA

newnaics<-read.csv(paste(gitcd, "Data/NAICS/", "NAICSnames.csv", sep=""))
Compustat<-merge(Compustat, newnaics)

Compustat<-merge(Compustat, DataFRED)
rm(DataFRED)
Compustat[Compustat$curcd=="CAD",]$GVA<-Compustat[Compustat$curcd=="CAD",]$GVA*Compustat[Compustat$curcd=="CAD",]$EXCAUS
Compustat$GVA<-Compustat$GVA/Compustat$GDPDEF*100

## Compustat.DT<-data.table(Compustat)
## Compustat.DT$date<-as.Date(ISOdate(substr(DT, 1, 4),substr(DT,5,6),substr(DT,7,8)))
## setkey(Compustat.DT, gvkey, date)

GDP1<-summarize(group_by(Compustat, fyear, sector), 
               GDP=sum(GVA, na.rm=TRUE),
               Markup=mean(markup[!is.na(markup) & markup>=0 & markup<=1]), 
               AggMarkup=sum(sale[!is.na(sale) & !is.na(cogs)])/sum(cogs[!is.na(sale) & !is.na(cogs)])-1,
               LMarkup=mean(lmarkup[!is.na(lmarkup) & lmarkup>=0 & lmarkup<=1]), 
               AggLMarkup=sum(sale[!is.na(sale) & !is.na(wages)])/sum(wages[!is.na(sale) & !is.na(wages)])-1, 
               depth=1)

GDP2<-summarize(group_by(Compustat, fyear, summary), 
                GDP=sum(GVA, na.rm=TRUE),
                Markup=mean(markup[!is.na(markup) & markup>=0 & markup<=1]), 
                AggMarkup=sum(sale[!is.na(sale) & !is.na(cogs)])/sum(cogs[!is.na(sale) & !is.na(cogs)])-1,
                LMarkup=mean(lmarkup[!is.na(lmarkup) & lmarkup>=0 & lmarkup<=1]), 
                AggLMarkup=sum(sale[!is.na(sale) & !is.na(wages)])/sum(wages[!is.na(sale) & !is.na(wages)])-1, 
                depth=2)

GDP3<-summarize(group_by(Compustat, fyear, detail), 
                GDP=sum(GVA, na.rm=TRUE),
                Markup=mean(markup[!is.na(markup) & markup>=0 & markup<=1]), 
                AggMarkup=sum(sale[!is.na(sale) & !is.na(cogs)])/sum(cogs[!is.na(sale) & !is.na(cogs)])-1,
                LMarkup=mean(lmarkup[!is.na(lmarkup) & lmarkup>=0 & lmarkup<=1]), 
                AggLMarkup=sum(sale[!is.na(sale) & !is.na(wages)])/sum(wages[!is.na(sale) & !is.na(wages)])-1, 
                depth=3)

GDP4<-summarize(group_by(Compustat, fyear, naics), 
                GDP=sum(GVA, na.rm=TRUE),
                Markup=mean(markup[!is.na(markup) & markup>=0 & markup<=1]), 
                AggMarkup=sum(sale[!is.na(sale) & !is.na(cogs)])/sum(cogs[!is.na(sale) & !is.na(cogs)])-1,
                LMarkup=mean(lmarkup[!is.na(lmarkup) & lmarkup>=0 & lmarkup<=1]), 
                AggLMarkup=sum(sale[!is.na(sale) & !is.na(wages)])/sum(wages[!is.na(sale) & !is.na(wages)])-1, 
                depth=4)

names(GDP1)[2]<-"sector"
names(GDP2)[2]<-"sector"
names(GDP3)[2]<-"sector"
names(GDP4)[2]<-"sector"

GDP<-rbind(GDP1, GDP2, GDP3, GDP4)
rm(list=c("GDP1","GDP2","GDP3","GDP4"))

write.dta(GDP, paste(gitcd, cd, "CompustatAgg.dta", sep=""))

plotnaics<- function(sec) {return(ggplot(subset(GDP, sector==sec), aes(x=fyear, y=GDP))+geom_line(size=1))}

# plotnaics("31G")
