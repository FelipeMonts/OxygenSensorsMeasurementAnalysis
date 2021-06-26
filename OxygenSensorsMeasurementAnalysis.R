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

## Read all the files
# i=Files[grep(".xlsx",Files)][1]

for (i in Files[grep(".xlsx",Files)] ) {
  
  ## read the dataloger names
  
  Datalogger.Name<-read.xlsx(paste0("C:\\Users\\frm10\\The Pennsylvania State University\\StrategicTillageAndN2O - Documents\\Data\\O2SensorTesting\\",i), sheet=1, startRow = 1, colNames = F, rows=1, cols=6) ;
  
  ## read the dataloggers varaible names
  
  Datalogger.Variables<-read.xlsx(paste0("C:\\Users\\frm10\\The Pennsylvania State University\\StrategicTillageAndN2O - Documents\\Data\\O2SensorTesting\\",i), sheet=1, startRow = 2, colNames = T, rows=2) ;
  names(Datalogger.Variables)
  
  
  ## read the data logger data
  DataLogger.Data<-read.xlsx(paste0("C:\\Users\\frm10\\The Pennsylvania State University\\StrategicTillageAndN2O - Documents\\Data\\O2SensorTesting\\",i), sheet=1, startRow = 5, colNames = F) ;
  
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




