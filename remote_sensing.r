# R code for ecosystem monitoring by remote sensing
# we need to install raster package to manage image data
# https://cran.r-project.org/web/packages/raster/index.html
install.packages("raster")
install.packages("rgdal)
library(raster)
library(rgdal)
#import image
l2006 <- brick("p224r63_2011")
# R code for estimating energy in ecosystems
library(raster)
library(rgdal)
setwd("C:/lab/")
# importing the data
# Rio Peixoto area
# We are going to find out how the image was 
l1992 <- brick("defor1_.jpg") # 1992 image
l1992
# Bands: defor1_.1, defor1_.2, defor1_.3
# plotRGB
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
# defor1_.1 = NIR  # we know it because it's the most reflecting
# defor1_.2 = red
# defor1_.3 = green
plotRGB(l1992, r=2, g=1, b=3, stretch="Lin") # we obtain the NIR in green
plotRGB(l1992, r=2, g=3, b=1, stretch="Lin") # vegetation turns blue #soil turns yellow
# back to NIR in red
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin") #water turns white and not black (as expected) because of algae or debris
# importing the 2006 data
l2006 <- brick("defor2_.jpg")
l2006
# plotting the imported image
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
# defor1_.1 = NIR
# defor1_.2 = red
# defor1_.3 = green
# par
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
# calculate energy in 1992 (DVI = NIR - r)
culate energy in 1992
dev.off() # to close the previous window
dvi1992<-l1992$defor1_.1 - l1992$defor1_.2 #$ links an object to a layer
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi1992, col=cl)
#calculate energy in 2006
dvi2006 <- l2006$defor2_.1 - l2006$defor2_.2
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi2006, col=cl)
# differencing two images of energy in two different times
dvidif <- dvi1992 - dvi2006
# plot the results
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(dvidif, col=cld)
# in all the red part energy has been lost
# final plot: original images, dvis, final dvi difference
par(mfrow=c(3,2))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
# to make a pdf
pdf("energy.pdf")
par(mfrow=c(3,2))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)
dev.off() #it tells R we're done with the PDF #necessary
# pdf
# 2
pdf("dvi.pdf")
par(mfrow=c(3,1))
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)
dev.off()
