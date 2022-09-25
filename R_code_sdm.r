 # R code for species distribution modelling
 
 install.packages("sdm")
 library(sdm)
 library(raster) # predictors
 library(rgdal) # species: an arrray of x, y points x0, y0,  x1, y1,  x2, y2... xn, yn
  
 # species data
 # system.file finds the data in a certain folder (in this case "esternal")
 file <- system.file("external/species.shp", package="sdm")
 file # shows where the data are
 
 species <- shapefile(file) # it imports shapefiles
 plot(species, pch=19, col="darkmagenta")
 
 species
 # class       : SpatialPointsDataFrame 
 # features    : 200 
 # extent      : 110112, 606053, 4013700, 4275600  (xmin, xmax, ymin, ymax)
 # crs         : +proj=utm +zone=30 +datum=WGS84 +units=m +no_defs 
 # variables   : 1
 # names       : Occurrence 
 # min values  :          0 
 # max values  :          1 
 
 # looking at species occurence
 species$Occurrence
 # [1] 1 0 1 1 1 0 0 1 1 1 1 1 1 0 1 1 0 1 1 0 0 1 0 1 1 0 1 0 1 0 1 0 1 1 1 1 0 1 0
 # [40] 0 0 0 0 0 0 1 0 0 1 0 1 0 0 0 0 0 1 1 1 1 0 0 1 0 1 0 1 1 1 1 0 0 0 0 0 1 0 0
 # [79] 1 0 1 0 1 1 1 0 0 1 1 0 0 1 1 1 1 0 0 0 0 0 0 0 1 1 1 0 0 1 1 0 0 0 1 0 0 1 1
 # [118] 1 1 1 0 0 0 1 1 0 0 1 1 1 1 1 0 0 0 1 0 0 1 1 0 1 0 1 0 0 1 1 0 0 1 0 0 1 1 0
 # [157] 0 0 0 1 1 1 0 0 0 0 1 0 0 1 0 1 0 0 0 0 1 0 1 0 1 0 1 0 0 0 0 1 1 0 1 0 1 1 0
 # [196] 1 0 0 0 0

 # how many occurrences with value 1 (or 0) are there?
 # quadratic parenthesis are a query
 species[species$Occurrence == 1,]
 species[species$Occurrence == 0,]
 
 #we can build a dataset of the presences and absences
 presences <- species[species$Occurrence == 1,]
 absences <- species[species$Occurrence == 0,]

 # let's plot presences and absences in separate plots
 plot(presences, pch=19, "blue")
 plot(absences, pch=19, col="red")
 
 # let's plot them in a single graphs: how to add additional points to a previous plot
 plot(presences, pch=19, "blue")
 points(absences, pch=19, col="red")
 
 # we want to plot the probability of finding species in an area with no plots (species distribution model)
 # we use raster datasets (like temperature) as predictors
 
 # we don't want to point at a single file (like shapefile) but to all the files in "external"

