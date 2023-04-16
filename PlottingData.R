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








+################## Select the core data to plot ##########################################################

str(Data.2021)

Block = "4"

C_Crop = "Triticale"


Sensor.Temperature.data.1 <- Data.2021[ Data.2021$Block == Block & Data.2021$C_Crop == C_Crop & Data.2021$Treatment == "B" ,] ;

########################  Plot the data  ##########################################################

Temperature.Range.3 <- c(19,46) ;

Date.Range.2021.3 <- as.POSIXct(c("2021-08-20 00:00:00", "2021-08-28 00:00:00")) ;



Plot.1 <- xyplot(Temperature_C ~ Corrected.TIME, groups =  Depth_cm ,  data = Sensor.Temperature.data.1 , type = "l",
       
        xlim = Date.Range.2021.3 , ylim = Temperature.Range.3 , auto.key = T, main = paste0("Block -", Block ,C_Crop ))  ;


Plot.1


###############################################################################################################
#                          Plot O2 
###############################################################################################################


str(Data.2021)

Date.Range.2021.1 <- as.POSIXct(c(min(Data.2021$Corrected.TIME) , max(Data.2021$Corrected.TIME) + (60*60*24*0))) ;

Date.Range.2021.3 <- as.POSIXct(c("2021-08-20 00:00:00", "2021-08-28 00:00:00")) ;

O2.Range.1 <- c(min(Data.2021$Calibrated.O2_Kpa , na.rm = T) , max(Data.2021$Calibrated.O2_Kpa , na.rm = T)) ;

O2.Range.2 <- c(0,30) ;

fill.colors <- colors()[1:18] ;


########################  Plot the data  ##########################################################

Data.2021$Grouped.Factors <- as.factor(paste(Data.2021$Block, Data.2021$C_Crop, Data.2021$Treatment, Data.2021$Depth_cm )) ;


xyplot(Calibrated.O2_Kpa ~ Corrected.TIME, 
       
       groups = Grouped.Factors,  data = Data.2021 ,  xlim = Date.Range.2021.1, ylim = O2.Range.2  , type = "p" , pch = 15, col = fill.colors,
       
       
       key = list(space = "right", adj = 1,
                  
                  text = list(levels(Data.2021$Grouped.Factors)),
                  
                  points = list(pch = 15 , col = fill.colors))) ;




################## Add new data to the plot with the package lattice extra ##########################################################

Block = "4"

C_Crop = "Triticale"


O2.data.2 <- Data.2021[ Data.2021$Block == Block & Data.2021$C_Crop == C_Crop & Data.2021$Treatment == "C" ,] ;


xyplot(Calibrated.O2_Kpa ~ Corrected.TIME, groups = Depth_cm,  data = O2.data.2  , type = "l",
                 
                 xlim = Date.Range.2021.1, ylim = O2.Range.2, main = paste0("Block -", Block ,C_Crop )) ;


###############################################################################################################
#                          Plot Cumulative Precipitation
###############################################################################################################

################## Select the time range similar to the time ramnge for T and 02 ##############################

str(Weather.data)

Weather.data.1 <- Weather.data[ Weather.data$Date.Time >= as.POSIXct("2021-08-20 00:00:01") & 
                                  
                                  Weather.data$Date.Time <= as.POSIXct("2021-08-28 00:00:00") , ] ;


Weather.data.1[is.na(Weather.data.1$Precipitation.Increment..in.), c("Precipitation.Increment..in.") ] = 0 ;

Weather.data.1$Cumm.Prec <- cumsum(Weather.data.1$Precipitation.Increment..in.) ;


str(Weather.data.1)


str(Weather.data$Date.Time)

Weather.Date.Range <- as.POSIXct(c("2021-08-20 00:00:01", "2021-08-28 00:00:00")) ;

plot(Cumm.Prec ~ Date.Time ,data = Weather.data.1 , xlim = Weather.Date.Range , type = "l" )


###############################################################################################################
#                         soil moisture 
###############################################################################################################


str(Weather.data.1)

Soil.Moisture.Range <- c(min(Weather.data.1[ , c("Soil.Moisture.Percent..2in..pct.", "Soil.Moisture.Percent..40in..pct.")], na.rm = T),
                         
                         max(Weather.data.1[ , c("Soil.Moisture.Percent..2in..pct.", "Soil.Moisture.Percent..40in..pct.")], na.rm = T)) ;

plot(Soil.Moisture.Percent..2in..pct. ~ Date.Time ,data = Weather.data.1 , xlim = Weather.Date.Range , 
     
     ylim = Soil.Moisture.Range, type = "l" , col = "RED" ) ;

points(Soil.Moisture.Percent..4in..pct. ~ Date.Time ,data = Weather.data.1 , xlim = Weather.Date.Range , 
     
      type = "l" , col = "BLUE" ) ;

points(Soil.Moisture.Percent..20in..pct. ~ Date.Time ,data = Weather.data.1 , xlim = Weather.Date.Range , 
       
       type = "l" , col = "CYAN" ) ;
points(Soil.Moisture.Percent..40in..pct. ~ Date.Time ,data = Weather.data.1 , xlim = Weather.Date.Range , 
       
       type = "l" , col = "MAGENTA" ) ;


################## compute rolling average ##############################

apply(embed(x = Weather.data.1$Soil.Moisture.Percent..2in..pct. , 3),1, mean)

filter(Weather.data.1$Soil.Moisture.Percent..2in..pct., rep(1 / n, n))

