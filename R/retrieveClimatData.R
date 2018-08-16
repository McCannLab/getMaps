dir.create("climateData/")

basurl <- "ftp://ftp.nrcan.gc.ca/pub/outgoing/NAM_grids/zipfiles300/"
info <- "maxt"
end <- "_300arcsec.zip"


for (year in 2008:2012) {
  zout <- paste0("climateData/", info, year, ".zip")

  download.file(
    paste0(basurl, info, year, end),
    destfile = zout,
    method = "wget")

  unzip(zout, exdir = "climateData")
}
