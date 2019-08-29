# Map for my manuscript on homogenization (few changes though)
library(sp)
library(raster)
library(rgdal)
library(rgeos)
library(graphicsutils)
library(inSilecoMisc)

bouCAN <- getData(country='CAN', level = 1, path="data/")
bouUSA <- getData(country='USA', level = 1, path="data/")
altONT <- readRDS("data/altONT.rds")
# see combine for the following
temp <- readRDS("data/delta_temp_ontario.rds")
prec <- readRDS("data/delta_prec_ontario.rds")
saveRDS(bouCAN[9, ], "data/GADM_ontario.rds")

##
lkOnt <- readOGR("data/hydro_p_LakeOntario/hydro_p_LakeOntario.shp")
lkMic <- readOGR("data/hydro_p_LakeMichigan/hydro_p_LakeMichigan.shp")
lkHur <- readOGR("data/hydro_p_LakeHuron/hydro_p_LakeHuron.shp")
lkSup <- readOGR("data/hydro_p_LakeSuperior/hydro_p_LakeSuperior.shp")
lkStc <- readOGR("data/hydro_p_LakeStClair/hydro_p_LakeStClair.shp")
lkEri <- readOGR("data/hydro_p_LakeErie/hydro_p_LakeErie.shp")
#
lakes <- readRDS("data/lakes_AHIBSM.rds")
# dim(lakes)
#
watSheds3 <- readRDS("data/watSheds3.rds")


ncolor <- 512
myblu <- '#6da6c2'
mygre <- 'grey50'
mypal <- colorRampPalette(c('#f0dec3', '#361f09'))(ncolor)


png(file = 'fig/map.png', res = 900, units = 'mm', width = 180, height = 90)
#
layout(rbind(c(2, 1, 3, 4), c(2, 1, 5, 6)), width = c(.26, 1.05, .55, .24))
par(las = 1, xaxs = 'i', yaxs = 'i', mar = rep(2.6, 4), tcl = -.4)
##
plot0(c(-96,-74), c(41,57), fill=myblu)
## US CAN
plot(bouCAN, add = TRUE, col =gpuPalette("cisl")[2], border = mygre, lwd = .6)
plot(bouUSA, add = TRUE, col =gpuPalette("cisl")[2], border = mygre, lwd = .6)
# text(coordinates(bouUSA), labels = bouUSA@data$NAME_1)
image(altONT, add = TRUE, col = mypal)
plot(watSheds3, add = TRUE, col = NA, border = "grey45", lwd = .4)

## LAKES
plot(lkHur, add = TRUE, col = myblu, border = mygre, lwd = .6)
plot(lkMic, add = TRUE, col = myblu, border = mygre, lwd = .6)
plot(lkSup, add = TRUE, col = myblu, border = mygre, lwd = .6)
plot(lkStc, add = TRUE, col = myblu, border = mygre, lwd = .6)
plot(lkOnt, add = TRUE, col = myblu, border = mygre, lwd = .6)
plot(lkEri, add = TRUE, col = myblu, border = mygre, lwd = .6)
points(lakes, pch = 21, col = mygre, bg = 'grey10', cex = .7, lwd = .2)

## ONTARIO
plot(bouCAN[9,], add = TRUE, col = NA, border ='grey10', lwd = 1)
axis(1L, at = seq(-95, -75, 5), labels = paste0(rev(seq(75,95,5)), "°W"))
axis(3L, at = seq(-95, -75, 5), labels = paste0(rev(seq(75,95,5)), "°W"))
axis(2L, at = seq(45, 55, 5), labels = paste0(seq(45,55,5), "°N"))
axis(4L, at = seq(45, 55, 5), labels = paste0(seq(45,55,5), "°N"))
box2(1:4, lwd = 1.1)
#
par(mar = c(4, 4, 4.5, 1.5), mgp = c(2,.8,0))
val <- range(values(altONT), na.rm = TRUE)
image(t(as.matrix(seq(val[1], val[2], length = ncolor))), col = mypal, axes = FALSE)
axis(2, at = seq(0.002,.998, length = 6), labels = seq(0, 650, length = 6), lwd = 0, lwd.tick = .8, tck = -.36)
mtext(side = 3, line = 1.2, text = 'Elevation (m)')
#

palc <- colorRampPalette(gpuPalette("cisl"))(ncolor)
##
par(mar = rep(.7, 4), xaxs = "r", yaxs = "r")
image(mask(temp, bouCAN[9,]), axes = FALSE, ann = FALSE, col = palc)
plot(bouCAN[9,], lwd = .8, add = TRUE)
par(mar = c(1, 1, 4, 4))
valt <- range(values(temp), na.rm = TRUE)
image(t(as.matrix(seq(valt[1], valt[2], length = ncolor))), col = palc, axes = FALSE)
mtext(side = 3, line = 2.1, text = 'Annual', cex = .7)
mtext(side = 3, line = .8, text = 'Temperature (Δ°C)', cex = .7)
# chose based on valt
sq <- seq(0.60, 1.9, length = 5)#' @param cex_bas magnification coefficient, controls the size of plot elements.

axis(4, at = scaleWithin(sq, ncolor, valt[1], valt[2])/ncolor, labels = paste0(sq), lwd = 0, lwd.tick = .8, tck = -.36)
#

par(mar = rep(.7, 4))
image(mask(prec, bouCAN[9,]), axes = FALSE, ann = FALSE, col = palc)
plot(bouCAN[9,], lwd = .7, add = TRUE)
par(mar = c(1, 1, 4, 4))
sq <- seq(-160, 160, length = 5)
valp <- range(values(prec), na.rm = TRUE)
image(t(as.matrix(seq(valp[1], valp[2], length = ncolor))), col = palc, axes = FALSE)
axis(4, at = scaleWithin(sq, ncolor, valp[1], valp[2])/ncolor, labels = paste0(sq), lwd = 0, lwd.tick = .8, tck = -.36)
mtext(side = 3, line = 2.1, text = 'Precipitations', cex = .7)
mtext(side = 3, line = .7, text = expression("(Δ"*mm.*year^-1*")"), cex = .7)
#
dev.off()
