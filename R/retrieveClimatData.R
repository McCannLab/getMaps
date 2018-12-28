dir.create("climateData/")

#ftp://ftp.nrcan.gc.ca/pub/outgoing/NAM_grids
basurl <- "ftp://ftp.nrcan.gc.ca/pub/outgoing/NAM_grids/zipfiles300/"
# one among "bio", "cmi", "mint", "maxt", "pcp", "sg"
info <- "maxt"
# either "_300arcsec.zip" or "_60arcsec.zip"
# 300 arcsec = 10 squared kilometers. 60 arcsec = 2 squared kilometers
end <- "_300arcsec.zip"

# year available: from 1900 to 2017
for (year in 1938:2010) {
  zout <- paste0("climateData/", info, year, ".zip")

  download.file(
    paste0(basurl, info, year, end),
    destfile = zout)

  unzip(zout, exdir = "climateData")
}
