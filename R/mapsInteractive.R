library(mapview)

## Data (see getData)
ONT <- getData(country = "CAN", level = 1, path = "data/")[11,]

mapview(ONT)@map
