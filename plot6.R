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

#Getting motor vehicle relate data
motorEmissionData <- NEI[which(NEI$SCC %in% SCC[grep("motor",SCC$SCC.Level.Three,ignore.case = TRUE),"SCC"]),]
tco <- c("24510","06037")
multiMotorEmissionData <-subset(motorEmissionData,fips %in% tco)

#creating png file
png(filename = "plot6.png", width = 480, height = 480, units = "px", bg = "transparent")
par(mar=c(4,4,4,4))
#plotting the graph
g <- ggplot(multiMotorEmissionData,aes(year, Emissions, color = fips))
g + geom_line(stat = "summary", fun.y="sum") + labs( y= "Emissions from motor vehicle for Los Angeles and Baltimore City (199-2008) ",x=" Year ") + scale_colour_discrete(name = "City", label = c("Los Angeles","Baltimore"))

dev.off()


