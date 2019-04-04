## tertionary watersheds! NB too heavy to put on GH!
library(sp)
library(rgdal)
watSheds3 <- spTransform(readOGR("data/tertionaryWatersheds/WATERSHED_TERTIARY.shp"), bouCAN@proj4string)

saveRDS(watSheds3, "data/watSheds3.rds")
