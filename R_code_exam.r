
library(raster)
library(RStoolbox)

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

# we calculate the difference between the two NDVIs
ndvi_diff <- ndvi_1999_nig - ndvi_2020_nig

# we plot it
cl1 <- colorRampPalette(c("blue", "white", "red"))(100)
plot(ndvi_diff, col=cl1, main="Difference in NDVI between 1999 and 2020")

nig_cover<-brick("WorldCover Viewer-image")
plotRGB(nig_cover,  r=1, g=2, b=3, stretch="lin")

# unsupervised classification
nig_class <- unsuperClass(nig_cover, nClasses=2)
nig_class
# 1 0.6522753
# 2 0.9206111

ggplot()+
geom_point(data=pop_nig, aes(x=longitude, y=latitude, size=nga_general_2020),col="darkred",alpha=0.7)+
scale_size_continuous(range = c(1, 8), name="People")+ 
ggtitle("Population of Nigeria 2020")



# we import a table with the population of the Lagos state in the years 2006-2016
nig_pop<-read.table("ObservationData_gfvytff_mod.csv", fill=TRUE, head=T, sep=",")
nig_pop
#    Date    Value
# 1  2006  9113605
# 2  2007  9409957
# 3  2008  9715945
# 4  2009 10031883
# 5  2010 10358095
# 6  2011 10694915
# 7  2012 11042686
# 8  2013 11401767
# 9  2014 11772524
# 10 2015 12155337
# 11 2016 12550598


Years<-nig_pop$Date
Population<-nig_pop$Value

# we plot the table
ggplot(data=nig_pop, aes(x=Years, y=Population))+
geom_line(color="#F8766D", size=2, alpha=0.7, linetype="solid")+
geom_point(color="#F8766D", size=3, alpha=6)+
ggtitle("Population growth in the state of Lagos") # there has been an almost linear growth in the decade 2006-2016


mean_t_lagos<-read.table("tas_timeseries_annual_cru_1901-2021_NGA.csv", fill=TRUE, head=T, sep=",")
mean_t_lagos
