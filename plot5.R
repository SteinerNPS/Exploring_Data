setwd("C:/Users/mhsteiner/Documents/R/Week 4_Exploring_data")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

years <- c(1999, 2002, 2005, 2008)

NEI <- NEI[NEI$fips == "24510", ]
SCC <- SCC[grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE), ]
NEI <- NEI[NEI$SCC %in% SCC$SCC, ]
year_totals <- data.frame(matrix(data = NA, ncol = 2, nrow = 0))
names(year_totals) <- c("year", "total")
for(year in years){
  tempdata <- NEI[NEI$year == year,]
  total <- sum(tempdata$Emissions)
  year_totals <- rbind(year_totals, data.frame(year, total))
}
plot(year_totals$year, year_totals$total, cex = 2, pch = 16, col = "red", ylab = "Total PM2.5 emmitted (tons)", xlab = "Year", main = "Total Emmisions from Motor Vehicles in Baltimore City ")

