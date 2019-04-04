#' Retrieve raster of climate data from ftp://ftp.nrcan.gc.ca/pub/outgoing/NAM_grids
#'
#' @param years vector of selected years (numeric).
#' @param info a character string specifying the kind of data to be retrieved. One among "bio", "cmi", "mint", "maxt", "pcp", "sg". Default is set to "bio".
# # 300 arcsec = 10 squared kilometers. 60 arcsec = 2 squared kilometers
#' @param res resolution of the raster files to be downloaded in arcsec. Either 60 or 300, default is set to 300.
#' @param path folder where files will be stored.
#' @param keep_zip a logical. Should zip files be kept? Default is set to `FALSE`.

retrieveClimateData <- function(years = 1900:2015,
  info =  c("bio", "cmi", "mint", "maxt", "pcp", "sg"), res = 300,
  path = "climateData/", keep_zip = FALSE) {

  stopifnot(res %in% c(60, 300))
  dir.create(path, showWarnings = FALSE)
  #
  basurl <- "ftp://ftp.nrcan.gc.ca/pub/outgoing/NAM_grids/zipfiles"
  #
  info <- match.arg(info)
  beg <- paste0(basurl, res, "/")
  end <- paste0("_", res, "arcsec.zip")
  # year available: from 1900 to 2017
  for (year in years) {
    zout <- paste0("path", info, year, ".zip")
    print(paste0(beg, info, year, end))
    download.file(paste0(beg, info, year, end), destfile = zout)
    unzip(zout, exdir = "climateData")
    if (!keep_zip) unlink(zout)
  }
}
