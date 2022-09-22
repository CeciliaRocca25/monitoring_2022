# First code in R
# here are the input data
# costanza data on streams
water<-c(100, 200, 300, 400, 500) 
# marta data on fish genomes
fishes<-c(10, 50, 60, 100, 200)
# plot the diversity of fishes (y) vs the amount of water (x)
# a function is used with arguments inside
plot(water, fishes)
#our data can be stored in a table called data frame
streams <- data.frame(water, fishes)
streams
#how to import and export tables
#set working directory for Windows
#we use commas for anything that is outside R
setwd("C:/lab/")
#export table
write.table(streams, file="my_first_table.txt")
#import table
read.table("my_first_table.txt")
#we can assign this function to an object in R
cecitable <- read.table("my_first_table.txt")
#lazy statistics
summary(cecitable)
#if I only want info on fishes
summary(cecitabletable$fishes)
# histogram
hist(cecitable$fishes)
hist(cecitable$water)
#meaning: lower amounts are more frequent than higher amounts
# R code for ecosystem monitoring by remote sensing
# First code in R
# here are the input data
# costanza data on streams
water<-c(100, 200, 300, 400, 500) 
# marta data on fish genomes
fishes<-c(10, 50, 60, 100, 200)
# plot the diversity of fishes (y) vs the amount of water (x)
# a function is used with arguments inside
plot(water, fishes)
#our data can be stored in a table called data frame
streams <- data.frame(water, fishes)
streams
#how to import and export tables
#set working directory for Windows
#we use commas for anything that is outside R
setwd("C:/lab/")
#export table
write.table(streams, file="my_first_table.txt")
#import table
read.table("my_first_table.txt")
#we can assign this function to an object in R
cecitable <- read.table("my_first_table.txt")
#lazy statistics
summary(cecitable)
#if I only want info on fishes
summary(cecitabletable$fishes)
# histogram
hist(cecitable$fishes)
hist(cecitable$water)
#meaning: lower amounts are more frequent than higher amounts
