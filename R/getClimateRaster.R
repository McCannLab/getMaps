library(raster)
library(rgdal)
library(sp)
library(RCurl)
#
bouCAN <- getData(country = "CAN", level = 1, path = "data/")

#
base_url <- "ftp://ftp.nrcan.gc.ca/pub/outgoing/NAM_grids/zipfiles300/"
year <- 1950
nm <- paste0("bio", year, "_300arcsec.zip")
download.file(
  paste0(base_url, nm),
  destfile = paste0("climateData/", nm), 
  method = "wget"
)

getURL(paste0(base_url, nm))
