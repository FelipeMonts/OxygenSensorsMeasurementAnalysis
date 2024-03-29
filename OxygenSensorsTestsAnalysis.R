##############################################################################################################
# 
# 
# Program to Analyze and plot oxygen sensor data collected from the Apogee S-210 sensors deployed in the 
# Strategic Tillage USDA-Nifa funded project
# 
#    
# 
# 
#  Felipe Montes 2021/06/26
# 
# Updated 2023/01/24
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




###############################################################################################################
#                           load the libraries that are needed   
###############################################################################################################
library(openxlsx)

library(lattice)



###############################################################################################################
#                           load the files that will be needed  
###############################################################################################################


### The original download data was processed and cleaned. It is stored in processed data directories in the downloaded folders


Files.Directories<-list.files();


Tests.Files<-list.files(paste0(".\\",Files.Directories[2])) ;



###############################################################################################################
#                           Read all the  excel files 
###############################################################################################################

# i=Tests.Files[grep(".xlsx",Tests.Files)][1]

for (i in Tests.Files[grep(".xlsx",Tests.Files)]) {
  
  ## read the dataloger names
  
  Datalogger.Name<-read.xlsx(paste0(getwd(), "\\" , Files.Directories[2] , "\\" , i), sheet=1, startRow = 1, colNames = F, rows=1, cols=6) ;
  
  ## read the dataloggers varaible names
  
  Datalogger.Variables<-read.xlsx(paste0(getwd(), "\\" , Files.Directories[2] , "\\" , i), sheet=1, startRow = 2, colNames = T, rows=2) ;
  names(Datalogger.Variables)
  
  
  ## read the data logger data
  DataLogger.Data<-read.xlsx(paste0(getwd(), "\\" , Files.Directories[2] , "\\" , i), sheet=1, startRow = 5, colNames = F) ;
  
  ## add the nmes of the variables to the datalogger data
  names(DataLogger.Data)<-names(Datalogger.Variables);
  
  str(DataLogger.Data)
  
  ## convert the excel numeric data format of the TIMESTAMP to the R data format POSIXct
  
  DataLogger.Data$TIME<-convertToDateTime(DataLogger.Data$TIMESTAMP) ;
  
  
  ## add the data logger name to all the records
  
  DataLogger.Data$Plot<-unlist(Datalogger.Name);
  
  ## crate an appropriate name for the data frame
  
  Name.of.DataLogger<-sub(i, pattern="*.dat.xlsx",replacement="");
  
  assign(Name.of.DataLogger,DataLogger.Data);
  
  
  rm(Datalogger.Name, Datalogger.Variables, DataLogger.Data, Name.of.DataLogger);
  
}

str(B1Clover)
names(B1Clover)

###############################################################################################################
#                           Read all the .dat files 
###############################################################################################################
#j= "1.dat"

for (j in c("1.dat" , "2.dat", "3.dat", "4.dat" ,"5.dat" ,"6.dat", "B4Triticale.dat") ) {
  
  ## read the dataloger names
  
  Datalogger.Name<-read.csv(paste0(getwd(), "\\" , Files.Directories[2] , "\\" ,j), header=F, nrows=1) ;
  
  ## read the dataloggers varaible names
  
  Datalogger.Variables<-read.csv(paste0(getwd(), "\\" , Files.Directories[2] , "\\" ,j), header=T, skip=1,nrows=1);
  names(Datalogger.Variables)
  
  
  ## read the data logger data
  DataLogger.Data<-read.csv(paste0(getwd(), "\\" , Files.Directories[2] , "\\" ,j), header=F, skip=4);
  
  ## add the nmes of the variables to the datalogger data
  names(DataLogger.Data)<-names(Datalogger.Variables);
  
  str(DataLogger.Data)
  
  ## convert the excel numeric data format of the TIMESTAMP to the R data format POSIXct
  
  DataLogger.Data$TIME<-as.POSIXct(DataLogger.Data$TIMESTAMP) ;
  
  
  ## add the data logger name to all the records
  
  DataLogger.Data$Plot<-unlist(Datalogger.Name[6]);
  
  ## crate an appropriate name for the data frame
  
  Name.of.DataLogger<-paste0("dat.",j);
  
  assign(Name.of.DataLogger,DataLogger.Data);
  
  
  rm(Datalogger.Name, Datalogger.Variables, DataLogger.Data, Name.of.DataLogger);
  
}




###############################################################################################################
#                           Plotting the data 
###############################################################################################################


