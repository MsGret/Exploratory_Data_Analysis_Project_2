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

## Question 2
#==============================================================================================
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering
# this question.

library(dplyr)

NEI_BC <- NEI %>%
    filter(fips == "24510") %>%
    group_by(year) %>%
    summarise(totalEmissions = sum(Emissions))

png("plot2.png", width = 480, height = 480)

bp <- barplot(height = NEI_BC$totalEmissions, names.arg = NEI_BC$year,
              col = c("orange", "yellow", "green", "cyan"),
              ylim = c(0, 4000),
              xlab = "Years", ylab = "Total emissions",
              main = "Total emissions from PM2.5 in the Baltimore City")

lines(x = bp, NEI_BC$totalEmissions, lwd = 3)
text(x = bp, y = NEI_BC$totalEmissions, label = round(NEI_BC$totalEmissions, 2),
     pos = 3, offset = 2)

dev.off()
