setwd("C:/lakshmi/Data Science/coursera/assignments/Exploratory Data Analysis")

# reading data
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

# reading and subsetting data belonging to Baltimore city
BaltimoreData <- subset(NEI, fips == "24510")

#load ggplot2 library
library(ggplot2)

# summing emission data per year,  per type, of Baltimore city
data <- aggregate(Emissions ~ year + type, BaltimoreData, sum)

# plotting

# Add aesthetic mappings
g <- ggplot(data, aes(year, Emissions, color = type))

g + geom_line() +
  xlab("Year") +
  ylab(expression("Total PM"[2.5]*" Emissions")) +
  ggtitle("Total Emissions per Type in Baltimore")

## Saving to file
dev.copy(png, file="NEA_plot3.png", height=480, width=480)
#write plot to png
dev.off()