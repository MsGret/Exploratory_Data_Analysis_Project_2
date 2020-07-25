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

## Question 4
#==============================================================================================
# Across the United States, how have emissions from coal combustion-related sources changed
# from 1999–2008?

library(dplyr)
library(ggplot2)

SCC_coal <- SCC[grep("Fuel Comb.*Coal", SCC$EI.Sector), ]$SCC


NEI_coal <- NEI %>%
    filter(SCC %in% SCC_coal) %>%
    group_by(year) %>%
    summarise(totalEmissions = sum(Emissions))

png("plot4.png", width = 480, height = 480)

ggplot(data = NEI_coal, aes(x = factor(year), y = totalEmissions / 1000, fill = year,
                            label = round(totalEmissions / 1000, 2))) +
    geom_bar(stat="identity") +
    labs(x = "Years", y = "Total emissions  (in kilotons)",
         title = "Total emissions from coal combustion-related sources") +
    geom_label(color = "white", fontface = "bold")

dev.off()
