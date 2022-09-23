library(raster)
library(RStoolbox) # classification
library(ggplot2)
library(gridExtra) # for grid.arrange plotting

setwd("C:/lab/")

#list the files available
rlist<-list.files(pattern="defor")

#apply a function to a list
list_rast<-lapply(rlist, brick)
list_rast

plot(list_rast[[1]])

l1992<-list_rast[[1]]
plotRGB(l1992,  r=1, g=2, b=3, stretch="lin")

l2006<-list_rast[[2]]
plotRGB(l2006,  r=1, g=2, b=3, stretch="lin")

# NIR 1, RED 2, GREEN 3


# unsupervised classification
l1992c <- unsuperClass(l1992, nClasses=2)
l1992c
# class 1: forest
# class 2: agriculture
# with the classification we pass from a brick to a raster

plot(l1992c$map)
# value 1: agricultural land
# value 2: forest

# calculate the frequency of data
freq(l1992c$map)
# value  count
# [1,]     1  33287
# [2,]     2 308005

# agricultural land (class 1) = 33287
# forest (class 2) = 308005

total <- (33287 + 308005)
total
propagri <- 33287/total
propforest <- 308005/total
propagri
# [1] 0.09753232
propforest
# [1] 0.9024677


# build a dataframe
cover <- c("Agriculture","Forest")
prop1992 <- c(propagri, propforest)

proportion1992 <- data.frame(cover, prop1992)
proportion1992

# let's plot them!
ggplot(proportion1992, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(0,1)

#let's do the same for 2006
l2006c <- unsuperClass(l1992, nClasses=2)
l2006c
# class 1: forest
# class 2: agriculture

plot(l2006$map)
# value 1: forest
# value 2: agriculture

# calculate the frequency of data
freq(l2006c$map)
#value  count
# [1,]     1 178715
# [2,]     2 164011

propagri2006 <- 164011/total
propforest2006 <- 178715/total

# build a dataframe
cover <- c("Agriculture","Forest")
prop1992 <- c(propagri, propforest)
prop2006 <- c(propagri2006, propforest2006)

proportion <- data.frame(cover, prop1992, prop2006)

proportion

ggplot(proportion , aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(0,1)

p1 <- ggplot(proportion1992, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(proportion , aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white")

# let's put several plots in the same grid
grid.arrange(p1, p2, nrows=1)

