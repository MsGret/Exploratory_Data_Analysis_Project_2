# Course Project 2

# Download the data for the project:
zipFilename <- "exdata_data_NEI_data.zip"

if (!file.exists("./Data")){
    dir.create(path = "./Data")
}

if(file.exists(zipFilename)) {        
    unzip(zipFilename, exdir = "./Data")
}

# PM2.5 Emissions Data
NEI <- readRDS("Data/summarySCC_PM25.rds")
head(NEI)

# Source Classification Code Table
SCC <- readRDS("Data/Source_Classification_Code.rds")
head(SCC)

## Question 1
#==============================================================================================
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources
# for each of the years 1999, 2002, 2005, and 2008.

totalEmissions <- tapply(NEI$Emissions, as.factor(NEI$year), sum)

png("plot1.png", width = 480, height = 480)

bp <- barplot(height = totalEmissions/1000, col = c("orange", "yellow", "green", "cyan"),
              ylim = c(0,8000),
              xlab = "Years", ylab = "Total emissions (in kilotons)",
              main = "Total emissions from PM2.5 in the U.S. from 1999 to 2008")

lines(x = bp, totalEmissions/1000, lwd = 3)
text(x = bp, round(totalEmissions/1000, 2), label = round(totalEmissions/1000, 2),
     pos = 1, offset = 2)

dev.off()
