
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

setwd("C:/lab/proj")

# monitoring the environmental changes in coastal Nigeria
# https://nigeria.opendataforafrica.org/
# https://land.copernicus.vgt.vito.be
# https://climateknowledgeportal.worldbank.org/country/nigeria
# https://neo.gsfc.nasa.gov

# import the table with monthly mean T and precipitation in Nigeria for the decade 1991-2020
mean_monthly_climate <- read.table("_b_monthly-climatology-1991-2020__b_.csv", head=T, sep=",")
mean_monthly_climate

# create separate datasets for T and precipitation
temp <- mean_monthly_climate$Mean_T
prec <- mean_monthly_climate$Precipitation
Month <- mean_monthly_climate$Month

# create two overlaying graphs to show the mean monthly precipitation and temperature in Nigeria
# build the barplot
barplot(height=prec, names=Month,
     col="darkslategray3", border="lightblue",
     xlab="Month", ylab="", las=1,
     main="Mean monthly climate in Nigeria 2001-2020", 
     ylim=c(0,250))
mtext("Precipitation (mm)", side = 2, las=3, line=3, col="#009999")

par(new=TRUE) #allows multiple plots in the same chart

# build the line plot with no axes
plot(temp, pch=16,  xlab="", ylab="", las=3, ylim=c(14,36), 
    axes=FALSE, type="b", col="#FF6600")

# build the y axes on the right
axis(4, ylim=c(14,36), col="black",col.axis="black",las=1)  
mtext("Temperature (C°)",side=4,col="#FF6600",line=-1.4) 
 ggsave("mean_month_climate.jpg")


# import a table with the population data of Nigeria 1960-2021
nig_population <- read.table("nigeria-population-2022-09-27.csv", head=T, sep=",")
Year <- nig_population$date
Pop <- nig_population$Population
Urban_pop <- nig_population$Urban_Population
Perc <- nig_population$Perc_of_total


# plot the population growth and the urban population growth
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


# plot the evolution of the percentage of urban population
ggplot(nig_population, aes(x=Year, y=Perc)) +
  geom_area( fill="darkmagenta", alpha=0.3)+
  geom_line(color="darkmagenta", size=1.3)+
  geom_point(size=1.8, color="darkmagenta")+
  ylab("Percentage %")+xlab("Year")+ylim(0,80)+
ggtitle("Percentage of urban population 1960-2021")
ggsave("urb_pop_perc.jpg")


# import the raster data of global NDVI in april 1999 and 2020
ndvi_1999 <- raster("c_gls_NDVI_199904210000_GLOBE_VGT_V2.2.1.nc")
ndvi_2020 <- raster("c_gls_NDVI_202004210000_GLOBE_PROBAV_V2.2.1.nc")

# crop the data around coastal Nigeria
ext <- c(2.5, 4.7, 6.1, 7.9)
ndvi_1999_nig <- crop(ndvi_1999, ext)
ndvi_2020_nig <- crop(ndvi_2020, ext)

# plot them
cl <- colorRampPalette(c("darkred", "orange", "yellow", "green", "white"))(100)  
par(mfrow=c(1,2))
plot(ndvi_1999_nig, col=cl, main="NDVI in Nigeria, 1999")
plot(ndvi_2020_nig, col=cl, main="NDVI in Nigeria, 2020")

# the white areas are water bodies
# the red and orange areas are larger in 2020

# calculate the difference between the two NDVIs
ndvi_diff <- ndvi_1999_nig - ndvi_2020_nig

# plot it
cl1 <- colorRampPalette(c("blue", "white", "red"))(100)
plot(ndvi_diff, col=cl1, main="Difference in NDVI between 1999 and 2020")


# import LST raster files for the same season in three different decades
lst_apr01<-raster("lst_apri2001.TIFF")
lst_apr10<-raster("lst_apri2010.TIFF")
lst_mar22<-raster("lst_mar2022.TIFF")

# crop them and prepare them for ggplot
ext<- c(0, 16, 3.5, 15.5)
lst_apr01_nig<-crop(lst_apr01, ext)
lst_apr10_nig<-crop(lst_apr10, ext)
lst_mar22_nig<-crop(lst_mar22, ext)

