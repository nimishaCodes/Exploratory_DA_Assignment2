setwd("C:/lakshmi/Data Science/coursera/assignments/Exploratory Data Analysis")

# reading data
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

# subsetting SCC on coal combustion-related sources 
coalRelated  <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
SCC_subset <- SCC[coalRelated, ]

# merging SCC data and NEI data by SCC column, getting only coal related data
coal_NEISCC <- merge(NEI, SCC_subset, by="SCC")

# summing emission data per year
totalCoalEmissions <- tapply(coal_NEISCC$Emissions, coal_NEISCC$year, sum)

# plotting
barplot(totalCoalEmissions, xlab = "Year", ylab = "Total Emission (ton)", 
        main = "Total Emission from Coal sources")

## Saving to file
dev.copy(png, file="CoalEmissions_plot.png", height=480, width=480)

#write plot to png
dev.off()
