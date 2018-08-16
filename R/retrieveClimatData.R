dir.create("climateData/")

#ftp://ftp.nrcan.gc.ca/pub/outgoing/NAM_grids
basurl <- "ftp://ftp.nrcan.gc.ca/pub/outgoing/NAM_grids/zipfiles300/"
# one among "bio", "cmi", "mint", "maxt", "pcp", "sg"
info <- "maxt"
# either "_300arcsec.zip" or "_60arcsec.zip"
# 300 = 10 squared kilometers. 60 = 2 squred kilometers
end <- "_300arcsec.zip"

# year available: from 1950 to 2013
for (year in 2008:2012) {
  zout <- paste0("climateData/", info, year, ".zip")

  download.file(
    paste0(basurl, info, year, end),
    destfile = zout,
    method = "wget")

  unzip(zout, exdir = "climateData")
}
