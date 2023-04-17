##############################################################################################################
# 
# 
# Program to plot all the curated data from the oxygen sensor data collected from the Apogee S-210 sensors deployed in the 
#  Strategic Tillage USda-Nifa funded project. The progfram uses the outputs of the CuratedDataForAnalysis.R
# 
#    
# 
# 
#  Felipe Montes 2023/04/14
# 
# 
# 
############################################################################################################### 



###############################################################################################################
#                             Setting up working directory  Loading Packages and Setting up working directory                        
###############################################################################################################


#      set the working directory

# readClipboard()

setwd("C:\\Users\\frm10\\OneDrive - The Pennsylvania State University\\O2Sensors") ;



###############################################################################################################
#                            Install the packages that are needed                       
###############################################################################################################

#  install.packages("lattice" , dep = T)

#  install.packages("latticeExtra" , dep = T)

###############################################################################################################
#                           load the libraries that are needed   
###############################################################################################################

library(lattice)

library(latticeExtra)

###############################################################################################################
#                           load the files that will be needed  
###############################################################################################################

######  store the default graphics parameters 

def.par<-par()



###############################################################################################################
#                          Weather Data
###############################################################################################################

Weather.data <- read.csv (file = "WeatherData\\RockSrpings.NRCS.1.csv" , header = T) ;


str(Weather.data)

##################### Get the data in the correct data classes  #######################################################

Weather.data$Date.Time <- as.POSIXct(Weather.data$Date.Time) ;


###############################################################################################################
#                          2021 Data
###############################################################################################################

Data.2021 <- read.csv (file = "OxygenSensorsData2021\\CuredDataOxygenSensorsData20212023-04-13.csv" , header = T) ;

str(Data.2021)

##################### Get the data in the correct data classes  #######################################################

Data.2021$Corrected.TIME <- as.POSIXct(Data.2021$Corrected.TIME) ;

Data.2021$Block <- as.factor(Data.2021$Block) ;

levels(Data.2021$Block) 

Data.2021$C_Crop <-  as.factor(Data.2021$C_Crop) ;

levels(Data.2021$C_Crop) 

Data.2021$Treatment <-  as.factor(Data.2021$Treatment) ;

levels(Data.2021$Treatment) 

Data.2021$Depth_cm <- as.factor(Data.2021$Depth_cm) ;

levels(Data.2021$Depth_cm) 


##################### Drop treatments A  ###################################################################

Data.2021 <- subset(Data.2021 , Treatment != "A") ;

str(Data.2021)

Data.2021 <- droplevels( x = Data.2021 ,  except = c( 1:3, 5:8)) ;

Data.2021[ Data.2021$Treatment == "A" ,] 



###############################################################################################################
#                          Plot Temperature 
###############################################################################################################


###############################################################################################################
#                           Set parameters for plotting
###############################################################################################################


Date.Range.2021.1 <- as.POSIXct(c(min(Data.2021$Corrected.TIME) , max(Data.2021$Corrected.TIME) + (60*60*24*0))) ;

Date.Range.2021.2 <- as.POSIXct(c(min(Data.2021$Corrected.TIME) , c(min(Data.2021$Corrected.TIME) + (60*60*24*5)))) ;

Temperature.Range.1 <- c(min(Data.2021$Temperature_C , na.rm = T) , max(Data.2021$Temperature_C , na.rm = T)) ;

Temperature.Range.2 <- c(16,36) ;


##################### Try package Lattice  ###################################################################



########################### Define plotting colors  ###################################################### 

fill.colors <- palette.colors( palette = "Polychrome 36" , alpha = 1 , recycle = F)


########################### Combine Factors to plot by all combinations of treatments ########################


Data.2021$Combined.Factors <- as.factor(paste(Data.2021$Block, Data.2021$C_Crop, Data.2021$Treatment, Data.2021$Depth_cm )) ;

levels(Data.2021$Combined.Factors)