## plotting B1Clover

## Combining the data with Oxybase

B1Clover.Oxybase<-merge(B1Clover, OXYbase, by="TIME");
names(B1Clover.Oxybase)

## Using the package Lattice

Plot.B1Clover<-xyplot(B1CloverA5cmO2_Avg + B1CloverA20cmO2_Avg + B1CloverB5cmO2_Avg + B1CloverB20cmO2_Avg + B1CloverC5cmO2_Avg + B1CloverC20cmO2_Avg + OXYBaseOxygen  ~TIME, data=B1Clover.Oxybase, xlim=c(as.POSIXct("2021-06-24 18:00"),as.POSIXct("2021-06-24 20:00")),auto.key = T, type="l", ylim=c(0,80))

Plot.B1Clover


## plotting B2Clover

## Combining the data with Oxybase

B2Clover.Oxybase<-merge(B2Clover, OXYbase, by="TIME");
names(B2Clover.Oxybase)

## Using the package Lattice

Plot.B2Clover<-xyplot(B2CloverA5cmO2_Avg + B2CloverA20cmO2_Avg + B2CloverB5cmO2_Avg + B2CloverB20cmO2_Avg + B2CloverC5cmO2_Avg + B2CloverC20cmO2_Avg + OXYBaseOxygen  ~TIME, data=B2Clover.Oxybase, xlim=c(as.POSIXct("2021-06-24 18:00"),as.POSIXct("2021-06-24 20:00")),auto.key = T, type="l", ylim=c(0,80)) ;

Plot.B2Clover


## plotting B2Triticale

## Combining the data with Oxybase

B2Triticale.Oxybase<-merge(B2Triticale, OXYbase, by="TIME");
names(B2Triticale.Oxybase)

## Using the package Lattice

Plot.B2Triticale<-xyplot(B2TriticaleA5cmO2_Avg + B2TriticaleA20cmO2_Avg + B2TriticaleB5cmO2_Avg + B2TriticaleB20cmO2_Avg + B2TriticaleC5cmO2_Avg + B2TriticaleC20cmO2_Avg + OXYBaseOxygen  ~TIME, data=B2Triticale.Oxybase, xlim=c(as.POSIXct("2021-06-24 18:00"),as.POSIXct("2021-06-24 20:00")),auto.key = T, type="l", ylim=c(0,80)) ;

Plot.B2Triticale

## plotting B3Clover

## Combining the data with Oxybase

B3Clover.Oxybase<-merge(B3Clover, OXYbase, by="TIME");
names(B3Clover.Oxybase)

## Using the package Lattice

Plot.B3Clover<-xyplot(B3CloverA5cmO2_Avg + B3CloverA20cmO2_Avg + B3CloverB5cmO2_Avg + B3CloverB20cmO2_Avg + B3CloverC5cmO2_Avg + B3CloverC20cmO2_Avg + OXYBaseOxygen  ~TIME, data=B3Clover.Oxybase, xlim=c(as.POSIXct("2021-06-24 18:00"),as.POSIXct("2021-06-24 20:00")),auto.key = T, type="l", ylim=c(0,80)) ;

Plot.B3Clover   

## plotting B4Clover

## Combining the data with Oxybase

B4Clover.Oxybase<-merge(B4Clover, OXYbase, by="TIME");
names(B4Clover.Oxybase)

## Using the package Lattice

Plot.B4Clover<-xyplot(B4CloverA5cmO2_Avg + B4CloverA20cmO2_Avg + B4CloverB5cmO2_Avg + B4CloverB20cmO2_Avg + B4CloverC5cmO2_Avg + B4CloverC20cmO2_Avg + OXYBaseOxygen  ~TIME, data=B4Clover.Oxybase, xlim=c(as.POSIXct("2021-06-24 18:00"),as.POSIXct("2021-06-24 20:00")),auto.key = T, type="l", ylim=c(0,80)) ;

Plot.B4Clover   



## plotting B4Triticale

## Combining the data with Oxybase

B4Triticale.Oxybase<-merge(B4Triticale, OXYbase, by="TIME");
names(B4Triticale.Oxybase)

## Using the package Lattice

Plot.B4Triticale<-xyplot(B4TriticaleA5cmO2_Avg + B4TriticaleA20cmO2_Avg + B4TriticaleB5cmO2_Avg + B4TriticaleB20cmO2_Avg + B4TriticaleC5cmO2_Avg + B4TriticaleC20cmO2_Avg + OXYBaseOxygen  ~TIME, data=B4Triticale.Oxybase, xlim=c(as.POSIXct("2021-06-24 15:00"),as.POSIXct("2021-06-24 20:00")),auto.key = T, type="l", ylim=c(0,80)) ;

