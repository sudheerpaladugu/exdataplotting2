if(!require(dplyr)){
   install.packages("dplyr")
}

cdFile <- "./data/exdata-data-NEI_data/Source_Classification_Code.rds"
emFile <- "./data/exdata-data-NEI_data/summarySCC_PM25.rds"
#Reading data from RDS
SCC <- readRDS(cdFile)
NEI <- readRDS(emFile)
#selecting required columns from data frame
subNEI <- select(NEI, c(4,6))
#getting yearly counts
yearlyCount <- aggregate(subNEI$Emissions, by = list(subNEI$year),sum)
#creating png file
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
par(mar=c(4,4,4,4))
#plotting the graph
plot(x=yearlyCount$Group.1, y=yearlyCount$x, type="b",  pch=19, main = 'Emissions counts (1999 - 2008)', xlab = " Year", ylab = "Total Emissions")
dev.off()