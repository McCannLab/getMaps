#' @param file_lu file pf LU file
#' @param sf sf object
extract_sf <- function(file_lu, sf) {
  ra <- raster(file_lu)
  extract(ra, st_transform(sf, crs = projection(ra)))
}

#' @param file_lu file pf LU file
#' @param sf sf object
#' @param buf buffer distance
extract_sf_buf <- function(file_lu, sf, buf) {
  ra <- raster(file_lu)
  extract(ra, st_buffer(st_transform(sf, crs = projection(ra)), buf))
}


#' @param xy coordinates of points to be used to do the extraction
#' @param buf buffer
#' @param crs coordinates reference system
extract_from_coords <- function(file_lu, xy, crs, buf) {
  ra <- raster(file_lu)
  st_as_sf(xy, coords = 1:2)
  extract(ra, st_transform(sf, crs = projection(ra)))
}



#' @param vc_lu vector of Land Use value
#' @param perc logical. Should the results be expressed as a percentage? Note that given that some categories are discarded this may not sum up to 1.
simplify_lu <- function(vc_lu, perc = TRUE) {
  # NB 11 => unclassified (see guide)
  # 31 => water
  # 91 zones rocheuse, plages ...
  out <- data.frame(
    # Forest Wetlands Trees Wetland unmannaged grassland
    natural = sum(vc_lu %in% c(41, 42, 45, 46, 62, 71, 73, 74)),
    # settlement and roads
    urban = sum(vc_lu %in% c(21, 25)),
    # crops and grassland managed
    agricultural = sum(vc_lu %in% c(51, 61:62))
  )
  if (perc) out/length(vc_lu) else out
}


simplify_lu2 <- function(vc_lu, perc = TRUE) {

  out <- data.frame(
    unclassified = 11,
    settlement = 21,
    roads = 25,
    water = 31,
    forest = 41, 
    forest_wetland = 42,
    trees = 45,
    tress_wetland = 46,
    cropland = 51,
    grassland_managed = 61,
    grassland_unmanaged = 62,
    wetland = 71, 
    wetland_shrub = 73,
    wetland_herd = 74, 
    other_land = 91
  )
  
  for (i in 1:NCOL(out)) {
    out[1, i] <- sum(vc_lu == out[1, i])
  }
  
  if (perc) out/length(vc_lu) else out
}




# Example
library(raster)
library(sf)
pts <- st_as_sf(
  read.csv("csvFiles/emily_site_coords.csv"),
  coords = c("long", "lat"),
  crs = 4326) # %>% st_transform(crs = 3161)

# this file was downloaded -- your path will be different
fl <- "/media/kevcaz/hijo92/Data/landUse/IMG_AAFC_LANDUSE_Z17_2010/IMG_AAFC_LANDUSE_Z17_2010.tif"

extract_sf(fl, pts)


bufs <- c(40, 60, 80, 100, 150, 200, 250, 500, 1000, 2000)
res <- list()
for (i in seq_along(bufs)) {
  res[[i]] <- extract_sf_buf(fl, pts, bufs[i])
}

saveRDS(res, "land_use_raw.rds")

res_simplified <- lapply(
  res,
  function(x) cbind(
    sitecode = pts$sitecode,
    do.call(rbind, lapply(x, simplify_lu))
  )
)

res_simplified2 <- lapply(
  res,
  function(x) cbind(
    sitecode = pts$sitecode,
    do.call(rbind, lapply(x, simplify_lu2))
  )
)
# check 
# lapply(res_simplified2, function(x) apply(x[, -1], 1, sum))

names(res_simplified) <- paste0("bdist_", bufs)
saveRDS(res_simplified, "land_use_simplified.rds")
