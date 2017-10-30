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

#fetch records with Short.Name (SCC) Coal
coal  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
NEISCC_coal <- NEISCC[coal, ]


##sum all pm25 values for each year
sumpull<-aggregate(Emissions~year,NEISCC_coal,sum)

##plot4

png("plot 4.png", width=640, height=480)
g <- ggplot(sumpull, aes(year, Emissions))
g <- g + geom_point() +geom_line(aes(group=1))+  xlab("year") +  ylab("Total PM2.5 Emissions") +  ggtitle("Emissions from coal combustion-related sources")
print(g)
dev.copy(png,file="plot 4.png")
dev.off