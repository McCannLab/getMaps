library(raster)
library(rgdal)
library(sp)
library(magrittr)

# Declare variables to store data
lakes <- readRDS("data/spLakeBSMAHI.rds")
# lakes_pcp <- lakes_cmi <- lakes_sg <- readRDS("data/spLakeBSMAHI.rds")

getClimateData <- function(info = "bio", years = 1940:2012) {
  lakes_tmp  <- lakes
  ## Create a list of raster
  for (year in years) {
    cat(year, " ...... ")
    nm_fo <- paste0("bash/data/", info, year)
    vc_fl <- list.files(nm_fo, pattern = "*.asc", full.names = T)
    #
    tmp <- lapply(vc_fl, raster) %>%
      lapply(FUN = function(x) raster::extract(x, y = lakes)) %>%
      do.call(cbind, .) %>% as.data.frame
    #
    names(tmp) <- paste0("CD_", year, "_",
      gsub(list.files(nm_fo, pattern = "*asc"), pat = ".asc", rep = ""))
    #
    lakes_tmp@data %<>% cbind(tmp)
    cat("done \n")
  }

  saveRDS(lakes_tmp, paste("climateData/lakes_", info, ".rds"))
}

getClimateData("bio")
getClimateData("cmi")
