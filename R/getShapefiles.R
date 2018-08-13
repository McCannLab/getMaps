## make lakes a shapefile
library(sf)
lakes <- readRDS("data/lakes_ont.rds")

lakes_sf <- st_as_sf(
  x = lakes,
  coords = c("Longitude_decimal_degrees_", "Latitude_decimal_degrees_"),
  crs = 4326)

st_write(lakes_sf, "shapefiles", "lakes_BSM.shp", driver = "ESRI Shapefile")
