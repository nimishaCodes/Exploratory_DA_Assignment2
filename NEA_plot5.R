setwd("C:/lakshmi/Data Science/coursera/assignments/Exploratory Data Analysis")

# reading data
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

# reading and subsetting data belonging to Baltimore city
BaltimoreData <- subset(NEI, fips == "24510")

# subsetting SCC with vehicle values
vehicleRelated  <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)

SCC_vehicleSubset <- SCC[vehicleRelated, ]

# merging NEI and SCC data on vehicle
NEI_And_SCC <- merge(BaltimoreData, SCC_vehicleSubset, by="SCC")

# summing emission data per year per type
EmissionsPerYearAndType <- tapply(NEI_And_SCC$Emissions, NEI_And_SCC$year, sum)

# plotting
barplot(EmissionsPerYearAndType, xlab = "Year", ylab = "Total Emission (ton)", 
        main = "Total Emission from Motor Vehicle sources in Baltimore")

## Saving to file
dev.copy(png, file="VehicleBaltimore_plot.png", height=480, width=480)

#write plot to png
dev.off()