library(raster)

## Ontario boundaries
bouONT <- getData(country='CAN', level=1, path="data/")[11,]


## Create a list of raster
ls_mxt <- list()
k <- 0
for (year in 2008:2012) {
  k <- k + 1
  # get July max temperature 
  ra <- raster(paste0("climateData/", year, "/maxt_07.asc"))
  ## crop
  ls_mxt[[k]] <- rasterize(x = bouONT, y = crop(ra, bouONT@bbox), mask = T)
}

## get a raster stack
mxt_st <- do.call(stack, ls_mxt)

plot(mxt_st, col = colorRampPalette(c("#0c233e", "#4fa9d0", "#f2eeae"))(256))
