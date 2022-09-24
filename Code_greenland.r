# Greenland increase of temperature
# Data and code from Emanuela Cosma

library(raster)
library(ggplot2)
library(patchwork)
setwd("C:/lab/greenland")

#lst is Land Surface Temperature
rlist <- list.files(pattern="lst")
rlist
import <- lapply(rlist,raster) # we use raster as they're single layers
import

#stack the files
TGr <- stack(import)
TGr
plot(TGr)

cl <- colorRampPalette(c("blue","light blue","pink","yellow"))(100)
plot(TGr, col=cl)

# ggplot of first and final images 2000 vs. 2015 
ggplot() + 
geom_raster(TGr$lst_2000, mapping = aes(x=x, y=y, fill=lst_2000)) +
scale_fill_viridis(option="magma") 

ggplot() + 
geom_raster(TGr2000, mapping = aes(x=x, y=y, fill=lst_2000)) +
scale_fill_viridis(option="magma") 

ggplot() + 
geom_raster(TGr2000, mapping = aes(x=x, y=y, fill=lst_2000)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during my birthday!")
