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
# 
# 
# 
############################################################################################################### 



###############################################################################################################
#                             Tell the program where the package libraries are stored                        
###############################################################################################################


#  Tell the program where the package libraries are  #####################

.libPaths("C:/Felipe/SotwareANDCoding/R_Library/library")  ;


###############################################################################################################
#                             Setting up working directory  Loading Packages and Setting up working directory                        
###############################################################################################################


#      set the working directory

# readClipboard()

setwd("C:\\Felipe\\Willow_Project\\Willow_Experiments\\Willow Rock Spring\\SkyCap_SelectionTrial\\DataCollection") ;   # 

"https://pennstateoffice365.sharepoint.com/:f:/s/StrategicTillageAndN2O/Ehl9Lh_gza5FiOtKIyDD7MQBOKFdFk6h_k4EEYEktWJUYw?e=uYLqL0"

###############################################################################################################
#                            Install the packages that are needed                       
###############################################################################################################




###############################################################################################################
#                           load the libraries that are needed   
###############################################################################################################

library(openxlsx)

library(lattice)

library(rgdal)

library(raster)

library(sp)



###############################################################################################################
#                           load the files the will be needed  
###############################################################################################################


## Read which files are available in the directory

Files<-list.files("C:\\Users\\frm10\\The Pennsylvania State University\\StrategicTillageAndN2O - Documents\\Data\\O2SensorTesting")

## Select files that are ..xlsx only

Files[grep(".xlsx",Files)]

## read the files


Datalogger.Name<-read.xlsx("C:\\Users\\frm10\\The Pennsylvania State University\\StrategicTillageAndN2O - Documents\\Data\\O2SensorTesting\\B1Clover.dat.xlsx", sheet=1, startRow = 1, colNames = F, rows=1, cols=6) ;


Datalogger.Variables<-read.xlsx("C:\\Users\\frm10\\The Pennsylvania State University\\StrategicTillageAndN2O - Documents\\Data\\O2SensorTesting\\B1Clover.dat.xlsx", sheet=1, startRow = 2, colNames = T, rows=2) ;
names(Datalogger.Variables)

DataLogger.Data<-read.xlsx("C:\\Users\\frm10\\The Pennsylvania State University\\StrategicTillageAndN2O - Documents\\Data\\O2SensorTesting\\B1Clover.dat.xlsx", sheet=1, startRow = 5, colNames = F) ;

names(DataLogger.Data)<-names(Datalogger.Variables);


str(DataLogger.Data)

DataLogger.Data$TIME<-as.POSIXct(DataLogger.Data$TIMESTAMP, format="%Y-%m-%d %H:%M:%S") ;

DataLogger.Data$Plot<-unlist(Datalogger.Names[6]);
