# getMaps

A couple of R scripts to create maps.


## Packages required

- graphicsutils, see https://github.com/inSileco/graphicsutils
- mapview
- raster
- sp
- sf (not used yet)


## Data

- Elevation data as well as administrative boundaries are retrieved using `getData()`
from the `raster` but not included in the repo the get these data source
`getData.R`:

```r
source("getData.R")
```

- Great lake shapefiles are available at: https://www.sciencebase.gov/catalog/item/530f8a0ee4b0e7e46bd300dd


## References

1. See tutorials on [inSileco](https://insileco.github.io/2018/04/14/r-in-space---a-series/created)

2. and a very helpful representation by @mhBrice: https://mhbrice.github.io/Rspatial/

Both links above include a list of useful resources.
