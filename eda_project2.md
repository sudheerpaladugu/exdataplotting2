Exploratory Data Analysis - Course Project 2
============================================
  
  **NOTE: My work and answers to the questions are at the bottom of this document.**
  
  # Introduction
  
  Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the EPA National [Emissions Inventory web site](http://www.epa.gov/ttn/chief/eiinformation.html).

For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.

# Data

The data for this assignment are available from the course web site as a single zip file:
  
  * [Data for Peer Assessment [29Mb]](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip)

The zip file contains two files:
  
  PM2.5 Emissions Data (`summarySCC_PM25.rds`): This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year. Here are the first few rows.
````
##     fips      SCC Pollutant Emissions  type year
## 4  09001 10100401  PM25-PRI    15.714 POINT 1999
## 8  09001 10100404  PM25-PRI   234.178 POINT 1999
## 12 09001 10100501  PM25-PRI     0.128 POINT 1999
## 16 09001 10200401  PM25-PRI     2.036 POINT 1999
## 20 09001 10200504  PM25-PRI     0.388 POINT 1999
## 24 09001 10200602  PM25-PRI     1.490 POINT 1999
````

* `fips`: A five-digit number (represented as a string) indicating the U.S. county
* `SCC`: The name of the source as indicated by a digit string (see source code classification table)
* `Pollutant`: A string indicating the pollutant
* `Emissions`: Amount of PM2.5 emitted, in tons
* `type`: The type of source (point, non-point, on-road, or non-road)
* `year`: The year of emissions recorded

Source Classification Code Table (`Source_Classification_Code.rds`): This table provides a mapping from the SCC digit strings int he Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more specific and you may choose to explore whatever categories you think are most useful. For example, source "10100101" is known as "Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal".

You can read each of the two files using the `readRDS()` function in R. For example, reading in each file can be done with the following code:
  
  ````
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
````

as long as each of those files is in your current working directory (check by calling `dir()` and see if those files are in the listing).

# Assignment

The overall goal of this assignment is to explore the National Emissions Inventory database and see what it say about fine particulate matter pollution in the United states over the 10-year period 1999-2008. You may use any R package you want to support your analysis.

## Making and Submitting Plots

For each plot you should

* Construct the plot and save it to a PNG file.
* Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You should also include the code that creates the PNG file. Only include the code for a single plot (i.e. plot1.R should only include code for producing plot1.png)
* Upload the PNG file on the Assignment submission page
* Copy and paste the R code from the corresponding R file into the text box at the appropriate point in the peer assessment.

In preparation we first ensure the data sets archive is downloaded and extracted.



We now load the NEI and SCC data frames from the .rds files.


```r
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
```

## Questions

You must address the following questions and tasks in your exploratory analysis. For each question/task you will need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.

### Question 1

First we'll aggregate the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.


```r
library(dplyr)
yearlyCount <- aggregate(subNEI$Emissions, by = list(subNEI$year),sum)
```

Using the base plotting system, now we plot the total PM2.5 Emission from all sources,


```r
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
par(mar=c(4,4,4,4))
plot(x=yearlyCount$Group.1, y=yearlyCount$x, type="b",  
pch=19, main = 'Emissions counts (1999 - 2008)', 
xlab = " Year", ylab = "Total PM 2.5 Emissions")
```

![plot of chunk plot1](plot1.png) 

**Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?**

As we can see from the plot, total emissions have decreased in the US from 1999 to 2008.

### Question 2

First we aggregate total emissions from PM2.5 for Baltimore City, Maryland (fips="24510") from 1999 to 2008.


```r
library(dplyr)
bmNEI <- select(filter(NEI,fips == "24510"), c(4,6))
bmYearlyCount <- aggregate(Emissions ~ year, bmNEI,sum)
```

Now we use the base plotting system to make a plot of this data,


```r
plot(x=bmYearlyCount$year, y=bmYearlyCount$Emissions, type="b",  
pch=19, main = 'Baltimore City, MD - Emissions (1999 - 2008)', 
xlab = " Year", ylab = "PM2.5 Emissions")
```

![plot of chunk plot2](plot2.png) 

**Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?**

Overall total emissions from PM2.5 have decreased in Baltimore City, Maryland from 1999 to 2008.

### Question 3

Using the ggplot2 plotting system.

```r
library(dplyr)
library(ggplot2)

#selecting Baltimore data & required columns for 4 types of sources
bmYearlyCount<- subset(NEI,fips="24510")
#plotting the graph
g <-ggplot(bmYearlyCount,aes(year,Emissions,color=type))
g + geom_line(stat = "summary",fun.y="sum")+ labs(y="Emissions for Baltimore City",x="Year")

```

![plot of chunk plot3](plot3.png) 

**Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?**

The `non-road`, `nonpoint`, `on-road` source types have all seen decreased emissions overall from 1999-2008 in Baltimore City.

**Which have seen increases in emissions from 1999–2008?**

The `point` source saw a slight increase overall from 1999-2008. Also note that the `point` source saw a significant increase until 2005 at which point it decreases again by 2008 to just above the starting values. 

(Note that I did not catch this originally as I started off with a log scale on Emissions)


### Question 4

Using the ggplot2 plotting system. Subset coal combustion source factors NEI data,


```r
library(dplyr)
library(ggplot2)

# Subset coal combustion related NEI data
coalCombustionData <- NEI[which(NEI$SCC %in% SCC[ grep("coal", SCC$Short.Name, ignore.case = TRUE), "SCC"]),]

#plotting the graph
g <-ggplot(coalCombustionData, aes(year,Emissions))
g + geom_line(stat = "summary", fun.y="sum")+ labs(y="Emissions from coal combustion sources",x="Year")

```

![plot of chunk plot4](plot4.png) 

**Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?**

Emissions from coal combustion related sources have decreased from 600000 to below 4 from 1999-2008.

Eg. Emissions from coal combustion related sources have decreased by about 1/3 from 1999-2008!


### Question 5

We subset the motor vehicles, which we assume is anything like Motor Vehicle in SCC.Level.Two., and subset for motor vehicles in Baltimore,


```r
library(dplyr)
library(ggplot2)
motorEmissionData <- NEI[which(NEI$SCC %in% SCC[grep("motor",SCC$SCC.Level.Three,ignore.case = TRUE),"SCC"] & NEI$fips=="24510"),]
```

Finally we plot using ggplot2,


```r
#plotting the graph
g <-ggplot(motorEmissionData, aes(year,Emissions))
g + geom_line(stat = "summary", fun.y="sum")+ labs(y="Emissions from motor vehicles in Baltimore City (1999-2008)",x="Year")

```

![plot of chunk plot5](plot5.png) 

**How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?**

Emissions from motor vehicle sources have dropped from 1999-2008 in Baltimore City!

### Question 6

Comparing emissions from motor vehicle sources in Baltimore City (fips == "24510") with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"),


```r
library(dplyr)
library(ggplot2)

motorEmissionData <- NEI[which(NEI$SCC %in% SCC[grep("motor",SCC$SCC.Level.Three,ignore.case = TRUE),"SCC"]),] 
tco <- c("24510","06037")
multiMotorEmissionData <-subset(motorEmissionData,fips %in% tco)

```

Now we plot using the ggplot2 system,


```r

g <- ggplot(multiMotorEmissionData,aes(year, Emissions, color = fips))
g + geom_line(stat = "summary", fun.y="sum") + labs( y= "Emissions from motor vehicle for Los Angeles and Baltimore City (199-2008) ",x=" Year ") 
+ scale_colour_discrete(name = "City", label = c("Los Angeles","Baltimore"))

```

![plot of chunk plot6](plot6.png) 

**Which city has seen greater changes over time in motor vehicle emissions?**

Los Angeles County has seen the greatest changes over time in motor vehicle emissions.

