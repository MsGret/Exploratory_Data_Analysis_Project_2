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

## Question 6
#==============================================================================================
# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

library(dplyr)
library(ggplot2)

SCC_MV <- SCC[grep("Mobile.*Vehicles", SCC$EI.Sector), ]$SCC

NEI_MV <- NEI %>%
    filter(SCC %in% SCC_MV & (fips == "24510" | fips == "06037")) %>%
    group_by(fips, year) %>%
    summarise(totalEmissions = sum(Emissions))

NEI_MV$fips <- replace(NEI_MV$fips, NEI_MV$fips == "24510", "Baltimore")
NEI_MV$fips <- replace(NEI_MV$fips, NEI_MV$fips == "06037", "Los Angeles")


png("plot6.png", width = 480, height = 480)

ggplot(data = NEI_MV, aes(x = factor(year), y = totalEmissions, fill = year,
                          label = round(totalEmissions, 2))) +
    geom_bar(stat="identity") +
    facet_grid(fips ~ .) +
    labs(x = "Years", y = "Total emissions",
         title = "Total emissions from motor vehicle sources \n in Baltimore City and Los Angeles") +
    geom_label(color = "white", fontface = "bold")

dev.off()