Plot.B4Triticale  




## plotting dat.1.dat

## Combining the data with Oxybase

dat.1.dat.Oxybase<-merge(dat.1.dat, OXYbase, by="TIME");
names(dat.1.dat.Oxybase)

## Using the package Lattice

Plot.dat.1.dat<-xyplot(B13SppNA5cmO2_Avg + B13SppNA20cmO2_Avg + B13SppNB5cmO2_Avg + B13SppNB20cmO2_Avg + B13SppNC5cmO2_Avg + B13SppNC20cmO2_Avg + OXYBaseOxygen  ~TIME, data=dat.1.dat.Oxybase, xlim=c(as.POSIXct("2021-06-24 18:00"),as.POSIXct("2021-06-24 20:00")),auto.key = T, type="l", ylim=c(0,80)) ;

Plot.dat.1.dat   


## plotting dat.2.dat

## Combining the data with Oxybase

dat.2.dat.Oxybase<-merge(dat.2.dat, OXYbase, by="TIME");
names(dat.2.dat.Oxybase)

## Using the package Lattice

Plot.dat.2.dat<-xyplot(B43SppNA5cmO2_Avg + B43SppNA20cmO2_Avg + B43SppNB5cmO2_Avg + B43SppNB20cmO2_Avg + B43SppNC5cmO2_Avg + B43SppNC20cmO2_Avg + OXYBaseOxygen  ~TIME, data=dat.2.dat.Oxybase, xlim=c(as.POSIXct("2021-06-24 18:00"),as.POSIXct("2021-06-24 20:00")),auto.key = T, type="l", ylim=c(0,80)) ;

Plot.dat.2.dat  



## plotting dat.3.dat

## Combining the data with Oxybase

dat.3.dat.Oxybase<-merge(dat.3.dat, OXYbase, by="TIME");
names(dat.3.dat.Oxybase)

## Using the package Lattice

Plot.dat.3.dat<-xyplot(B33SppNA5cmO2_Avg + B33SppNA20cmO2_Avg + B33SppNB5cmO2_Avg + B33SppNB20cmO2_Avg + B33SppNC5cmO2_Avg + B33SppNC20cmO2_Avg + OXYBaseOxygen  ~TIME, data=dat.3.dat.Oxybase, xlim=c(as.POSIXct("2021-06-24 18:00"),as.POSIXct("2021-06-24 20:00")),auto.key = T, type="l", ylim=c(0,80)) ;

Plot.dat.3.dat  




## plotting dat.4.dat

## Combining the data with Oxybase

dat.4.dat.Oxybase<-merge(dat.4.dat, OXYbase, by="TIME");
names(dat.4.dat.Oxybase)

## Using the package Lattice

Plot.dat.4.dat<-xyplot(B1TriticaleA5cmO2_Avg + B1TriticaleA20cmO2_Avg + B1TriticaleB5cmO2_Avg + B1TriticaleB20cmO2_Avg + B1TriticaleC5cmO2_Avg + B1TriticaleC20cmO2_Avg + OXYBaseOxygen  ~TIME, data=dat.4.dat.Oxybase, xlim=c(as.POSIXct("2021-06-24 18:00"),as.POSIXct("2021-06-24 20:00")),auto.key = T, type="l", ylim=c(0,80)) ;

Plot.dat.4.dat 


## plotting dat.5.dat

## Combining the data with Oxybase

dat.5.dat.Oxybase<-merge(dat.5.dat, OXYbase, by="TIME");
names(dat.5.dat.Oxybase)

## Using the package Lattice

Plot.dat.5.dat<-xyplot(B23SppNA5cmO2_Avg + B23SppNA20cmO2_Avg + B23SppNB5cmO2_Avg + B23SppNB20cmO2_Avg + B23SppNC5cmO2_Avg + B23SppNC20cmO2_Avg + OXYBaseOxygen  ~TIME, data=dat.5.dat.Oxybase, xlim=c(as.POSIXct("2021-06-24 18:00"),as.POSIXct("2021-06-24 20:00")),auto.key = T, type="l", ylim=c(0,80)) ;

Plot.dat.5.dat 


## plotting dat.6.dat

