##############################################################################################################
# 
# 
# Program to Analyze and plot oxygen sensor data collected from the Apogee S-210 sensors deployed in the 
# Strategic Tillage USda-Nifa funded project
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





###############################################################################################################
#                           load the files that will be needed  
###############################################################################################################


### The original download data was processed and cleaned. It is stored in processed data directories in the downloaded folders


Main.Directorys<-c("./OxygenSensorsData2021" , "./OxygenSensorsData2022_2023" ) ;

Main.Directorys

MD=1

Main.Directorys[MD]


Files.Directories<-list.files(Main.Directorys[MD]);

Files.Directories

File.to.Download = 1

Files.Directories[[File.to.Download]]

## Read which files are available in the ProcessedData directory

Files.to.Read<-list.files(paste0(Main.Directorys[MD],"\\",Files.Directories[[File.to.Download]], "\\" , "ProcessedData")) ;

Files.to.Read

Read.File.No=1

Files.to.Read[Read.File.No]


###############################################################################################################
#                           Read all the Downloaded files
###############################################################################################################

# Initiate the data frame

O2.Data.2021.0<-data.frame( Corrected.TIME = character(), Block = integer() , C_Crop = character() , Treatment = character(), Depth_cm = integer() , 
                           Temperature_C = double() , Calibrated.O2_Kpa = double()  ) ;

str(O2.Data.2021.0)

#i = Files.to.Read[1]

for (i in Files.to.Read) {
  
  O2.Data.2021.1<-read.csv(file= paste0(Main.Directorys[MD],"\\",Files.Directories[[File.to.Download]], "\\" , "ProcessedData" ,"\\", i),
           header = T) ;
  
  O2.Data.2021.2<-rbind(O2.Data.2021.0, O2.Data.2021.1) ;
  
  
  O2.Data.2021.3<-O2.Data.2021.2 ;
  
  rm(O2.Data.2021.2) ;
  
  
}

str(O2.Data.2021.3)

#### Give each column the adequate format

O2.Data.2021.3[,c("Corrected.TIME")]<-as.POSIXct(O2.Data.2021.3[,c("Corrected.TIME")]) ;


O2.Data.2021.3$Block<-as.factor(O2.Data.2021.3$Block) ;

O2.Data.2021.3$C_Crop<-as.factor(O2.Data.2021.3$C_Crop) ;

O2.Data.2021.3$Treatment<-as.factor(O2.Data.2021.3$Treatment) ;

O2.Data.2021.3$Depth_cm<-as.factor(O2.Data.2021.3$Depth_cm) ;


str(O2.Data.2021.3)


##### check for duplicated data 

anyDuplicated(O2.Data.2021.3)

any(duplicated(O2.Data.2021.3))


###############################################################################################################
#                           Plotting the data to explore
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
