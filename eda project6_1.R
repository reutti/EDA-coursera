library(ggplot2)
library(data.table)

##download the data directory and unzip it
file1<-"summarySCC_PM25.rds"
file2<-"Source_Classification_Code.rds"
if (!file.exists(file1)){
  url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(url,"data_eda.zip")
  unzip("data_eda.zip")
}

##convert into readble dataframe
  NEI <- readRDS(file1)
  SCC <- readRDS(file2)


##merge both dataframes
  NEISCC <- merge(NEI, SCC, by="SCC")

#fetch records with Short.Name (SCC) Motor
NEISCC_Balt<-subset(NEISCC,fips == "24510" & type=="ON-ROAD")
NEISCC_LA<-subset(NEISCC,fips == "06037" & type=="ON-ROAD")
##sum all pm25 values for each year
sumpull1<-aggregate(Emissions~year,NEISCC_Balt,sum)
sumpull1<-cbind(sumpull1,"zip"="24510")
sumpull2<-aggregate(Emissions~year,NEISCC_LA,sum)
sumpull2<-cbind(sumpull2,"zip"="06037")
sumt<-rbind(sumpull1,sumpull2)
sumt$zip<-as.factor(sumt$zip)

##plot6
png("plot 6.png", width=640, height=480)
g <- ggplot(sumt, aes(year, Emissions ))
g <- g +facet_grid(.~zip()) + geom_bar(stat="identity") + xlab("year") +  ylab("Total PM2.5 Emissions") +  ggtitle("Emissions from sources in Baltimor VS. LA")
print(g)
dev.copy(png,file="plot 6.png")
dev.off