##-- packages
library(raster)

##-- check iso3
getData("ISO3")

##-- Retrieve administrative boundaries
# Canada
getData(country = "CAN", level = 0, path = "data/")
# Canada's provinces
bouCAN <- getData(country = "CAN", level = 1, path = "data/")
# Canada's elevation
altCAN  <- getData("alt", country = "CAN", path = "data/")
# Ontario elevation
altONT  <- rasterize(bouCAN[11,], crop(altCAN, extent(bouCAN[11,])))
saveRDS(altONT, 'data/altONT.rds')
# USA
getData(country = "USA", level = 0, path = "data/")


# Sweden
getData(country = "SWE", level = 0, path = "data/")

# Japan
getData(country = "JPN", level = 0, path = "data")
