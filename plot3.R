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

## Question 3
#==============================================================================================
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system
# to make a plot answer this question.

library(dplyr)
library(ggplot2)

NEI_BC <- NEI %>%
    filter(fips == "24510") %>%
    group_by(year, type) %>%
    summarise(totalEmissions = sum(Emissions))

png("plot3.png", width = 480, height = 480)

ggplot(data = NEI_BC, aes(x = factor(year), y = totalEmissions, fill = type)) +
    geom_bar(stat="identity") +
    facet_grid(. ~ type) +
    labs(x = "Years", y = "Total emissions",
         title = "Total emissions in the Baltimore City by four types of sources") +
    theme(axis.text.x=element_text(angle = 90, vjust = 0.5, hjust = 1)) +
    scale_fill_discrete(name = "Type of source")

dev.off()
