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
if (!exists(NEI)){
NEI <- readRDS(file1)}
if (!exists(SCC)){
SCC <- readRDS(file2)}


##merge both dataframes
if(!exists(NEISCC)){
NEISCC <- merge(NEI, SCC, by="SCC")}

#fetch records with Short.Name (SCC) Motor
NEISCC_Balt<-subset(NEISCC,fips == "24510" & type=="ON-ROAD")

##sum all pm25 values for each year
sumpull<-aggregate(Emissions~year,NEISCC_Balt,sum)

##plot5

png("plot 5.png", width=640, height=480)
g <- ggplot(sumpull, aes(year, Emissions))
g <- g + geom_point() +geom_line(aes(group=1))+  xlab("year") +  ylab("Total PM2.5 Emissions") +  ggtitle("Emissions from MOTOR sources in Baltimor")
print(g)
dev.copy(png,file="plot 5.png")
dev.off