xyplot(Temperature_C ~ Corrected.TIME, groups = Combined.Factors,  data = Data.2021, 
       
       xlim = Date.Range.2021.1, ylim = Temperature.Range.1  , type = "p" , pch = 17, 
       
       col = fill.colors [1:24], main = "2021",
       
       
       key = list(space = "right", adj = 1,
                  
                  text = list(levels(Data.2021$Combined.Factors)),
                  
                  points = list(pch = 17, col = fill.colors [1:24] ))) ;

       
########################### Factors not to plot  because there are issues with the data ########################
# 
# 2021 Data.2021
# 
# B4 Clover -> problems with the power (battery)
# 
# B3 3Spp -> weird data
#
# B3 Triticale -> weird data

########################### Data.2021 B4 Clover ################################################


Plot.Data.1 <- Data.2021 [Data.2021$Block == "4" &  Data.2021$C_Crop == "Clover",  ] ;

str(Plot.Data.1 )


Plot.Data.1 <- droplevels( x = Plot.Data.1) ;

levels(Plot.Data.1$Combined.Factors)



xyplot(Temperature_C ~ Corrected.TIME, groups = Combined.Factors, data = Plot.Data.1 , 
       
       xlim = Date.Range.2021.1, ylim = Temperature.Range.1  , type = "p" , pch = 17, 
       
       col = fill.colors [1:4], main = "2021",
       
       
       key = list(space = "right", adj = 1,
                  
                  text = list(levels(Plot.Data.1$Combined.Factors)),
                  
                  points = list(pch = 17, col = fill.colors [1:4] ))) ;



########################### Data.2021  without B4 Clover ################################################


str(Data.2021 )


Plot.Data.2 <- Data.2021 [! (Data.2021$Block == "4" & Data.2021$C_Crop == "Clover"),  ] ;

str(Plot.Data.2 )


Plot.Data.2 <- droplevels( x = Plot.Data.2) ;

levels(Plot.Data.2$Combined.Factors)

str(Plot.Data.2 )



Date.Range.2021.3 <- as.POSIXct(c(min(Plot.Data.2$Corrected.TIME) , max(Plot.Data.2$Corrected.TIME) + (60*60*24*0))) ;


xyplot(Temperature_C ~ Corrected.TIME, groups = Combined.Factors, data = Plot.Data.2 , 
       
       xlim = Date.Range.2021.2, ylim = Temperature.Range.1  , type = "p" , pch = 17, 
       
       col = fill.colors[1:20] , main = "2021",
       
       
       key = list(space = "right", adj = 1,
                  
                  text = list(levels(Plot.Data.2$Combined.Factors)),
                  
                  points = list(pch = 17, col = fill.colors[1:20]  ))) ;


########################### Data.2021 B3 3Spp ################################################



Plot.Data.3 <- Plot.Data.2 [Plot.Data.2$Block == "3" &  Plot.Data.2$C_Crop == "3Spp",  ] ;

str(Plot.Data.3 )


Plot.Data.3 <- droplevels( x = Plot.Data.3) ;

levels(Plot.Data.3$Combined.Factors)



xyplot(Temperature_C ~ Corrected.TIME, groups = Combined.Factors, data = Plot.Data.3 , 
       
       xlim = Date.Range.2021.2, ylim = Temperature.Range.1  , type = "p" , pch = 17, 
       
       col = fill.colors [1:4], main = "2021",
       
       
       key = list(space = "right", adj = 1,
                  
                  text = list(levels(Plot.Data.3$Combined.Factors)),
                  
                  points = list(pch = 17, col = fill.colors [1:4] ))) ;






########################### Data.2021  without B3 3Spp  ################################################



str(Plot.Data.2 )


Plot.Data.4 <- Plot.Data.2 [!( Plot.Data.2$Block == "3" &  Plot.Data.2$C_Crop == "3Spp" ),  ] ;

str(Plot.Data.4 )


Plot.Data.4 <- droplevels( x = Plot.Data.4) ;

levels(Plot.Data.4$Combined.Factors)

