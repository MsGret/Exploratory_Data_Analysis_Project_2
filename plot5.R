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

## Question 5
#==============================================================================================
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

library(dplyr)
library(ggplot2)

SCC_MV <- SCC[grep("Mobile.*Vehicles", SCC$EI.Sector), ]$SCC

NEI_MV <- NEI %>%
    filter(SCC %in% SCC_MV & fips == "24510") %>%
    group_by(year) %>%
    summarise(totalEmissions = sum(Emissions))

png("plot5.png", width = 480, height = 480)

ggplot(data = NEI_MV, aes(x = factor(year), y = totalEmissions, fill = year,
                          label = round(totalEmissions, 2))) +
    geom_bar(stat="identity") +
    labs(x = "Years", y = "Total emissions",
         title = "Total emissions from motor vehicle sources in Baltimore City") +
    geom_label(color = "white", fontface = "bold")

dev.off()
