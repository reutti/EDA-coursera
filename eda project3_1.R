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

##take only Baltimor's observatons
NEI_Balt<-subset(NEI,fips == "24510")

##change column classes

NEI_Balt$year <- as.character(NEI_Balt$year)

##sum all pm25 values for each year
sumpull<-aggregate(Emissions~year+type,NEI_Balt,sum)
sumpull$type<-as.factor(sumpull$type)

##plot3
png("plot 3.png", width=640, height=480)
g <- ggplot(sumpull, aes(year, Emissions, color=type))
g <- g + geom_point() +geom_line(aes(group=type))+  xlab("year") +  ylab("Total PM2.5 Emissions") +  ggtitle("Emissions in Baltimore")
print(g)
dev.copy(png,file="plot 3.png")
dev.off