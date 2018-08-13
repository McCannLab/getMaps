# A map I have drawn for my manuscipt on homogenzation (few changes though)

library(sp)
library(raster)
library(rgdal)
library(rgeos)
# to install graphicsutils
# devtools::install_github("inSileco/graphicsUtrils")
library(graphicsutils)

#
bouCAN <- getData(country='CAN', level=1, path="data/")
bouUSA <- getData(country='USA', level=1, path="data/")
altONT <- readRDS("data/altONT.rds")
##
lkOnt <- readOGR("data/hydro_p_LakeOntario/hydro_p_LakeOntario.shp")
lkMic <- readOGR("data/hydro_p_LakeMichigan/hydro_p_LakeMichigan.shp")
lkHur <- readOGR("data/hydro_p_LakeHuron/hydro_p_LakeHuron.shp")
lkSup <- readOGR("data/hydro_p_LakeSuperior/hydro_p_LakeSuperior.shp")
lkStc <- readOGR("data/hydro_p_LakeStClair/hydro_p_LakeStClair.shp")
#
lakes <- readRDS("data/lakes_ont.rds")

## tertionary watersheds
watSheds3 <- spTransform(readOGR("data/tertionaryWatersheds/WATERSHED_TERTIARY.shp"), bouCAN@proj4string)


# plot(bouCAN[11,], axis =)
png(file = 'fig/custom.png', res = 600, units = 'in', width = 6, height = 7)
#
layout(matrix(1:2, 2), heights = c(1,.14))
par(las = 1, xaxs='i', yaxs='i', mar = rep(c(2.5,3),2))
#
myblu <- '#6da6c2'
mygre <- 'grey50'
mypal <- colorRampPalette(c('#f6e1c0', '#624323'))(512)
#
plot0(c(-96,-74), c(41,57), fill=myblu)
plot(bouCAN, add = T, col ='#b5cfbd', border = mygre)
plot(bouUSA, add = T, col ='#b5cfbd', border = mygre)
# text(coordinates(bouUSA), labels = bouUSA@data$NAME_1)
image(altONT, add = T, col = mypal)
plot(watSheds3, add = T, col = NA, border = "grey45", lwd = .5)

##
plot(lkHur, add = T, col = myblu, border = mygre)
plot(lkMic, add = T, col = myblu, border = mygre)
plot(lkSup, add = T, col = myblu, border = mygre)
plot(lkStc, add = T, col = myblu, border = mygre)
plot(lkOnt, add = T, col = myblu, border = mygre)
points(lakes[,3], lakes[,4], pch = 21, col = mygre, bg = 'grey15', cex = .7, lwd =.2)
plot(bouCAN[11,], add = T, col = NA, border ='grey15', lwd =1.4)
axis(1L, at = seq(-95, -75, 5), labels = paste0(rev(seq(75,95,5)), "°W"))
axis(3L, at = seq(-95, -75, 5), labels = paste0(rev(seq(75,95,5)), "°W"))
axis(2L, at = seq(45, 55, 5), labels = paste0(seq(45,55,5), "°N"))
axis(4L, at = seq(45, 55, 5), labels = paste0(seq(45,55,5), "°N"))
box2(1:4, lwd = 1.2)
#
par(mar = c(3.2, 5, .5, 5), mgp = c(2,.5,0))
val <- range(values(altONT), na.rm =T)
image(as.matrix(seq(val[1], val[2], length = 512)), col = mypal, axes =F)
axis(1, at = seq(0.001,.999,length=6), labels = seq(0, 650, length=6))
mtext(side = 1, line = 1.8, text='Elevation (m)')
#
dev.off()