str(Plot.Data.4 )

   
Date.Range.2021.5 <- as.POSIXct(c(min(Plot.Data.4$Corrected.TIME) , max(Plot.Data.4$Corrected.TIME) + (60*60*24*0))) ;


xyplot(Temperature_C ~ Corrected.TIME, groups = Combined.Factors, data = Plot.Data.4 , 
       
       xlim = Date.Range.2021.5, ylim = Temperature.Range.1  , type = "p" , pch = 17, 
       
       col = fill.colors[1:16] , main = "2021",
       
       
       key = list(space = "right", adj = 1,
                  
                  text = list(levels(Plot.Data.4$Combined.Factors)),
                  
                  points = list(pch = 17, col = fill.colors[1:16]  ))) ;



########################### Data.2021 B3 Triticale  ################################################


str(Plot.Data.4 )


Plot.Data.5 <- Plot.Data.4 [ Plot.Data.4$Block == "3" &  Plot.Data.4$C_Crop == "Triticale" ,  ] ;

str(Plot.Data.5 )


Plot.Data.5 <- droplevels( x = Plot.Data.5) ;

levels(Plot.Data.5$Combined.Factors)

str(Plot.Data.5 )


Date.Range.2021.6 <- as.POSIXct(c(min(Plot.Data.5$Corrected.TIME) , max(Plot.Data.5$Corrected.TIME) + (60*60*24*0))) ;



xyplot(Temperature_C ~ Corrected.TIME, groups = Combined.Factors, data = Plot.Data.5 , 
       
       xlim = Date.Range.2021.6, ylim = Temperature.Range.1  , type = "p" , pch = 17, 
       
       col = fill.colors[1:4] , main = "2021",
       
       
       key = list(space = "right", adj = 1,
                  
                  text = list(levels(Plot.Data.5$Combined.Factors)),
                  
                  points = list(pch = 17, col = fill.colors[1:4]  ))) ;



########################### Data.2021  without B3 Triticale  ################################################

str(Plot.Data.4 )


Plot.Data.6 <- Plot.Data.4 [ !(Plot.Data.4$Block == "3" &  Plot.Data.4$C_Crop == "Triticale") ,  ] ;

str(Plot.Data.6 )



Plot.Data.6 <- droplevels( x = Plot.Data.6) ;

levels(Plot.Data.6$Combined.Factors)

str(Plot.Data.6 )



xyplot(Temperature_C ~ Corrected.TIME, groups = Combined.Factors, data = Plot.Data.6 ,   type = "p" , pch = 17, 
       
       col = fill.colors[1:12] , main = "2021",
       
              key = list(space = "right", adj = 1,
                  
                  text = list(levels(Plot.Data.6$Combined.Factors)),
                  
                  points = list(pch = 17, col = fill.colors[1:12]  ))) ;



###############################################################################################################
#                          Plot O2 
###############################################################################################################

str(Plot.Data.6 )


xyplot(Calibrated.O2_Kpa ~ Corrected.TIME, groups = Combined.Factors, data = Plot.Data.6 ,   type = "p" , pch = 17, 
       
       col = fill.colors[1:12] , main = "2021",
       
       key = list(space = "right", adj = 1,
                  
                  text = list(levels(Plot.Data.6$Combined.Factors)),
                  
                  points = list(pch = 17, col = fill.colors[1:12]  ))) ;




########################### Factors not to plot  because there are issues with the data ########################
# 
# 2021 Data.2021
# 
# B4 Clover -> problems with the power (battery)
# 
# B3 3Spp -> weird data
#
# B3 Triticale -> weird data


str(Plot.Data.6 )


xyplot(Calibrated.O2_Kpa ~ Corrected.TIME, groups = Combined.Factors, data = Plot.Data.6 ,   type = c("p", "g") , pch = 17, 
       
       col = fill.colors[1:12] , main = "2021",
       
       key = list(space = "right", adj = 1,
                  
                  text = list(levels(Plot.Data.6$Combined.Factors)),
                  
                  points = list(pch = 17, col = fill.colors[1:12]  ))) ;






