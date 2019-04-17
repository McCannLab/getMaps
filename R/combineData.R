library(raster)
library(rgdal)
library(sp)

getListFiles <- function(info = "bash/data60/bio", subinfo = "bio60_01", years = 1970:1979) {
  as.list(paste0(info, years, "/", subinfo, ".asc"))
}


## Temperature
rasAHI <- calc(stack(getListFiles(years = 1970:1979)), mean)
rasBSM <- calc(stack(getListFiles(years = 2000:2009)), mean)

ONT <- getData(country = "CAN", level = 1, path = "data/")[9,]
cc <- crop(.1*(rasBSM - rasAHI), ONT)
saveRDS(cc, "data/delta_temp_ontarion.rds")

plot(mask(cc, ONT))

## Precipitation
raspAHI <- calc(stack(getListFiles(years = 1970:1979, subinfo = "bio60_12")), mean)
raspBSM <- calc(stack(getListFiles(years = 2000:2009, subinfo = "bio60_12")), mean)

pcp <- crop(raspBSM - raspAHI, ONT)
plot(pcp)
saveRDS(pcp, "data/delta_prec_ontarion.rds")

plot(mask(pcp, ONT))
