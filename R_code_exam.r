
library(raster)
library(RStoolbox)
library(ggplot2)


setwd("C:/lab/proj")

# monitoring the environmental changes in the area of Lagos, Nigeria

# we import the table with monthly mean T and precipitation in Nigeria for the decade 1991-2020
mean_monthly_climate <- read.table("_b_monthly-climatology-1991-2020__b_.csv", head=T, sep=",")
mean_monthly_climate

# create separate datasets for T and precipitation
temp <- mean_monthly_climate$Mean_T
prec <- mean_monthly_climate$Precipitation
Month <- mean_monthly_climate$Month
T <- data.frame(Month, temp)
P <- data.frame(Month, prec)

#we create two overlaying graphs to show the mean monthly precipitation and temperature in Nigeria
#we build the barplot
barplot(height=prec, names=Month,
     col="darkslategray3", border="lightblue",
     xlab="Month", ylab="", las=1,
     main="Mean monthly climate in Nigeria 2001-2020", 
     ylim=c(0,250))
mtext("Precipitation (mm)", side = 2, las=3, line=3, col="#009999")

par(new=TRUE) #allows multiple plots in the same chart

#we build the line plot with no axes
plot(temp, pch=16,  xlab="", ylab="", las=3, ylim=c(14,36), 
    axes=FALSE, type="b", col="#FF6600")

# we buld the y axes on the right
axis(4, ylim=c(14,36), col="black",col.axis="black",las=1)  
mtext("Temperature (C°)",side=4,col="#FF6600",line=-1.4) 
 ggsave("mean_month_climate.jpg")



# we import a table with the population data of Nigeria 1960-2021
nig_population <- read.table("nigeria-population-2022-09-27.csv", head=T, sep=",")
Year <- nig_population$date
Pop <- nig_population$Population
Urban_pop <- nig_population$Urban_Population
Perc <- nig_population$Perc_of_total


# we plot the population growth and the urban population growth
ggplot(data=nig_population, aes(x=Year)) +
  geom_bar(aes(y=Pop), stat="identity", position ="identity", alpha=0.3, col="darkgreen", fill="darkgreen") +
  geom_bar(aes(y=Urban_pop), stat="identity", position="identity", alpha=0.8, col="red", fill="pink")+
        xlab("Year")+ ylab("People (M)")+
  geom_label(label="Total population", 
        x=1970, y=200,
        label.padding = unit(0.55, "lines"),
        label.size = 0.35,
        color = "darkgreen",
        fill="#CCFFCC", alpha=0.3)+
  geom_label(label="Urban population", 
        x=1970, y=175,
        label.padding = unit(0.55, "lines"),
        label.size = 0.35,
        color = "red",
        fill="pink")
       ggsave("pop_urb_growth.jpg")


# we plot the evolution of the percentage of urban population
ggplot(nig_population, aes(x=Year, y=Perc)) +
  geom_area( fill="darkmagenta", alpha=0.3)+
  geom_line(color="darkmagenta", size=1.3)+
  geom_point(size=1.8, color="darkmagenta")+
  ylab("Percentage %")+xlab("Year")+ylim(0,80)+
ggtitle("Percentage of urban population 1960-2021")
ggsave("urb_pop_perc.jpg")


# we import the raster data of global NDVI in april 1999 and 2020
ndvi_1999 <- raster("c_gls_NDVI_199904210000_GLOBE_VGT_V2.2.1.nc")
ndvi_2020 <- raster("c_gls_NDVI_202004210000_GLOBE_PROBAV_V2.2.1.nc")

# we crop the data around the area of Lagos
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





