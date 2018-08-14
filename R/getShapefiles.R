## make lakes a shapefile
library(sf)
lakes <- readRDS("data/lakes_ont.rds")

lakes_ready <- lakes[, 2:4]
names(lakes_ready) <- c("id", "lon", "lat")
lakes_ready$id <- trimws(lakes_ready$id)
write.csv(lakes_ready, "lakes_BSM.csv",  row.names = FALSE)

lakes_sf <- st_as_sf(
  x = lakes,
  coords = c("Longitude_decimal_degrees_", "Latitude_decimal_degrees_"),
  crs = 4326)

st_write(lakes_sf, "shapefiles", "lakes_BSM.shp", driver = "ESRI Shapefile")


##########
lakes_bsm <- read.csv("csvFiles/lakes.csv")
lakes_bsm_sf <- st_as_sf(
  x = lakes_bsm[!is.na(lakes_bsm$Lat), 1:10],
  coords = c("Long", "Lat"),
  crs = 4326)

plot(st_geometry(lakes_bsm_sf)
