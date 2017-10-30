

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

 ##change column classes
 NEI$year <- as.character(NEI$year)
 
 ##sum all pm25 values for each year
 sumpull<-aggregate(Emissions~year,NEI,sum)
 
 ##plot1
 
 par(mfcol=c(1,1))
 plot(sumpull$year,sumpull$Emissions,pch=19,xlab="YEAR",ylab="PM2.5", main="Total PM2.5 emissions at various years")
 lines(sumpull$year,sumpull$Emissions,col="red",lwd=2)
         
 ##copy plot to png file
 dev.copy(png,file="plot 1.png")
 dev.off