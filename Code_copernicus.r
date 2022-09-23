# R code for uploading fo uploading and visualizing data in R
install.packages("ncdf4")
library(ncdf4)
library(raster)
library(RStoolbox)
library(viridis)
library(ggplot2)
library(patchwork)
setwd("C:/lab/Copernicus")
snow20211214 <- raster("c_gls_SCE_202112140000_NHEMI_VIIRS_V1.0.1.nc")
plot(snow20211214)
# this dataset presents some saturation

#import data together with lapply
rlist<- list.files(pattern="SCE")
list_rast<-lapply(rlist, raster)

snowstack <- stack(list_rast)
snowstack

ssummer<-snowstack$Snow.Cover.Extent.1
swinter<-snowstack$Snow.Cover.Extent.2

# ggplot function
ggplot() + 
geom_raster(ssummer, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.1))  +
scale_fill_viridis(option="viridis")+
ggtitle("Snow cover")

ggplot() + 
geom_raster(ssummer, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.1)) +
scale_fill_viridis(option="cividis") + 
ggtitle("cividis palette")

# cropping an image
# longitude from 0 to 20
# latitude from 30 to 50
# crop the stack to the extent of Sicily
ext <- c(0, 20, 30, 50)
# stack_cropped <- crop(snowstack, ext) # this will crop the whole stack, and then single variables (layers) can be extracted
ssummer_cropped <- crop(ssummer, ext)
swinter_cropped <- crop(swinter, ext)

p1 <- ggplot() + 
geom_raster(ssummer_cropped, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.1)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during Duccio's birthday!")

p2 <- ggplot() + 
geom_raster(swinter_cropped, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.2)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during freezing winter!")

p1/p2 # puts the two plots one on top of the other



