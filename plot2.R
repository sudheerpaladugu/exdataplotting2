if(!require(dplyr)){
   install.packages("dplyr")
}

cdFile <- "./data/exdata-data-NEI_data/Source_Classification_Code.rds"
emFile <- "./data/exdata-data-NEI_data/summarySCC_PM25.rds"
#Reading data from RDS
SCC <- readRDS(cdFile)
NEI <- readRDS(emFile)

#selecting Baltimore data & required columns from data frame
bmNEI <- select(filter(NEI,fips == "24510"), c(4,6))

#getting baltimore yearly counts
bmYearlyCount <- aggregate(Emissions ~ year, bmNEI,sum)
#creating png file
png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "transparent")
par(mar=c(4,4,4,4))
#plotting the graph
plot(x=bmYearlyCount$year, y=bmYearlyCount$Emissions, type="b",  pch=19, main = 'Baltimore City, MD - Emissions (1999 - 2008)', xlab = " Year", ylab = "PM2.5 Emissions")
dev.off()


