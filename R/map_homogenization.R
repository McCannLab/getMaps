# A map I have drawn for my manuscipt on homogenzation (few changes though)

library(sp)
library(raster)
library(rgdal)
library(rgeos)
# to install graphicsutils
# devtools::install_github("inSileco/graphicsUtrils")
library(graphicsutils)

# altCAN <- getData(name = "alt", country = 'CAN', path="data/")
# altONTc <- crop(altCAN, extent(bouCAN[9, ]))
# altONT <- rasterize(bouCAN[9,], altONTc, mask = TRUE)
# saveRDS(altONT, "data/altONT.rds")
# plot(altONT)
#
bouCAN <- getData(country='CAN', level=1, path="data/")
bouUSA <- getData(country='USA', level=1, path="data/")
altONT <- readRDS("data/altONT.rds")
# see combine for the following
temp <- readRDS("data/delta_temp_ontario.rds")
prec <- readRDS("data/delta_prec_ontario.rds")


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

# plot(bouCAN[11,], axis =)
png(file = 'fig/map.png', res = 600, units = 'in', width = 9.2, height = 5.3)
#
layout(rbind(c(2, 1, 3, 4), c(2, 1, 5, 6)), width = c(.17, 1, .53, .16))
par(las = 1, xaxs = 'i', yaxs = 'i', mar = rep(c(2.5,3), 2))
#
ncolor <- 512
myblu <- '#6da6c2'
mygre <- 'grey50'
mypal <- colorRampPalette(c('#f0dec3', '#41280f'))(ncolor)
#
plot0(c(-96,-74), c(41,57), fill=myblu)
plot(bouCAN, add = TRUE, col =gpuPalette("cisl")[2], border = mygre)
plot(bouUSA, add = TRUE, col =gpuPalette("cisl")[2], border = mygre)
# text(coordinates(bouUSA), labels = bouUSA@data$NAME_1)
image(altONT, add = TRUE, col = mypal)
plot(watSheds3, add = TRUE, col = NA, border = "grey45", lwd = .5)

##
plot(lkHur, add = TRUE, col = myblu, border = mygre)
plot(lkMic, add = TRUE, col = myblu, border = mygre)
plot(lkSup, add = TRUE, col = myblu, border = mygre)
plot(lkStc, add = TRUE, col = myblu, border = mygre)
plot(lkOnt, add = TRUE, col = myblu, border = mygre)
plot(lkEri, add = TRUE, col = myblu, border = mygre)
points(lakes, pch = 21, col = mygre, bg = 'grey10', cex = .7, lwd =.2)
#
plot(bouCAN[9,], add = TRUE, col = NA, border ='grey10', lwd = 1.44)
axis(1L, at = seq(-95, -75, 5), labels = paste0(rev(seq(75,95,5)), "°W"))
axis(3L, at = seq(-95, -75, 5), labels = paste0(rev(seq(75,95,5)), "°W"))
axis(2L, at = seq(45, 55, 5), labels = paste0(seq(45,55,5), "°N"))
axis(4L, at = seq(45, 55, 5), labels = paste0(seq(45,55,5), "°N"))
box2(1:4, lwd = 1.2)
#
par(mar = c(5.5, 4, 5.5, 1.5), mgp = c(2,.5,0))
val <- range(values(altONT), na.rm = TRUE)
image(t(as.matrix(seq(val[1], val[2], length = ncolor))), col = mypal, axes = FALSE)
axis(2, at = seq(0.002,.998, length = 6), labels = seq(0, 650, length = 6), lwd = 0, lwd.tick = .8, tck = -.36)
mtext(side = 3, line = 1.2, text = 'Elevation (m)')
#

palc <- colorRampPalette(gpuPalette("cisl"))(ncolor)
##
par(mar = c(.5, .5, .5, .5), xaxs = "r", yaxs = "r")
image(mask(temp, bouCAN[9,]), axes = FALSE, ann = FALSE, col = palc)
plot(bouCAN[9,], lwd = 1, add = TRUE)
par(mar = c(3, 1, 5, 4))
valt <- range(values(temp), na.rm = TRUE)
image(t(as.matrix(seq(valt[1], valt[2], length = ncolor))), col = palc, axes = FALSE)
mtext(side = 3, line = 2.2, text = 'Annual', cex = .7)
mtext(side = 3, line = 1.1, text = 'Temperature (Δ)', cex = .7)
# chose based on valt
sq <- seq(0.60, 1.9, length = 5)
axis(4, at = scaleWithin(sq, ncolor, valt[1], valt[2])/ncolor, labels = paste0(sq, "°C"), lwd = 0, lwd.tick = .8, tck = -.36)
#

par(mar = c(.5, .5, .5, .5))
image(mask(prec, bouCAN[9,]), axes = FALSE, ann = FALSE, col = palc)
plot(bouCAN[9,], lwd = 1, add = TRUE)
par(mar = c(3, 1, 5, 4))
sq <- seq(-160, 160, length = 5)
valp <- range(values(prec), na.rm = TRUE)
image(t(as.matrix(seq(valp[1], valp[2], length = ncolor))), col = palc, axes = FALSE)
axis(4, at = scaleWithin(sq, ncolor, valp[1], valp[2])/ncolor, labels = paste0(sq, "mm"), lwd = 0, lwd.tick = .8, tck = -.36)
mtext(side = 3, line = 2.2, text = 'Annual', cex = .7)
mtext(side = 3, line = 1.1, text = 'Precipitations (Δ)', cex = .7)
#
dev.off()
