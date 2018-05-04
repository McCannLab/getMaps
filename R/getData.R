##-- packages
library(raster)

##-- Create a Data directory
dir.create("data")

##-- check iso3
getData("ISO3")

##-- Retrieve administrative boundaries
# Canada
getData(country = "CAN", level = 0, path = "data/")
# Canada's provinces
getData(country = "CAN", level = 1, path = "data/")
# Canada's elevation
getData("alt", country = "CAN", path = "data/")
# USA
getData(country = "USA", level = 0, path = "data/")


# Sweden
getData(country = "SWE", level = 0, path = "data/")

# Japan
getData(country = "JPN", level = 0, path = "data")