lst_apr01_nig_df<-as.data.frame(lst_apr01_nig, xy=T)
lst_apr10_nig_df<-as.data.frame(lst_apr10_nig, xy=T)
lst_mar22_nig_df<-as.data.frame(lst_mar22_nig, xy=T)

# plot the three images
p1<-ggplot()+
geom_tile(data=lst_apr01_nig_df, aes(x=x, y=y, fill=lst_apri2001))+
scale_fill_gradient(low="yellow", high="blue")+
theme(legend.position="none")+
ggtitle("Land surface T (day) in april, 2001")+
xlab(" ")+
ylab(" ")

p2<-ggplot()+
geom_tile(data=lst_apr10_nig_df, aes(x=x, y=y, fill=lst_apri2010))+
scale_fill_gradient(low="yellow", high="blue")+
theme(legend.position="none")+
ggtitle("Land surface T (day) in april, 2010")+
xlab(" ")+
ylab(" ")


p3<-ggplot()+
geom_tile(data=lst_mar22_nig_df, aes(x=x, y=y, fill=lst_mar2022))+
scale_fill_gradient(low="yellow", high="blue")+
theme(legend.position="none")+
ggtitle("Land surface T (day) in march, 2022")+
xlab(" ")+
ylab(" ")

# arrange them in one line
grid.arrange(grobs=list(p1, p2, p3), ncol=3)


# unsupervised classification

lst_apr01_class <- unsuperClass(lst_apr01_nig, nClasses=2)
lst_apr01_class
# 1 colder area
# 2 warmer area

plot(lst_apr01_class$map)
freq(lst_apr01_class$map)
#    value count
#[1,]  1   12811  colder area
#[2,]  2   6389  warmer area

lst_apr10_class <- unsuperClass(lst_apr10_nig, nClasses=2)
plot(lst_apr10_class$map)
freq(lst_apr10_class$map)
#     value count
#[1,]     1  12782
#[2,]     2  6418


lst_mar22_class <- unsuperClass(lst_mar22_nig, nClasses=2)
plot(lst_mar22_class$map)
freq(lst_mar22_class$map)
#      value count
#[1,]     1   11031
#[2,]     2   8169


# proportion
total <- 12811+6389
cold_a_01 <- 12811/total
warm_a_01 <- 6389/total
cold_a_10 <- 12782/total
warm_a_10 <- 6418/total
cold_a_22 <- 11031/total
warm_a_22 <- 8169/total

# build a dataframe
temp <- c("Cold", "Warm")
p_2001 <- c(cold_a_01, warm_a_01)
p_2010 <- c(cold_a_10, warm_a_10)
p_2022 <- c(cold_a_22, warm_a_22) 

proportion <- data.frame(temp, p_2001, p_2010, p_2022)

# plot the results
pl1<-ggplot(data=proportion, aes(x=temp, y=p_2001)) +
  geom_bar(aes(y=p_2001, fill=temp),stat="identity", position="identity")+
  scale_fill_manual(values = c("lightblue", "orange")) +
ylim(0,0.8)+
ylab(" ")+
xlab(" ")+
  theme(legend.position="none")+
ggtitle("2001 colder-warmer areas proportion")

pl2<-ggplot(data=proportion, aes(x=temp, y=p_2010)) +
  geom_bar(aes(y=p_2010, fill=temp),stat="identity", position="identity")+
  scale_fill_manual(values = c("lightblue", "orange")) +
ylim(0,0.8)+
ylab(" ")+
xlab(" ")+
  theme(legend.position="none")+
ggtitle("2010 colder-warmer areas proportion")

pl3<-ggplot(data=proportion, aes(x=temp, y=p_2022)) +
  geom_bar(aes(y=p_2022, fill=temp),stat="identity", position="identity")+
  scale_fill_manual(values = c("lightblue", "orange")) +
ylim(0,0.8)+
ylab(" ")+
xlab(" ")+
  theme(legend.position="none")+
ggtitle("2022 colder-warmer areas proportion")

grid.arrange(grobs=list(pl1, pl2, pl3), ncol=3)