###############################################################################################################
#                         Calculate Temperature and O2 averaged for all factors
###############################################################################################################

str(Plot.Data.6 ) 



names(Plot.Data.6)



Plot.Data.7.mean <- aggregate(cbind( Temperature_C, Calibrated.O2_Kpa)  ~  Corrected.TIME + Depth_cm,  data = Plot.Data.6 , FUN = mean  ) ;

Plot.Data.7.sd <- aggregate(cbind( Temperature_C, Calibrated.O2_Kpa)  ~ Corrected.TIME + Depth_cm,  data = Plot.Data.6 , FUN = sd  ) ;

Plot.Data.7 <- merge(Plot.Data.7.mean , Plot.Data.7.sd, by = c("Corrected.TIME" , "Depth_cm" ) );

str( Plot.Data.7 ) 

names(Plot.Data.7) <- c( "Corrected.TIME" , "Depth_cm" ,"Temperature_C.Avg" , "Calibrated.O2_Kpa.Avg" , "Temperature_C.Std" , "Calibrated.O2_Kpa.Std") ;


###############################################################################################################
#                         Calculate confidence intervals usind the T distribution qt()
###############################################################################################################



Plot.Data.7$T.95.Interval <- qt(0.975, df= 12-1) * (Plot.Data.7$Temperature_C.Std / sqrt (12)) ;

Plot.Data.7$T.Low <- Plot.Data.7$Temperature_C.Avg - Plot.Data.7$T.95.Interval ;

Plot.Data.7$T.High <- Plot.Data.7$Temperature_C.Avg +  Plot.Data.7$T.95.Interval ;

Plot.Data.7$O2.95.Interval <- qt(0.975, df= 12-1) * (Plot.Data.7$Calibrated.O2_Kpa.Std / sqrt (12)) ;

Plot.Data.7$O2.Low <- Plot.Data.7$Calibrated.O2_Kpa.Avg - Plot.Data.7$O2.95.Interval ;

Plot.Data.7$O2.High <- Plot.Data.7$Calibrated.O2_Kpa.Avg + Plot.Data.7$O2.95.Interval ;


str( Plot.Data.7 )

head ( Plot.Data.7 )


###############################################################################################################
#                       Plot T and O2 averages  with error bars
###############################################################################################################


plot(Temperature_C.Avg ~ Corrected.TIME, data = Plot.Data.7 , type = "b" , col = "RED" , pch = 17 , cex= 1.5 ) ;

arrows(x = Plot.Data.7$Corrected.TIME , y0 = Plot.Data.7$T.Low , x1 = Plot.Data.7$Corrected.TIME , 
       
       y1 = Plot.Data.7$T.High, angle = 90,  code = 3, length = 0.05) ;

grid(col = "BLACK")


###############################################################################################################
#                       Plot T averages with error shade
###############################################################################################################


########################### Set plot background color ################################################

par(bg = gray(level = 0.8) , mar = c(0, 6, 4 , 2) + 0.1 )

########################### Plot T Depth = 5cm ################################################

Plot.Data.T.5cm <- Plot.Data.7[ Plot.Data.7$Depth_cm == "5" , ] ;

str( Plot.Data.T.5cm  )


########################### Set plot axis range  ################################################


Date.Range.2021.8 <- as.POSIXct(c(min(Plot.Data.T.5cm$Corrected.TIME) , max(Plot.Data.T.5cm$Corrected.TIME) + (60*60*24*0))) ;

Temperature.Range.3 <-  c(min(Plot.Data.T.5cm$T.Low , na.rm = T) , max(Plot.Data.T.5cm$T.High , na.rm = T)) ;


####################################### Plot  ################################################

