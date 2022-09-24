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
p1 <- ggplot() + 
geom_raster(TGr$lst_2000, mapping = aes(x=x, y=y, fill=lst_2000)) +
scale_fill_viridis(option="magma") 

p2 <- ggplot() + 
geom_raster(TGr$lst_2015, mapping = aes(x=x, y=y, fill=lst_2015)) +
scale_fill_viridis(option="magma") 

p1/p2

# histograms
par(mfrow=c(1,2))
hist(TGr$lst_2000)
hist(TGr$lst_2015)

# plot two years to see where the pixels lie
plot(TGr$lst_2000, TGr$lst_2015, xlim=c(12500, 15000), ylim=c(12500, 15000))
abline(0,1,col="red")

# plot all the graphs
# we use the pair function to create scatterplot matrices
pairs(TGr)
