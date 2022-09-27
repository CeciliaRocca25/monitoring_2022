
library(raster)

setwd("C:/lab/proj")

# monitoring the urban growth in the area of Lagos, Nigeria

# we import the raster data of global NDVI in april 1999 and 2020
ndvi_1999 <- raster("c_gls_NDVI_199904210000_GLOBE_VGT_V2.2.1.nc")
ndvi_2020 <- raster("c_gls_NDVI_202004210000_GLOBE_PROBAV_V2.2.1.nc")

# we crop the data around the area of Lagos, Nigeria
ext <- c(2.5, 4.7, 6.1, 7.9)
ndvi_1999_nig <- crop(ndvi_1999, ext)
ndvi_2020_nig <- crop(ndvi_2020, ext)

# we plot them
cl <- colorRampPalette(c("darkred", "orange", "yellow", "green", "white"))(100)  
par(mfrow=c(1,2))
plot(ndvi_1999_nig, col=cl, main="NDVI in Nigeria, 1999")
plot(ndvi_2020_nig, col=cl, main="NDVI in Nigeria, 2020")
# the white areas are water bodies
# the red and orange areas are larger in 2020

# we calculate the difference between the two plots
ndvi_diff <- ndvi_1999_nig - ndvi_2020_nig

# we plot it
cl1 <- colorRampPalette(c("blue", "white", "red"))(100)
plot(ndvi_diff, col=cl1, main="Difference in NDVI between 1999 and 2020")


library(raster)

setwd("C:/lab/proj")

# monitoring the urban growth in the area of Lagos, Nigeria

# we import the raster data of global NDVI in april 1999 and 2020
ndvi_1999 <- raster("c_gls_NDVI_199904210000_GLOBE_VGT_V2.2.1.nc")
ndvi_2020 <- raster("c_gls_NDVI_202004210000_GLOBE_PROBAV_V2.2.1.nc")

# we crop the data around the area of Lagos, Nigeria
ext <- c(2.5, 4.7, 6.1, 7.9)
ndvi_1999_nig <- crop(ndvi_1999, ext)
ndvi_2020_nig <- crop(ndvi_2020, ext)

# we plot them
cl <- colorRampPalette(c("darkred", "orange", "yellow", "green", "white"))(100)  
par(mfrow=c(1,2))
plot(ndvi_1999_nig, col=cl, main="NDVI in Nigeria, 1999")
plot(ndvi_2020_nig, col=cl, main="NDVI in Nigeria, 2020")
# the white areas are water bodies
# the red and orange areas are larger in 2020

# we calculate the difference between the two plots
ndvi_diff <- ndvi_1999_nig - ndvi_2020_nig

# we plot it
cl1 <- colorRampPalette(c("blue", "white", "red"))(100)

nig_pop<-read.table("nga_general_2020.csv")

