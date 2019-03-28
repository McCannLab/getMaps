library(raster)
library(rgdal)
library(sp)

getListFiles <- function(info = "bash/data/bio", subinfo = "bio_01", years = 1980:1999) {
  as.list(paste0(info, years, "/", subinfo, ".asc"))
}

ras <- stack(getListFiles())
rasm <- calc(ras, mean)

ONT <- getData(country = "CAN", level = 1, path = "data/")[9,]
plot(mask(crop(rasm, ONT), ONT))