## Combining the data with Oxybase

dat.6.dat.Oxybase<-merge(dat.6.dat, OXYbase, by="TIME");
names(dat.6.dat.Oxybase)

## Using the package Lattice

Plot.dat.6.dat<-xyplot(B3TriticaleA5cmO2_Avg + B3TriticaleA20cmO2_Avg + B3TriticaleB5cmO2_Avg + B3TriticaleB20cmO2_Avg + B3TriticaleC5cmO2_Avg + B3TriticaleC20cmO2_Avg + OXYBaseOxygen  ~TIME, data=dat.6.dat.Oxybase, xlim=c(as.POSIXct("2021-06-24 18:00"),as.POSIXct("2021-06-24 20:00")),auto.key = T, type="l", ylim=c(0,80)) ;

Plot.dat.6.dat 


## plotting dat.B4Triticale.dat

## Combining the data with Oxybase

dat.B4Triticale.dat.Oxybase<-merge(dat.B4Triticale.dat, OXYbase, by="TIME");
names(dat.B4Triticale.dat.Oxybase)

## Using the package Lattice

Plot.dat.B4Triticale.dat<-xyplot(B4TriticaleA5cmO2_Avg + B4TriticaleA20cmO2_Avg + B4TriticaleB5cmO2_Avg + B4TriticaleB20cmO2_Avg + B4TriticaleC5cmO2_Avg + B4TriticaleC20cmO2_Avg + OXYBaseOxygen  ~TIME, data=dat.B4Triticale.dat.Oxybase, xlim=c(as.POSIXct("2021-06-24 18:00"),as.POSIXct("2021-06-24 20:00")),auto.key = T, type="l", ylim=c(0,80)) ;

Plot.dat.B4Triticale.dat



###############################################################################################################
#                           
#   Transform the data into potential signal (mv) based on the calibration equation used in the tests
#   Alli suggested that the calibration equation is artificially increasing the differences between sensors. Tranforming the 
#   signal back to the uncalibrated potential my show that the differences between sensors are not signifficant (Brilliant!)
#  
#   The Equation is O2 = CF * Signal - offset 
#
#  Therefore Signal = (O2-offset) / CF 
#
#
#   with CF = 6.057 and Offset = 4.13
#
###############################################################################################################


str(dat.1.dat)

#### using mapply to subtract the offset from the O2 Data

mapply('-', dat.1.dat[,c(5,7,9,11,13,15)], c(4.13)) ;


#### using mapply to divide the offset corrected data by the CF


mapply('/', mapply('-', dat.1.dat[,c(5,7,9,11,13,15)], c(4.13), SIMPLIFY = F), c(6.057), SIMPLIFY = T) ;


### combining both operations into one

dat.1.Signal<-data.frame(mapply('/', mapply('-', dat.1.dat[,c(5,7,9,11,13,15)], c(4.13), SIMPLIFY = F), c(6.057) , SIMPLIFY = T)) ;

names(dat.1.Signal)<-paste0("Signal_", names(dat.1.dat[c(5,7,9,11,13,15)])) ;

dat.1<- cbind(dat.1.dat , dat.1.Signal);


dat.2.Signal<-data.frame(mapply('/', mapply('-', dat.2.dat[,c(5,7,9,11,13,15)], c(4.13), SIMPLIFY = F), c(6.057) , SIMPLIFY = T)) ;

names(dat.2.Signal)<-paste0("Signal_", names(dat.2.dat[c(5,7,9,11,13,15)])) ;

dat.2<- cbind(dat.2.dat , dat.2.Signal);


dat.3.Signal<-data.frame(mapply('/', mapply('-', dat.3.dat[,c(5,7,9,11,13,15)], c(4.13), SIMPLIFY = F), c(6.057) , SIMPLIFY = T)) ;

names(dat.3.Signal)<-paste0("Signal_", names(dat.3.dat[c(5,7,9,11,13,15)])) ;

dat.3<- cbind(dat.3.dat , dat.3.Signal);


dat.4.Signal<-data.frame(mapply('/', mapply('-', dat.4.dat[,c(5,7,9,11,13,15)], c(4.13), SIMPLIFY = F), c(6.057) , SIMPLIFY = T)) ;

names(dat.4.Signal)<-paste0("Signal_", names(dat.4.dat[c(5,7,9,11,13,15)])) ;

dat.4<- cbind(dat.4.dat , dat.4.Signal);