plot(Temperature_C.Avg ~ Corrected.TIME, data = Plot.Data.T.5cm , type = "b" , xlim =  Date.Range.2021.8 ,
     
     ylim = Temperature.Range.3 ,col = "RED" , pch = 17 , cex= 1.5 , cex.axis = 2.0 , cex.lab = 2.0, ylab = "Temperature °C", 
     
     xlab = NA,  xaxt = "n" , tck = 1,  main = "2021" , cex.main = 3.0 );

polygon( x = c(rev(Plot.Data.T.5cm $Corrected.TIME), Plot.Data.T.5cm $Corrected.TIME ) , 
         
         y = c(rev(Plot.Data.T.5cm $T.Low ), Plot.Data.T.5cm $T.High ), col = adjustcolor( col = "RED" , alpha.f = 0.2), border = F) ;

grid(col = "BLACK")



########################### Plot T Depth = 20cm ################################################



Plot.Data.T.20cm <- Plot.Data.7[ Plot.Data.7$Depth_cm == "20" , ] ;

str( Plot.Data.T.20cm  )


####################################### Plot  ################################################

points(Temperature_C.Avg ~ Corrected.TIME, data = Plot.Data.T.20cm  , type = "b" , col = "BLUE" , pch = 17 , cex= 1.5 ) ;


polygon( x = c(rev(Plot.Data.T.20cm $Corrected.TIME), Plot.Data.T.20cm $Corrected.TIME ) , 
         
         y = c(rev(Plot.Data.T.20cm $T.Low ), Plot.Data.T.20cm $T.High ), col = adjustcolor( col = "BLUE" , alpha.f = 0.2) , border = F) ;



###############################################################################################################
#                       Plot O2  averages with error shade
###############################################################################################################


########################### Plot O2  Depth = 5cm ################################################

str( Plot.Data.T.5cm  )


########################### Set plot axis range  ################################################


O2.Range.1 <- c(min(Plot.Data.7$O2.Low , na.rm = T) , max(Plot.Data.7$O2.High , na.rm = T)) ;


####################################### Plot  ################################################

plot(Calibrated.O2_Kpa.Avg ~ Corrected.TIME, data = Plot.Data.T.5cm , type = "b" , 
     
     xlim =  Date.Range.2021.8 , ylim = O2.Range.1 , col = "RED" , pch = 17 , cex= 1.5, cex.lab = 2.0,
     
     ylab = "O2 - Kpa" , xlab = NA,  xaxt = "n" , tck = 1,  cex.axis = 2.0) ;

polygon( x = c(rev(Plot.Data.T.5cm $Corrected.TIME), Plot.Data.T.5cm $Corrected.TIME ) , 
         
         y = c(rev(Plot.Data.T.5cm$O2.Low ), Plot.Data.T.5cm$O2.High ), col = adjustcolor( col = "RED" , alpha.f = 0.2), border = F) ;

grid(col = "BLACK")



########################### Plot O2 Depth = 20cm ################################################

Plot.Data.T.20cm <- Plot.Data.7[ Plot.Data.7$Depth_cm == "20" , ] ;

str( Plot.Data.T.20cm  )

####################################### Plot  ################################################

points(Calibrated.O2_Kpa.Avg ~ Corrected.TIME, data = Plot.Data.T.20cm  , type = "b" , col = "BLUE" , pch = 17 , cex= 1.5 ) ;



polygon( x = c(rev(Plot.Data.T.20cm $Corrected.TIME), Plot.Data.T.20cm $Corrected.TIME ) , 
         
         y = c(rev(Plot.Data.T.20cm $O2.Low ), Plot.Data.T.20cm $O2.High ), col = adjustcolor( col = "BLUE" , alpha.f = 0.2) , border = F) ;





###############################################################################################################
#                          Plot Cumulative Precipitation
###############################################################################################################

################## Select the time range similar to the time range for T and 02 ##############################

str(Weather.data)

Weather.data.2021 <- Weather.data[ Weather.data $ Date.Time >= Date.Range.2021.8[1] & 
                                  
                                  Weather.data $ Date.Time <= Date.Range.2021.8[2] , ] ;


