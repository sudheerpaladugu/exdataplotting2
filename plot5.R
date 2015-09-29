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
motorEmissionData <- NEI[which(NEI$SCC %in% SCC[grep("motor",SCC$SCC.Level.Three,ignore.case = TRUE),"SCC"] & NEI$fips=="24510"),]

#creating png file
png(filename = "plot5.png", width = 480, height = 480, units = "px", bg = "transparent")
par(mar=c(4,4,4,4))
#plotting the graph
g<-ggplot(motorEmissionData, aes(year,Emissions))
g+geom_line(stat = "summary", fun.y="sum")+ labs(y="Emissions from motor vehicles in Baltimore City (1999-2008)",x="Year")

dev.off()