dat.5.Signal<-data.frame(mapply('/', mapply('-', dat.5.dat[,c(5,7,9,11,13,15)], c(4.13), SIMPLIFY = F), c(6.057) , SIMPLIFY = T)) ;

names(dat.5.Signal)<-paste0("Signal_", names(dat.5.dat[c(5,7,9,11,13,15)])) ;

dat.5<- cbind(dat.5.dat , dat.5.Signal);


dat.6.Signal<-data.frame(mapply('/', mapply('-', dat.6.dat[,c(5,7,9,11,13,15)], c(4.13), SIMPLIFY = F), c(6.057) , SIMPLIFY = T)) ;

names(dat.6.Signal)<-paste0("Signal_", names(dat.6.dat[c(5,7,9,11,13,15)])) ;

dat.6<- cbind(dat.6.dat , dat.6.Signal);



## plotting dat.1


## Using the package Lattice

Plot.dat.1<-xyplot(Signal_B13SppNA5cmO2_Avg + Signal_B13SppNA20cmO2_Avg + Signal_B13SppNB5cmO2_Avg + Signal_B13SppNB20cmO2_Avg + Signal_B13SppNC5cmO2_Avg + Signal_B13SppNC20cmO2_Avg   ~TIME, data=dat.1, xlim=c(as.POSIXct("2021-06-24 18:00"),as.POSIXct("2021-06-24 20:00")),auto.key = T, type="l") ;

Plot.dat.1


## plotting dat.2 

## Using the package Lattice

Plot.dat.2<-xyplot(Signal_B43SppNA5cmO2_Avg + Signal_B43SppNA20cmO2_Avg + Signal_B43SppNB5cmO2_Avg + Signal_B43SppNB20cmO2_Avg + Signal_B43SppNC5cmO2_Avg + Signal_B43SppNC20cmO2_Avg   ~ TIME, data=dat.2, xlim=c(as.POSIXct("2021-06-24 18:00"),as.POSIXct("2021-06-24 20:00")),auto.key = T, type="l") ;

Plot.dat.2

## plotting dat.3 
## Using the package Lattice

Plot.dat.3<-xyplot(Signal_B33SppNA5cmO2_Avg + Signal_B33SppNA20cmO2_Avg + Signal_B33SppNB5cmO2_Avg + Signal_B33SppNB20cmO2_Avg + Signal_B33SppNC5cmO2_Avg + Signal_B33SppNC20cmO2_Avg  ~ TIME, data=dat.3, xlim=c(as.POSIXct("2021-06-24 18:00"),as.POSIXct("2021-06-24 20:00")),auto.key = T, type="l") ;

Plot.dat.3

## plotting dat.4 
## Using the package Lattice

Plot.dat.4<-xyplot(Signal_B1TriticaleA5cmO2_Avg + Signal_B1TriticaleA20cmO2_Avg + Signal_B1TriticaleB5cmO2_Avg + Signal_B1TriticaleB20cmO2_Avg + Signal_B1TriticaleC5cmO2_Avg + Signal_B1TriticaleC20cmO2_Avg  ~ TIME, data=dat.4, xlim=c(as.POSIXct("2021-06-24 18:00"),as.POSIXct("2021-06-24 20:00")),auto.key = T, type="l") ;

Plot.dat.4 


## plotting dat.5
## Using the package Lattice

Plot.dat.5<-xyplot(Signal_B23SppNA5cmO2_Avg + Signal_B23SppNA20cmO2_Avg + Signal_B23SppNB5cmO2_Avg + Signal_B23SppNB20cmO2_Avg + Signal_B23SppNC5cmO2_Avg + Signal_B23SppNC20cmO2_Avg  ~ TIME, data=dat.5, xlim=c(as.POSIXct("2021-06-24 18:00"),as.POSIXct("2021-06-24 20:00")),auto.key = T, type="l") ;

Plot.dat.5 


## plotting dat.6.dat
## Using the package Lattice

Plot.dat.6<-xyplot(Signal_B3TriticaleA5cmO2_Avg + Signal_B3TriticaleA20cmO2_Avg + Signal_B3TriticaleB5cmO2_Avg + Signal_B3TriticaleB20cmO2_Avg + Signal_B3TriticaleC5cmO2_Avg + Signal_B3TriticaleC20cmO2_Avg ~ TIME, data=dat.6, xlim=c(as.POSIXct("2021-06-24 18:00"),as.POSIXct("2021-06-24 20:00")),auto.key = T, type="l") ;

Plot.dat.6