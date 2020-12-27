setwd("C:/lakshmi/Data Science/coursera/assignments/Exploratory Data Analysis")

# reading data
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")
# reading and subsetting data
BaltimoreData <- subset(NEI, fips == "24510")

# summing emissions for each year for Baltimore data
totalEmissions <- tapply(BaltimoreData$Emissions, BaltimoreData$year, sum)

# plotting
barplot(totalEmissions, xlab = "Year", ylab = "Total Emission (ton)", 
        main = "Total Emission per year in Baltimore")

## Saving to file
dev.copy(png, file="NEA_plot2.png", height=480, width=480)

dev.off()