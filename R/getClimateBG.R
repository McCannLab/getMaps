library(raster)

bouONT <- getData(country='CAN', level=1, path="data/")[11,]

ls_mxt <- list()

k <- 0
for (year in 2008:2012) {
  k <- k + 1
  ra <- raster(paste0("climateData/", year, "/maxt_07.asc"))
  ls_mxt[[k]] <- rasterize(x = bouONT, y = crop(ra, bouONT@bbox), mask = T)
}

mxt_st <- do.call(stack, ls_mxt)
plot(mxt_st, col = colorRampPalette(c("#0c233e", "#4fa9d0", "#f2eeae"))(256))
