NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

years <- c(1999, 2002, 2005, 2008)
city <- c("24510", "06037")
NEI <- NEI[NEI$fips %in% city, ]
SCC <- SCC[grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE), ]
NEI <- NEI[NEI$SCC %in% SCC$SCC, ]
year_totals <- data.frame(matrix(data = NA, ncol = 3, nrow = 0))
names(year_totals) <- c("year", "total", "fips")
for (fips in city){
  tempdata_fips <- NEI[NEI$fips == fips,]
  for(year in years){
    tempdata <- tempdata_fips[tempdata_fips$year == year,]
    total <- sum(tempdata$Emissions)
    year_totals <- rbind(year_totals, data.frame(year, total, fips))
  }
}

# Needs to fix the y axis
names(year_totals) <- c("year", "total", "fips")
year_totals$fips <- as.character(year_totals$fips)

png(filename = "plot6.png", height = 480, width = 480)
plot(year_totals[year_totals$fips == "06037",]$year, year_totals[year_totals$fips == "06037",]$total, cex = 2, pch = 16, type = "b", col = "red", ylab = "Total PM2.5 emmitted (tons)", xlab = "Year", main = "Total Emmisions from Motor Vehicles in Baltimore City ", ylim = c(100,10000))
lines(year_totals[year_totals$fips == "24510",]$year, year_totals[year_totals$fips == "24510",]$total, cex = 2, pch = 15, col = "blue", type = "b")
legend(2005.5,10000, legend = c("Baltimore City", "Los Angeles"), col = c("Blue", "red"), pch = c(15,16), cex=.9)
dev.off()
