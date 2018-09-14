# getMaps

A couple of R scripts to create maps.


## R packages required

- graphicsutils, see https://github.com/inSileco/graphicsutils
- [mapview](https://cran.r-project.org/web/packages/mapview/index.html) which
imports all packages required.


## Data

- Elevation data as well as administrative boundaries are retrieved using `getData()`
from the `raster` but not included in the repository the get these data source
`getData.R`:

```r
source("getData.R")
```

- Great lakes shapefiles available at: https://www.sciencebase.gov/catalog/item/530f8a0ee4b0e7e46bd300dd

- Tertiary watersheds: https://www.ontario.ca/data/watershed-tertiary

- Secondary watersheds: https://www.ontario.ca/data/watershed-secondary

## Maps

### Basic map

![](fig/basic.png)

### Custom map

![](fig/custom.png)

### Map Stream

![](fig/map_stream.png)




## References

1. See tutorials on [inSileco](https://insileco.github.io/2018/04/14/r-in-space---a-series/created)

2. and a very helpful representation by @mhBrice: https://mhbrice.github.io/Rspatial/

Both links above include a list of useful resources.
