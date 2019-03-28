library(raster)

## Data (see getData)
ONT <- getData(country = "CAN", level = 1, path = "data/")[9,]
JPN <- getData(country = "JPN", level = 0, path = "data/")
SWE <- getData(country = "SWE", level = 0, path = "data/")

png("fig/basic.png", unit = "in", res = 300, width = 9, height = 3.5)
  par(mfrow = c(1,3))
  plot(ONT, main = "Ontario")
  plot(JPN, main = "Japan")
  plot(SWE, main = "Sweden")
dev.off()
