NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

years <- c(1999, 2002, 2005, 2008)

NEI <- NEI[NEI$fips == "24510", ]
year_totals <- data.frame(matrix(data = NA, ncol = 2, nrow = 0))
names(year_totals) <- c("year", "total")
for(year in years){
  tempdata <- NEI[NEI$year == year,]
  total <- sum(tempdata$Emissions)
  year_totals <- rbind(year_totals, data.frame(year, total/1000))
}

png(filename = "plot2.png", height = 480, width = 480)
plot(year_totals$year, year_totals$total, cex =2, pch = 16,  type = "b", col = "red", ylab = "Total PM2.5 emmitted (thousand tons)", xlab = "Year", main = "Total Emmision from All Sources in Baltimore City")
dev.off()