Weather.data.2021[is.na(Weather.data.2021 $ Precipitation.Increment..in.), c("Precipitation.Increment..in.") ] = 0 ;

Weather.data.2021 $ Cumm.Prec <- cumsum(Weather.data.2021 $ Precipitation.Increment..in.) ;


str(Weather.data.2021)


str(Weather.data$Date.Time)

Weather.Date.Range <- Date.Range.2021.8  ;

plot(Cumm.Prec ~ Date.Time , data = Weather.data.2021 , xlim = Weather.Date.Range , type = "l"  ,
     
     lwd = 5 , col = "MAGENTA" ,  cex= 1.5, cex.lab = 2.0,
     
     ylab = "Precipitation Acumulation in" , xlab = NA,  xaxt = "n" , tck = 1,  cex.axis = 2.0) ;


###############################################################################################################
#                          Plot  Precipitation 
###############################################################################################################

plot(Precipitation.Increment..in. ~ Date.Time ,data = Weather.data.2021 , xlim = Weather.Date.Range ,
     
     type = "h", lwd = 10 , col = "MAGENTA" ,  cex= 1.5, cex.lab = 2.0,
     
     ylab = "Precipitation in" , xlab = NA,  xaxt = "n" , tck = 1,  cex.axis = 2.0) ;

grid(col = "BLACK")

###############################################################################################################
#                         Plot  volumetric soil moisture 
###############################################################################################################


str(Weather.data.2021)

###### There is no date for the 20 cm depth ( 8 in)   is approximated by the average between 4 in and 20 in ####

Weather.data.2021$Soil.Moisture.Percent.20cm <- 
  
  rowMeans( Weather.data.2021 [ , c( "Soil.Moisture.Percent..4in..pct." ,  "Soil.Moisture.Percent..20in..pct." ) ] , na.rm = T ) ;



################## Select the time range similar to the time range for T and 02 ##############################

Soil.Moisture.Range <- c(min(Weather.data.2021[ , c("Soil.Moisture.Percent..2in..pct.")], na.rm = T),
                         
                         max(Weather.data.2021[ , c("Soil.Moisture.Percent..4in..pct.")], na.rm = T)) ;



####################################### Plot  ################################################

plot(Soil.Moisture.Percent..2in..pct. ~ Date.Time , data = Weather.data.2021 , xlim = Weather.Date.Range , 
     
     ylim = Soil.Moisture.Range , type = "b" , col = "RED" ) ;


points(Soil.Moisture.Percent..4in..pct. ~ Date.Time , data = Weather.data.2021 ,  type = "b" , col = "BLUE" ) ;

points(Soil.Moisture.Percent..20in..pct. ~ Date.Time ,data = Weather.data.2021 ,  type = "l" , col = "CYAN" ) ;

points(Soil.Moisture.Percent.20cm ~ Date.Time ,data = Weather.data.2021 ,  type = "b" , col = "MAGENTA" ) ;

grid( col = "BLACK")



###############################################################################################################
#                         Plot  soil moisture in % saturation
###############################################################################################################


str(Weather.data.2021)

################################  Scale volumetric soil moisture ranges #################################### 



Range.2pct <- range(Weather.data.2021 $ Soil.Moisture.Percent..2in..pct., na.rm = T)

((Range.2pct[1] + 7) - Range.2pct[1]) / (Range.2pct[2] - Range.2pct[1])



################################  Function to Min-Max scale a variable  #################################### 

Min.Max.Scale <- function (x, ...) {
  
  low <- min(x , na.rm = T ) 
  
  high <- max(x , na.rm = T )
  
  scaled.x.all <- (x - low ) / ( high - low)
  
  return (scaled.x.all ) 
  
}

#### Test ####

Min.Max.Scale ( x = Weather.data.2021 $ Soil.Moisture.Percent..2in..pct.)



################################  Calculate saturation moisture percentage  #################################### 

