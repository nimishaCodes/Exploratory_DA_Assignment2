setwd("C:/lakshmi/Data Science/coursera/assignments/Exploratory Data Analysis")

# reading data
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

# reading and subsetting data belonging to Baltimore city
BaltimoreData <- subset(NEI, fips == "24510")

# reading and subsetting data belonging to LosAngeles
LosAngelesData <- subset(NEI, fips == "06037")

# subsetting SCC with motor vehicle values

vehicleRelated  <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)

SCC_vehicleSubset <- SCC[vehicleRelated, ]

# merging NEI and SCC dataframes on Baltimore 
dat_Baltimore <- merge(BaltimoreData, SCC_vehicleSubset, by="SCC")
#add City column and label it Baltimore City
dat_Baltimore$city <- "Baltimore City"
# merging NEI and SCC dataframes on Los Angeles County
data_LosAngeles <- merge(LosAngelesData, SCC_vehicleSubset, by="SCC")
#add City column and label it Los Angeles County
data_LosAngeles$city <- "Los Angeles County"
#total data
data <- rbind(dat_Baltimore, data_LosAngeles)

# summing emission data per year per type
data <- aggregate(Emissions ~ year + city, data, sum)

# plotting
g <- ggplot(data, aes(year, Emissions, color = city))

g + geom_line() +
  xlab("Year") +
  ylab(expression("Total PM"[2.5]*" Emissions")) +
  ggtitle("Total Emissions from Motor Vehicle sources in Baltimore and Los Angeles")

## Saving to file
dev.copy(png, file="LA_and_Baltimore_plot.png", height=480, width=480)

#write plot to png
dev.off()