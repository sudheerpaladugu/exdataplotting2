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

#selecting Baltimore data & required columns for 4 types of sources
bmYearlyCount<- subset(NEI,fips="24510")

#creating png file
png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "transparent")
par(mar=c(4,4,4,4))
#plotting the graph
g <-ggplot(bmYearlyCount,aes(year,Emissions,color=type))
g + geom_line(stat = "summary",fun.y="sum")+ labs(y="Emissions for Baltimore City",x="Year")

dev.off()