Weather.data.2021$Soil.Moisture.Sat.5cm <- Min.Max.Scale ( x = Weather.data.2021$Soil.Moisture.Percent..2in..pct.) ;

Weather.data.2021$Soil.Moisture.Sat.20cm <- Min.Max.Scale ( x = Weather.data.2021$Soil.Moisture.Percent.20cm) ;

Weather.data.2021$Soil.Moisture.Sat.50cm <- Min.Max.Scale ( x = Weather.data.2021$Soil.Moisture.Percent..20in..pct.) ;




####################################### Plot  ################################################


plot(Soil.Moisture.Sat.5cm ~ Date.Time , data = Weather.data.2021 , xlim = Weather.Date.Range , 
     
     ylim = c(0 , 1) , type = "b" , col = "RED" , cex = 2 , cex.lab = 2.0, pch = 17,
     
     ylab = "Soil Moisture" , xlab = NA,  xaxt = "n" , tck = 1,  cex.axis = 2.0) ;



points(Soil.Moisture.Sat.20cm ~ Date.Time , data = Weather.data.2021 ,  type = "b" ,
       
       col = "BLUE" , cex = 2 , pch = 17 ) ;

points(Soil.Moisture.Sat.50cm ~ Date.Time ,data = Weather.data.2021 ,  type = "b" ,
       
       col = "BROWN", cex = 2 , pch = 17 ) ;


grid( col = "BLACK")

####################################### adding a legend  ################################################

legend.1<-c("5 cm", "20 cm" , "50 cm")

legend.2<-c("solid" , "solid" , "solid" ) 

legend.4<-c( "RED" , "BLUE" , "BROWN")

legend.5<-c( 3, 3)

# legend(x = "bottomleft" , legend = legend.1, lty = legend.2,  pch = legend.3 , col = legend.4, 
#        pt.cex= 2.0 , lwd = legend.5, bty = "n", horiz = T, ncol = 2)

legend(x = "bottomright" , legend = legend.1, lty = legend.2, col = legend.4, 
       pt.cex= 2.0 , lwd = legend.5, bty = "n", cex = 2.0, pch = 17)




###############################################################################################################
#                        Create the composite plot
###############################################################################################################

########################### setting plot parameters background color ###########################

par(bg = gray(level = 0.8)  , mfrow = c(4,1), mar = c(0, 6, 4 , 2) + 0.1 )


####################################### Plot T 5cm  ################################################

plot(Temperature_C.Avg ~ Corrected.TIME, data = Plot.Data.T.5cm , type = "b" , xlim =  Date.Range.2021.8 ,
     
     ylim = Temperature.Range.3 ,col = "RED" , pch = 17 , cex= 1.5 , cex.axis = 2.0 , cex.lab = 2.0, ylab = "Temperature °C", 
     
     xlab = NA,  xaxt = "n" , tck = 1,  main = "2021" , cex.main = 3.0 );

polygon( x = c(rev(Plot.Data.T.5cm $Corrected.TIME), Plot.Data.T.5cm $Corrected.TIME ) , 
         
         y = c(rev(Plot.Data.T.5cm $T.Low ), Plot.Data.T.5cm $T.High ), col = adjustcolor( col = "RED" , alpha.f = 0.2), border = F) ;

grid(col = "BLACK")

########################### Plot T Depth = 20cm ################################################



points(Temperature_C.Avg ~ Corrected.TIME, data = Plot.Data.T.20cm  , type = "b" , col = "BLUE" , pch = 17 , cex= 1.5 ) ;


polygon( x = c(rev(Plot.Data.T.20cm $Corrected.TIME), Plot.Data.T.20cm $Corrected.TIME ) , 
         
         y = c(rev(Plot.Data.T.20cm $T.Low ), Plot.Data.T.20cm $T.High ), col = adjustcolor( col = "BLUE" , alpha.f = 0.2) , border = F) ;


####################################### adding a legend  ################################################

legend.1<-c("5 cm", "20 cm" )

legend.2<-c("solid" , "solid"  ) 

