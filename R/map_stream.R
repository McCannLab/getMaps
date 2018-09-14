library(sf)
library(raster)
# to install graphicsutils
# devtools::install_github("inSileco/graphicsUtrils")
library(graphicsutils)

#
bouCAN0 <- getData(country='CAN', level=0, path="data/") %>% st_as_sf %>% st_simplify(FALSE, 0.01)
bouUSA0 <- getData(country='USA', level=0, path="data/") %>% st_as_sf %>% st_simplify(FALSE, 0.01)
bouCAN <- getData(country='CAN', level=1, path="data/") %>% st_as_sf
bouUSA <- getData(country='USA', level=1, path="data/") %>% st_as_sf
altONT <- readRDS("data/altONT.rds")
## Lakes
lkOnt <- st_read("data/hydro_p_LakeOntario/hydro_p_LakeOntario.shp")
lkMic <- st_read("data/hydro_p_LakeMichigan/hydro_p_LakeMichigan.shp")
lkHur <- st_read("data/hydro_p_LakeHuron/hydro_p_LakeHuron.shp")
lkSup <- st_read("data/hydro_p_LakeSuperior/hydro_p_LakeSuperior.shp")
lkStc <- st_read("data/hydro_p_LakeStClair/hydro_p_LakeStClair.shp")
lkEri <- st_read("data/hydro_p_LakeErie/hydro_p_LakeErie.shp")
#
lakes <- readRDS("data/lakes_ont.rds")
#
watSheds3 <- readRDS("data/watSheds3.rds") %>% st_as_sf %>% st_simplify(FALSE, .002)
#
id <- c(36:38, 27, 43:44, 62:64)
#
myblue <- "#9fceec"
add_lakes <- function() {
  lkOnt %>% st_geometry %>% plot(add = TRUE, col = myblue, border = NA)
  lkMic %>% st_geometry %>% plot(add = TRUE, col = myblue, border = NA)
  lkHur %>% st_geometry %>% plot(add = TRUE, col = myblue, border = NA)
  lkSup %>% st_geometry %>% plot(add = TRUE, col = myblue, border = NA)
  lkStc %>% st_geometry %>% plot(add = TRUE, col = myblue, border = NA)
  lkEri %>% st_geometry %>% plot(add = TRUE, col = myblue, border = NA)
}


png(file = "fig/fig_stream.png", width = 8, height = 6, units = "in", res =300)

par(mar = c(4.5, 4.5, 2.5, 2.5), las = 1)
plot0(c(-85, -73.2), c(41.5, 46.2), fill = myblue)
plot(st_geometry(bouCAN[11,]), add = TRUE, col = NA, border = NA)
plot(st_geometry(bouCAN0), add = TRUE, col = "#cbb583", border = NA)
plot(st_geometry(bouUSA0), add = TRUE, col = "#c5e6b8", border = NA)
plot(st_geometry(bouCAN[11,]), add = TRUE, col = "grey90", border = NA)
add_lakes()
plot(st_geometry(watSheds3[id, ]), col = "grey50", add = TRUE, border = "grey25", lwd = .5)
text(st_coordinates(st_centroid(watSheds3[id, ])), labels = 1:9)
##
plot(st_geometry(bouCAN[11,]), add = TRUE, col = NA, border = "grey15", lwd = 1.2)
axis(1, lwd = .9)
title(xlab = "longitude (degree)", ylab = "latitude (degree)")
axis(2, lwd = .9)
axis(3, lwd = .9)
axis(4, lwd = .9)
box2(lwd = 1.1)

par(new = TRUE, fig = c(.58, .985, 0.015, .55))
plot0(c(-95, -72), c(41, 57), fill = myblue)
plot(st_geometry(bouCAN0), add = TRUE, col = "#cbb583", border = NA)
plot(st_geometry(bouUSA0), add = TRUE, col = "#c5e6b8", border = NA)
plot(st_geometry(bouCAN[11,]), add = TRUE, col = "grey90", border = NA)
add_lakes()
plot(st_geometry(watSheds3[id, ]), col = "grey40", add = TRUE, border = "grey25", lwd = .5)
rect(-85, 41.5, -73.2, 46.2, lwd = .5)
box2(lwd = .9)

dev.off()
