setwd("C:/Users/mhsteiner/Documents/R/Week 4_Exploring_data")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI <- NEI[NEI$fips == "24510", ]
types <- unique(NEI$type)
years <- c(1999, 2002, 2005, 2008)


year_totals <- data.frame(matrix(data = NA, ncol = 3, nrow = 0))
names(year_totals) <- c("year", "total", "fips")
for (type in types){
  tempdata_item <- NEI[NEI$type == type,]
  for(year in years){
    tempdata <- tempdata_item[tempdata_item$year == year,]
    total <- sum(tempdata$Emissions)
    year_totals <- rbind(year_totals, data.frame(year, total, type))
  }
}
p <- qplot(year_totals$year, year_totals$total, data = year_totals ,colour = type, size = I(2.5), main = "Total Emissions per year in Baltimore City", xlab = "Year", ylab = "Total PM2.5 emmitted (tons)")
p
