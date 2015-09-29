if(!require(dplyr)){
   install.packages("dplyr")
}

if(!require(ggplot2)){
  install.packages("ggplot2")
}

cdFile <- "./data/exdata-data-NEI_data/Source_Classification_Code.rds"
emFile <- "./data/exdata-data-NEI_data/summarySCC_PM25.rds"
#Reading data from RDS
SCC <- readRDS(cdFile)
NEI <- readRDS(emFile)

#Getting coal combustion relate data
coalCombustionData <- NEI[which(NEI$SCC %in% SCC[ grep("coal", SCC$Short.Name, ignore.case = TRUE), "SCC"]),]

#creating png file
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "transparent")
par(mar=c(4,4,4,4))
#plotting the graph
g<-ggplot(coalCombustionData, aes(year,Emissions))
g+geom_line(stat = "summary", fun.y="sum")+ labs(y="Emissions from coal combustion sources",x="Year")

dev.off()


