library(raster)
library(rgdal)
library(sp)
library(magrittr)

# lakes_pcp <- lakes_cmi <- lakes_sg <- readRDS("data/spLakeBSMAHI.rds")

getClimateData <- function(info = "bio", years = 1980:1999, basename = "climateData/lakes_", lakes = readRDS("data/spLakeBSMAHI.rds")) {
  out <- lakes
  ## Create a list of raster
  for (year in years) {
    cat(year, " ...... ")
    nm_fo <- paste0("bash/data/", info, year)
    vc_fl <- list.files(nm_fo, pattern = "*.asc", full.names = TRUE)
    #
    tmp <- lapply(vc_fl, raster) %>%
      lapply(FUN = function(x) raster::extract(x, y = lakes)) %>%
      do.call(cbind, .) %>%
      as.data.frame
    #
    names(tmp) <- paste0("CD_", year, "_",
      gsub(list.files(nm_fo, pattern = "*asc"), pat = ".asc", rep = ""))
    #
    out@data <- cbind(out@data, tmp)
    cat("done \n")
  }

  saveRDS(out, paste0(basename, info, ".rds"))
  out
}

# getClimateData("bio", years = 1980:1999)
# getClimateData("cmi")
# getClimateData("pcp")
# getClimateData("mint")
# getClimateData("maxt")
# getClimateData("sg", years = 1980)