legend.4<-c( "RED" , "BLUE" )

legend.5<-c( 3, 3)

# legend(x = "bottomleft" , legend = legend.1, lty = legend.2,  pch = legend.3 , col = legend.4, 
#        pt.cex= 2.0 , lwd = legend.5, bty = "n", horiz = T, ncol = 2)

legend(x = "topleft" , legend = legend.1, lty = legend.2, col = legend.4, 
       pt.cex= 2.0 , lwd = legend.5, bty = "n", cex = 2.0, pch = 17)




# ########################### Plot Precipitation  Accumulation ################################################
# 
# par (mar = c(0, 6, 1 , 2) + 0.1)
# 
# 
# plot(Cumm.Prec ~ Date.Time , data = Weather.data.2021 , xlim = Weather.Date.Range , type = "l"  ,
# 
#      lwd = 5 , col = "MAGENTA" ,  cex= 1.5, cex.lab = 2.0,
# 
#      ylab = "Precipitation in" , xlab = NA,  xaxt = "n" , tck = 1,  cex.axis = 2.0) ;
# 
# grid(col = "BLACK")
# 

########################### Plot Precipitation  ################################################

plot(Precipitation.Increment..in. ~ Date.Time ,data = Weather.data.2021 , xlim = Weather.Date.Range ,

     type = "h", lwd = 10 , col = "MAGENTA" ,  cex= 1.5, cex.lab = 2.0,

     ylab = "Precipitation in" , xlab = NA,  xaxt = "n" , tck = 1,  cex.axis = 2.0) ;

grid(col = "BLACK")


########################### Plot Soil Moisture  ################################################


plot(Soil.Moisture.Sat.5cm ~ Date.Time , data = Weather.data.2021 , xlim = Weather.Date.Range , 
     
     ylim = c(0 , 1) , type = "b" , col = "RED" , cex = 2 , cex.lab = 2.0, pch = 17,
     
     ylab = "Soil Moisture" , xlab = NA,  xaxt = "n" , tck = 1,  cex.axis = 2.0) ;



points(Soil.Moisture.Sat.20cm ~ Date.Time , data = Weather.data.2021 ,  type = "b" ,
       
       col = "BLUE" , cex = 2 , pch = 17 ) ;


grid( col = "BLACK")




####################################### Plot O2 5cm   ################################################

plot(Calibrated.O2_Kpa.Avg ~ Corrected.TIME, data = Plot.Data.T.5cm , type = "b" , 
     
     xlim =  Date.Range.2021.8 , ylim = O2.Range.1 ,col = "RED" , pch = 17 , cex= 1.5, cex.lab = 2.0,
     
     ylab = "O2 - Kpa" , xlab = NA,  xaxt = "n" , tck = 1,  cex.axis = 2.0) ;

polygon( x = c(rev(Plot.Data.T.5cm $Corrected.TIME), Plot.Data.T.5cm $Corrected.TIME ) , 
         
         y = c(rev(Plot.Data.T.5cm$O2.Low ), Plot.Data.T.5cm$O2.High ), col = adjustcolor( col = "RED" , alpha.f = 0.2), border = F) ;

grid(col = "BLACK")



########################### Plot O2  20cm ################################################

Plot.Data.T.20cm <- Plot.Data.7[ Plot.Data.7$Depth_cm == "20" , ] ;

str( Plot.Data.T.20cm  )



points(Calibrated.O2_Kpa.Avg ~ Corrected.TIME, data = Plot.Data.T.20cm  , type = "b" , col = "BLUE" , pch = 17 , cex= 1.5 ) ;



polygon( x = c(rev(Plot.Data.T.20cm $Corrected.TIME), Plot.Data.T.20cm $Corrected.TIME ) , 
         
         y = c(rev(Plot.Data.T.20cm $O2.Low ), Plot.Data.T.20cm $O2.High ),
         
         col = adjustcolor( col = "BLUE" , alpha.f = 0.2) , border = F) ;












