setwd("C:/lakshmi/Data Science/coursera/assignments/Exploratory Data Analysis")

# reading data
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

# Adding up emission data for each year
totalEmissionPerYear <- tapply(NEI$Emissions, NEI$year, sum)

# plotting the totals
barplot(totalEmissionPerYear, xlab = "Year", ylab = "Total Emission (ton)", 
        main = "Total Emission per year")

## Saving to file
dev.copy(png, file="NEA_plot1.png", height=480, width=480)

dev.off()