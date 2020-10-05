# ontarioSpatialData

Collection of R scripts to retrieve data and create maps.



## Installation

```R
install.packages("remotes")
remotes::install_github("inSileco/graphicsutils")  # https://github.com/inSileco/graphicsutils
install.packages(c("sf", "sp", "rgeos", "raster", "tidyverse", "rgdal"))
```



## Data

### Climate data

- Source: http://cfs.nrcan.gc.ca/projects/3/8

There is two ways to retrieve climate data:

1. use the bash script: `getMaps.sh` in  `bash/`;

```shell
cd bash
sh getMaps.sh
```

2. use `retrieveClimatData()`.

```R
source("R/retrieveClimateData.R")
retrieveClimateData(years = 2014:2015, info = "bio", res = 300)
```



## Elevation Data

- Elevation data as well as administrative boundaries are retrieved using `getData()` from raster package.


## Lakes and watersheds

In `data/` are included shapefiles for Great Lakes and watersheds:

- Sources:
  - Great lakes shapefiles available at: https://www.sciencebase.gov/catalog/item/530f8a0ee4b0e7e46bd300dd
  - Tertiary watersheds: https://www.ontario.ca/data/watershed-tertiary
  - Secondary watersheds: https://www.ontario.ca/data/watershed-secondary


### Land Use data

See https://open.canada.ca/data/en/dataset/18e3ef1a-497c-40c6-8326-aac1a34a0dec.
The description of the categories is in the [ISO 19131 – Land Use 1990, 2000, 2010 Data Product Specifications](http://www.agr.gc.ca/atlas/supportdocument_documentdesupport/aafcLand_Use/en/ISO_19131_Land_Use_1990__2000_2010_Data_Product_Specifications.pdf)



## Maps

See `R/basicMaps.R`

![](fig/basic.png)





## References

If you need to learn more about how to manipulate GIS data using R, have a look at this tutorial on [inSileco](https://insileco.github.io/tuto/rinspace/rinspace_homepage/).
