##############################################################################################################
# 
# 
# Program to Calibrate Oxygen sensor data collected from Apogee O2 201 Sensors to data collected simultaneously as  
# 
#  The Oxybase sensor data connected to a and CR1000 data loggers 
#  
# 
# Felipe Montes 2023/01/26
# 
#
# 
# 
############################################################################################################### 

###############################################################################################################
#                       Campbell Scientific Data-logger Oxygen measurement program example for the S200                    
###############################################################################################################
# 'CR1000 Series Datalogger
# 'Datalogger program for Apogee Instruments model SO-200 series oxygen sensors
# 'date: May 6, 2021
# 'program author: Alli Koehle
# 
# 'Explanation of Constants and Variables Used in Datalogger Program
# 'CF = calibration factor (slope) to convert voltage signal to pressure
# 'Offset = offset (intercept) to convert voltage signal to pressure
# 'BattV = datalogger battery voltage
# 'PanelT = datalogger panel temperature
# 'Signal = mV signal output from pressure sensor
# 'O2 = absolute oxygen concentration in kilopascals
# 'SensorTC = sensor temperature in degrees Celsius
# 
# 'Declare Public Variables
# Public BattV, PanelT
# Public B33SppNA5cmO2, B33SppNA5cmTemp, B33SppNA5cmSignal,
# Public B33SppNA20cmO2, B33SppNA20cmTemp, B33SppNA20cmSignal,
# Public B33SppNB5cmO2, B33SppNB5cmTemp, B33SppNB5cmSignal,
# Public B33SppNB20cmO2, B33SppNB20cmTemp, B33SppNB20cmSignal,
# Public B33SppNC5cmO2, B33SppNC5cmTemp, B33SppNC5cmSignal,
# Public B33SppNC20cmO2, B33SppNC20cmTemp, B33SppNC20cmSignal
# 
# 'Declare Constants
# 'Const CF = 0.388 'sensor specific
# 'Const Offset = 1.35 'sensor specific
# Const CF = 1
# Const Offset = 0
# 
# 'Define Data Table
# DataTable (Oxygen,1,-1)
# 	DataInterval (0,30,Min,10)
# 	Minimum(1,BattV,IEEE4,0,False)
# 	Sample(1,PanelT,IEEE4)
# 'A 5cm
# Median(1,B33SppNA5cmO2,30,IEEE4,0)
# Median(1,B33SppNA5cmTemp,30,IEEE4,0)
# 'A 20cm
# 	Median(1,B33SppNA20cmO2,30,IEEE4,0)
# 	Median(1,B33SppNA20cmTemp,30,IEEE4,0)
# 'B 5 cm
# Median(1,B33SppNB5cmO2,30,IEEE4,0)
# Median(1,B33SppNB5cmTemp,30,IEEE4,0)
# 'B 20 cm
# 	Median(1,B33SppNB20cmO2,30,IEEE4,0)
# 	Median(1,B33SppNB20cmTemp,30,IEEE4,0)
# 'C 5 cm
# Median(1,B33SppNC5cmO2,30,IEEE4,0)
# Median(1,B33SppNC5cmTemp,30,IEEE4,0)
# 'C 20 cm
# 	Median(1,B33SppNC20cmO2,30,IEEE4,0)
# 	Median(1,B33SppNC20cmTemp,30,IEEE4,0)
# EndTable
# 
# 
# 'Main Program
# BeginProg
# Scan(1,Min,0,0)
# Battery(BattV)
# PanelTemp(PanelT,_60Hz)
# 'A 5cm
# 	    VoltDiff (B33SppNA5cmSignal,1,mV250,1,True ,0,_60Hz,1.0,0)
# 	    B33SppNA5cmO2 = CF * B33SppNA5cmSignal - Offset
#     	   Therm109 (B33SppNA5cmTemp,1,3,Vx1,0,_60Hz,1.0,0)
# 'A 20cm
# VoltDiff (B33SppNA20cmSignal,1,mV250,2,True ,0,_60Hz,1.0,0)
# B33SppNA20cmO2 = CF * B33SppNA20cmSignal - Offset
# Therm109 (B33SppNA20cmTemp,1,5,Vx1,0,_60Hz,1.0,0)
# 'B 5 cm
# 	    VoltDiff (B33SppNB5cmSignal,1,mV250,3,True ,0,_60Hz,1.0,0)
# 	    B33SppNB5cmO2 = CF * B33SppNB5cmSignal - Offset
#    	Therm109 (B33SppNB5cmTemp,1,7,Vx2,0,_60Hz,1.0,0)
# 'B 20 cm
# VoltDiff (B33SppNB20cmSignal,1,mV250,4,True ,0,_60Hz,1.0,0)
# B33SppNB20cmO2 = CF * B33SppNB20cmSignal - Offset
# Therm109 (B33SppNB20cmTemp,1,9,Vx2,0,_60Hz,1.0,0)
# 'C 5 cm
# 	    VoltDiff (B33SppNC5cmSignal,1,mV250,5,True ,0,_60Hz,1.0,0)
# 	    B33SppNC5cmO2 = CF * B33SppNC5cmSignal - Offset
#    	Therm109 (B33SppNC5cmTemp,1,11,Vx3,0,_60Hz,1.0,0)
# 'C 20 cm
# VoltDiff (B33SppNC20cmSignal,1,mV250,6,True ,0,_60Hz,1.0,0)
# B33SppNC20cmO2 = CF * B33SppNC20cmSignal - Offset
# Therm109 (B33SppNC20cmTemp,1,13,Vx3,0,_60Hz,1.0,0)
# 
# 'Call Output Tables
# 		CallTable Oxygen
# 	NextScan
# EndProg

###############################################################################################################
#     Campbell Scientific Data-logger Oxygen measurement program example for the Oxybase_RS232 Sensor                    
###############################################################################################################

# 
# 'defining variables
# Public SendText As String * 256
# Public ReceiveText As String * 128
# Public SerialError As Long
# Public SplitText(6) As String * 16
# Public OXYBaseAmp As Long
# Public OXYBasePhase As Float
# Public OXYBaseTemp As Float
# Public OXYBaseOxygen As Float
# Public OXYBaseError As Long
# Public RawString As String *128
# Public PTemp, batt_volt
# 
# 'defines the data table
# DataTable (OXYbase,1,-1)
# Sample(1, batt_volt, FP2)
# Sample(1, PTemp, FP2)
# Sample(1, RawString, String)
# Sample(1, OXYBaseAmp, Long)
# Sample(1, OXYBasePhase, FP2)
# Sample(1, OXYBaseTemp, FP2)
# Sample(1, OXYBaseOxygen, FP2)
# Sample(1, OXYBaseError, Long)
# EndTable
# 
# Sub OXYBaseSerialSetup
# 'subroutine to initialize the RS232 interface
#   Call OXYBaseSend 
#   SerialOpen (ComC5,19200,16,20,1000,0)
#   SendText="mode0001"+CHR(13)
#   Call OXYBaseSend
# EndSub
# 
# Sub OXYBaseSend
#   'subroutine to send texts
# SerialError=SerialOut (ComC5,SendText,"",1,100)
# EndSub
# 
# 
# Sub OXYBaseData
# 'subroutine to receive data
#   SendText="data"+CHR(13)
#   ReceiveText=""
#   Call OXYBaseSend
# EndSub
# 
# BeginProg
#   Call OXYBaseSerialSetup
# 
#   Scan (5, sec, 0, 0) 'exemplary 5 sec as interval
# 
# Call OXYBaseData 'sending "data" to the OXYBase results in sending of the data as an ASCII-String
#     SerialIn(RawString,ComC5, 200,13,256) 'reading in the string
# SplitStr(SplitText(),RawString, CHR(59),6,0) 'splitting the string into the value parts
#     OXYBaseAmp=Mid(SplitText(2),1,7)
#     OXYBasePhase=Mid(SplitText(3),1,7)
#     OXYBaseTemp=Mid(SplitText(4),1,7)
#     OXYBaseOxygen=Mid(SplitText(5),1,7)
#     OXYBaseError=Mid(SplitText(6),1,7)
# 'recalculating data
# OXYBasePhase=OXYBasePhase/100
# OXYBaseTemp=OXYBaseTemp/100
# OXYBaseOxygen=OXYBaseOxygen/100
# 'getting board data: temperature and voltage
#     PanelTemp(PTemp, 250)
#     Battery(batt_volt)
#     'storing the obtained values in the data table
# CallTable OXYBase
# 
#NextScan



###############################################################################################################
#                             Setting up working directory  Loading Packages and Setting up working directory                        
###############################################################################################################


#      set the working directory

# readClipboard() Willow Rock Spring\\SkyCap_SelectionTrial\\DataCollection") ;   # 

setwd("C:\\Users\\frm10\\OneDrive - The Pennsylvania State University\\O2Sensors") ;

###############################################################################################################
#                            Install the packages that are needed                       
###############################################################################################################


###############################################################################################################
#                           load the libraries that are needed   
###############################################################################################################
#library(openxlsx) ;


# ####################################################################################################################
# #                           Explore the files and directory and files with the data Oxygen calibration files in 2021
# ####################################################################################################################
# 
# ### working with the O2SensorCalibration.xlsx file
# 
# O2SensorCalibration.data<-read.xlsx(xlsxFile = ".\\O2SensorTesting\\Calibration\\O2SensorCalibration.xlsx", sheet= "CR1000_Oxygen_FM202301" , startRow = 1 , colNames = TRUE) ;
# 
# head(O2SensorCalibration.data)
# tail(O2SensorCalibration.data)
# 
# ### There is an error in the time stamp after 12:59 pm. It changes to 1:00 AM
# 
# O2SensorCalibration.data[O2SensorCalibration.data$Time >= 0.54 & O2SensorCalibration.data$Time <= 0.55,] ;
# 
# ### The error starts after Time 0.5414931, row no 310
# 
# length(O2SensorCalibration.data$Time)
# 
# O2SensorCalibration.data$Time[310:length(O2SensorCalibration.data$Time) ]
# 
# O2SensorCalibration.data$Time[311:length(O2SensorCalibration.data$Time) ]
# 
# #### correcting the time stamp
# 
# O2SensorCalibration.data$CorrectedTime<-NA ;
# 
# O2SensorCalibration.data$CorrectedTime[1:310]<-O2SensorCalibration.data$Time[1:310];
# 
# O2SensorCalibration.data$CorrectedTime[311:length(O2SensorCalibration.data$Time)]<-O2SensorCalibration.data$Time[311:length(O2SensorCalibration.data$Time)]+0.55 ;
# 
# ###############################################################################################################
# #                           Explore the data
# ###############################################################################################################
# 
# ### O2SensorCalibration.xlsx data
# 
# plot(S200Ox_kPa~CorrectedTime, data=O2SensorCalibration.data, col="BLUE") ;
# points(OXYBaseOx_kPa~CorrectedTime, data=O2SensorCalibration.data, col="RED") ;
# 
# plot(OXYBaseOx_kPa~S200Ox_kPa, data=O2SensorCalibration.data, col="BLUE") ;
# #text(O2SensorCalibration.data$OXYBaseOx_kPa, O2SensorCalibration.data$S200Ox_kPa,labels=O2SensorCalibration.data$CorrectedTime.h) ;
# 

# ####################################################################################################################
# #                           Explore the files and files with the data Oxygen calibration files in 2023
# ####################################################################################################################


Calibration.Data.Dir <- list.files(".\\OxygenSensorsData2022_2023\\Calibration2023\\CalibrationData")  ;

Calibration.Data.Dir

### get the data in the Oxygen data table 

CR1000X.Tables <- list.files(paste0(".\\OxygenSensorsData2022_2023\\Calibration2023\\CalibrationData", "\\" , Calibration.Data.Dir[1]))

CR1000X.Tables

grep(pattern = "Oxygen" , CR1000X.Tables)

CR1000X.Tables[grep(pattern = "Oxygen" , CR1000X.Tables)]

CR1000X.Oxygen.Names <- read.csv(file = paste0(".\\OxygenSensorsData2022_2023\\Calibration2023\\CalibrationData", "\\" ,
                                         
                                         Calibration.Data.Dir[1], "\\", CR1000X.Tables[grep(pattern = "Oxygen" , CR1000X.Tables)]), 
                           
                           skip = 1, header = F , nrows = 1);


CR1000X.Oxygen.0321 <- read.csv(file = paste0(".\\OxygenSensorsData2022_2023\\Calibration2023\\CalibrationData", "\\" ,
                                               
                                               Calibration.Data.Dir[1], "\\", CR1000X.Tables[grep(pattern = "Oxygen" , CR1000X.Tables)]), 
                                 
                                 skip = 4, header = F );


CR1000X.Oxygen.0324 <- read.csv(file = paste0(".\\OxygenSensorsData2022_2023\\Calibration2023\\CalibrationData", "\\" ,
                                              
                                              Calibration.Data.Dir[2], "\\", CR1000X.Tables[grep(pattern = "Oxygen" , CR1000X.Tables)]), 
                                
                                skip = 4, header = F );


#####  "20230328" - Calibration.Data.Dir[3] is the Zero data and is raw data not medians

CR1000X.Oxygen.0328 <- read.csv(file = paste0(".\\OxygenSensorsData2022_2023\\Calibration2023\\CalibrationData", "\\" ,
                                              
                                              Calibration.Data.Dir[3], "\\", CR1000X.Tables[grep(pattern = "Oxygen" , CR1000X.Tables)]), 
                                
                                skip = 4, header = F );


CR1000X.Oxygen.0329 <- read.csv(file = paste0(".\\OxygenSensorsData2022_2023\\Calibration2023\\CalibrationData", "\\" ,
                                              
                                              Calibration.Data.Dir[4], "\\", CR1000X.Tables[grep(pattern = "Oxygen" , CR1000X.Tables)]), 
                                
                                skip = 4, header = F );

##### Explore the zero data "20230328" - Calibration.Data.Dir[3] 

CR1000X.Zero.Names <- read.csv(file = paste0(".\\OxygenSensorsData2022_2023\\Calibration2023\\CalibrationData", "\\" ,
                                               
                                               Calibration.Data.Dir[3], "\\", CR1000X.Tables[grep(pattern = "Oxygen" , CR1000X.Tables)]), 
                                 
                                 skip = 1, header = F , nrows = 1);

CR1000X.Zero <- CR1000X.Oxygen.0328 ;


names(CR1000X.Zero) <- CR1000X.Zero.Names  ;

head(CR1000X.Zero)

str(CR1000X.Zero)

summary(CR1000X.Zero)


##### Explore the Zero Temperature data in a plot #####

head(CR1000X.Zero[, c(4, 6, 8, 10, 12, 14, 16 , 18 , 21)])

T.range <- range(CR1000X.Zero[, c(4, 6, 8, 10, 12, 14, 16 , 18, 21)]) ;

T.range


plot(S210_1_TC ~ RECORD, data = CR1000X.Zero,  type = "l" , lwd = 4 ,col = 1, ylab = "Temperature °C" , ylim = T.range );

points(S210_2_TC ~ RECORD, data = CR1000X.Zero,  type = "l" , lwd = 4, col = 2) ;

points(S210_3_TC ~ RECORD, data = CR1000X.Zero,  type = "l" , lwd = 4, col = 3) ;

points(S210_4_TC ~ RECORD, data = CR1000X.Zero,  type = "l" , lwd = 4, col = 4) ;

points(S210_5_TC ~ RECORD, data = CR1000X.Zero,  type = "l" , lwd = 4, col = 5) ;

points(S210_6_TC ~ RECORD, data = CR1000X.Zero,  type = "l" , lwd = 4, col = 6) ;

points(S210_7_TC ~ RECORD, data = CR1000X.Zero,  type = "l" , lwd = 4, col = 7) ;

points(OXYBaseTemp ~ RECORD, data = CR1000X.Zero,  type = "l" , lwd = 4, col = 8) ;

points(PanelT ~ RECORD, data = CR1000X.Zero,  type = "l" , lwd = 4, col = "RED" );


##### Explore the Zero Oxygen  data in a plot #####


head(CR1000X.Zero[, c(5, 7, 9, 11, 13, 15 , 17 , 22)]) 

O2.range <- range(CR1000X.Zero[, c(5, 7, 9, 11, 13, 15 , 17 , 22)]) ;


plot(S210_1_Smv ~ RECORD, data = CR1000X.Zero,  type = "l" , lwd = 4 ,col = 1, ylab = "O2 mV - Pa"  , ylim = O2.range );

points(S210_2_Smv ~ RECORD, data = CR1000X.Zero,  type = "l" , lwd = 4, col = 2) ;

points(S210_3_Smv ~ RECORD, data = CR1000X.Zero,  type = "l" , lwd = 4, col = 3) ;

points(S210_4_Smv ~ RECORD, data = CR1000X.Zero,  type = "l" , lwd = 4, col = 4) ;

points(S210_5_Smv ~ RECORD, data = CR1000X.Zero,  type = "l" , lwd = 4, col = 5) ;

points(S210_6_Smv ~ RECORD, data = CR1000X.Zero,  type = "l" , lwd = 4, col = 6) ;

points(S210_7_Smv ~ RECORD, data = CR1000X.Zero,  type = "l" , lwd = 4, col = 7) ;

points(OXYBaseOxygen ~ RECORD, data = CR1000X.Zero,  type = "l" , lwd = 4, col = 8) ;



#### combine all data series ##


CR1000X.Oxygen <- rbind(CR1000X.Oxygen.0321, CR1000X.Oxygen.0324 , CR1000X.Oxygen.0328 , CR1000X.Oxygen.0329) ;


names(CR1000X.Oxygen) <- CR1000X.Oxygen.Names ;

#### Time stamp as date ###

CR1000X.Oxygen$TIME<-as.POSIXct(CR1000X.Oxygen$TIMESTAMP) ;


head(CR1000X.Oxygen)

str(CR1000X.Oxygen)

summary(CR1000X.Oxygen)

#### Add an universal record No  ######

dim(CR1000X.Oxygen)

CR1000X.Oxygen$Record.Number <- seq(1, dim(CR1000X.Oxygen)[[1]] ) ;

##### Explore the Temperature data in a plot #####

head(CR1000X.Oxygen[, c(6, 8, 10, 12, 14, 16 , 18 , 21)])

T.range <- range(CR1000X.Oxygen[, c(6, 8, 10, 12, 14, 16 , 18, 21)]) ;


plot(S210_1_TC_Med ~ Record.Number, data = CR1000X.Oxygen,  type = "l" , lwd = 4 ,col = 1, ylab = "Temperature °C" , ylim = T.range );

points(S210_2_TC_Med ~ Record.Number, data = CR1000X.Oxygen,  type = "l" , lwd = 4, col = 2) ;

points(S210_3_TC_Med ~ Record.Number, data = CR1000X.Oxygen,  type = "l" , lwd = 4, col = 3) ;

points(S210_4_TC_Med ~ Record.Number, data = CR1000X.Oxygen,  type = "l" , lwd = 4, col = 4) ;

points(S210_5_TC_Med ~ Record.Number, data = CR1000X.Oxygen,  type = "l" , lwd = 4, col = 5) ;

points(S210_6_TC_Med ~ Record.Number, data = CR1000X.Oxygen,  type = "l" , lwd = 4, col = 6) ;

points(S210_7_TC_Med ~ Record.Number, data = CR1000X.Oxygen,  type = "l" , lwd = 4, col = 7) ;

points(OXYBaseTemp_Med ~ Record.Number, data = CR1000X.Oxygen,  type = "l" , lwd = 4, col = 8) ;



##### S210 vs Oxybase Temperature ####


plot(S210_1_TC_Med ~ OXYBaseTemp_Med, data = CR1000X.Oxygen  ,col = 1,  xlab = "Oxybase Temperature °C" , ylab = "S-210 Temperature °C" , ylim = T.range );

points(S210_2_TC_Med ~ OXYBaseTemp_Med, data = CR1000X.Oxygen,   col = 2) ;

points(S210_3_TC_Med ~ OXYBaseTemp_Med, data = CR1000X.Oxygen,   col = 3) ;

points(S210_4_TC_Med ~ OXYBaseTemp_Med, data = CR1000X.Oxygen,   col = 4) ;

points(S210_5_TC_Med ~ OXYBaseTemp_Med, data = CR1000X.Oxygen,   col = 5) ;

points(S210_6_TC_Med ~ OXYBaseTemp_Med, data = CR1000X.Oxygen,   col = 6) ;

points(S210_7_TC_Med ~ OXYBaseTemp_Med, data = CR1000X.Oxygen,   col = 7) ;






##### Explore the Oxygen data in a plot #####

head(CR1000X.Oxygen[, c(5, 7, 9, 11, 13, 15 , 17 , 22)])

O2.range <- range(CR1000X.Oxygen[, c(5, 7, 9, 11, 13, 15 , 17 , 22)]) ;


plot(S210_1_Smv_Med ~ Record.Number, data = CR1000X.Oxygen,  type = "l" , lwd = 4 ,col = 1, ylab = "O2 mV - Pa"  , ylim = O2.range );

points(S210_2_Smv_Med ~ Record.Number, data = CR1000X.Oxygen,  type = "l" , lwd = 4, col = 2) ;

points(S210_3_Smv_Med ~ Record.Number, data = CR1000X.Oxygen,  type = "l" , lwd = 4, col = 3) ;

points(S210_4_Smv_Med ~ Record.Number, data = CR1000X.Oxygen,  type = "l" , lwd = 4, col = 4) ;

points(S210_5_Smv_Med ~ Record.Number, data = CR1000X.Oxygen,  type = "l" , lwd = 4, col = 5) ;

points(S210_6_Smv_Med ~ Record.Number, data = CR1000X.Oxygen,  type = "l" , lwd = 4, col = 6) ;

points(S210_7_Smv_Med ~ Record.Number, data = CR1000X.Oxygen,  type = "l" , lwd = 4, col = 7) ;

points(OXYBaseOxygen_Med ~ Record.Number, data = CR1000X.Oxygen,  type = "l" , lwd = 4, col = 8) ;



##### S210 vs Oxybase O2 ####



plot(S210_1_Smv_Med ~ OXYBaseOxygen_Med, data = CR1000X.Oxygen  ,col = 1, xlab = "Oxybase O2 Pa" , ylab = "S210 mV" , ylim = O2.range );

points(S210_2_Smv_Med ~ OXYBaseOxygen_Med, data = CR1000X.Oxygen,   col = 2) ;

points(S210_3_Smv_Med ~ OXYBaseOxygen_Med, data = CR1000X.Oxygen,   col = 3) ;

points(S210_4_Smv_Med ~ OXYBaseOxygen_Med, data = CR1000X.Oxygen,   col = 4) ;

points(S210_5_Smv_Med ~ OXYBaseOxygen_Med, data = CR1000X.Oxygen,   col = 5) ;

points(S210_6_Smv_Med ~ OXYBaseOxygen_Med, data = CR1000X.Oxygen,   col = 6) ;

points(S210_7_Smv_Med ~ OXYBaseOxygen_Med, data = CR1000X.Oxygen,   col = 7) ;


###############################################################################################################
#                          Correct Measurements for temperature 
###############################################################################################################





###############################################################################################################
#                          start the calibration process
###############################################################################################################

# pull all the data of the S210 sensors into one variable for the regression

str(CR1000X.Oxygen)

O2SensorCalibration.data <- CR1000X.Oxygen[, c( "Record.Number" , "S210_1_Smv_Med" , "S210_1_TC_Med" , "OXYBaseOxygen_Med")] ;

O2SensorCalibration.data[seq(569+1,2*569),] <- CR1000X.Oxygen[, c( "Record.Number" , "S210_2_Smv_Med" , "S210_2_TC_Med" , "OXYBaseOxygen_Med")] ;

O2SensorCalibration.data[seq(2*569+1,3*569),] <- CR1000X.Oxygen[, c( "Record.Number" , "S210_3_Smv_Med" , "S210_3_TC_Med" , "OXYBaseOxygen_Med")] ;

O2SensorCalibration.data[seq(3*569+1,4*569),] <- CR1000X.Oxygen[, c( "Record.Number" , "S210_4_Smv_Med" , "S210_4_TC_Med" , "OXYBaseOxygen_Med")] ;

O2SensorCalibration.data[seq(4*569+1,5*569),] <- CR1000X.Oxygen[, c( "Record.Number" , "S210_5_Smv_Med" , "S210_5_TC_Med" , "OXYBaseOxygen_Med")] ;

O2SensorCalibration.data[seq(5*569+1,6*569),] <- CR1000X.Oxygen[, c( "Record.Number" , "S210_6_Smv_Med" , "S210_6_TC_Med" , "OXYBaseOxygen_Med")] ;

O2SensorCalibration.data[seq(6*569+1,7*569),] <- CR1000X.Oxygen[, c( "Record.Number" , "S210_7_Smv_Med" , "S210_7_TC_Med" , "OXYBaseOxygen_Med")] ;


str(O2SensorCalibration.data)

#### check the pulled data ###

plot(S210_1_Smv_Med ~ Record.Number , data = O2SensorCalibration.data)

plot(OXYBaseOxygen_Med ~ Record.Number , data = O2SensorCalibration.data)

plot(OXYBaseOxygen_Med ~ S210_1_Smv_Med , data = O2SensorCalibration.data)



#### discard points that are clearly out of range  ###


O2SensorCalibration.data$Distance <- O2SensorCalibration.data$OXYBaseOxygen_Med - O2SensorCalibration.data$S210_1_Smv_Med ;

plot(Distance~ Record.Number , data = O2SensorCalibration.data)

points(Distance~ Record.Number , data = O2SensorCalibration.data[O2SensorCalibration.data$Distance >=-0.5 & O2SensorCalibration.data$Distance <= 8.5, ], col = 4)


plot(OXYBaseOxygen_Med ~ S210_1_Smv_Med ,  data = O2SensorCalibration.data[O2SensorCalibration.data$Distance >=-0.5 & O2SensorCalibration.data$Distance <= 8.5, ], col = 4 )

### Do linear regression analysis on OXYBaseOx_kPa~S200Ox_kPa. 
### What do we need to do to S200Ox_kPa measurements to approach the "true" O2  concentration OXYBaseOx_kPa

Calibration.O2SensorCalibration<-lm(OXYBaseOxygen_Med ~ S210_1_Smv_Med, data = O2SensorCalibration.data[O2SensorCalibration.data$Distance >=-0.5 & O2SensorCalibration.data$Distance <= 8.5, ]) ;

summary(Calibration.O2SensorCalibration)

# Call:
#   lm(formula = OXYBaseOxygen_Med ~ S210_1_Smv_Med, data = O2SensorCalibration.data[O2SensorCalibration.data$Distance >= 
#                                                                                      -0.5 & O2SensorCalibration.data$Distance <= 8.5, ])
# 
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -6.9815 -0.2468 -0.0461  0.1578  6.0594 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)    -0.224683   0.021660  -10.37   <2e-16 ***
#   S210_1_Smv_Med  1.632383   0.002389  683.32   <2e-16 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.5518 on 3724 degrees of freedom
# Multiple R-squared:  0.9921,	Adjusted R-squared:  0.9921 
# F-statistic: 4.669e+05 on 1 and 3724 DF,  p-value: < 2.2e-16


coefficients(Calibration.O2SensorCalibration) ;

# (Intercept) S210_1_Smv_Med 
# -0.2246829      1.6323828 



abline(a=-0.2246829, b=1.6323828, col="RED", lwd=3) ;

#### Removing the points that are farthest away from the 1:1 line to improve the calibration 


head(O2SensorCalibration.data)


### Add the fitted values to the data frame

O2SensorCalibration.data$Fitted.1 <- -0.2246829 + (O2SensorCalibration.data$S210_1_Smv_Med*1.6323828)  ;

points(O2SensorCalibration.data$S210_1_Smv_Med,O2SensorCalibration.data$Fitted.1, col="RED") ;



### calculate the distance between the measurements and the fitted line


O2SensorCalibration.data$Distance.Fitted.1 <- abs(O2SensorCalibration.data$OXYBaseOxygen_Med - O2SensorCalibration.data$Fitted.1) ;

points(O2SensorCalibration.data$S210_1_Smv_Med,O2SensorCalibration.data$Distance.Fitted.1, col="GREEN") ;

### select the points that are within 2 KPa from the fitted line


summary(O2SensorCalibration.data[O2SensorCalibration.data$Distance.Fitted.1<=2,])


O2SensorCalibration.data[O2SensorCalibration.data$Distance.Fitted.1<=2,c("S210_1_Smv_Med", "Fitted.1" )]


points(OXYBaseOxygen_Med ~ S210_1_Smv_Med, data =  O2SensorCalibration.data[O2SensorCalibration.data$Distance.Fitted.1<=1,c("S210_1_Smv_Med", "OXYBaseOxygen_Med" , "Distance.Fitted.1")], col= "RED") ;

### Do linear regression analysis on OXYBaseOx_kPa~S200Ox_kPa with only the points that are closer to the 1:1 line. 

### This eliminate points that are take long to equillibrate between the two sensors, have measurement issues (bubbles), Outliers.

Calibration.O2SensorCalibration.1<-lm(OXYBaseOxygen_Med ~ S210_1_Smv_Med, data=O2SensorCalibration.data[O2SensorCalibration.data$Distance.Fitted.1<=1,c("S210_1_Smv_Med", "OXYBaseOxygen_Med" , "Distance.Fitted.1")]) ;

summary(Calibration.O2SensorCalibration.1)

# Call:
#   lm(formula = OXYBaseOxygen_Med ~ S210_1_Smv_Med, data = O2SensorCalibration.data[O2SensorCalibration.data$Distance.Fitted.1 <= 
#                                                                                      1, c("S210_1_Smv_Med", "OXYBaseOxygen_Med", "Distance.Fitted.1")])
# 
# Residuals:
#   Min       1Q   Median       3Q      Max 
# -0.96337 -0.25073 -0.00597  0.15220  0.97735 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)    -0.302291   0.012594     -24   <2e-16 ***
#   S210_1_Smv_Med  1.641138   0.001387    1183   <2e-16 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.3192 on 3663 degrees of freedom
# Multiple R-squared:  0.9974,	Adjusted R-squared:  0.9974 
# F-statistic: 1.399e+06 on 1 and 3663 DF,  p-value: < 2.2e-16


coefficients(Calibration.O2SensorCalibration.1) ;

# (Intercept) S210_1_Smv_Med 
# -0.3022907      1.6411377 


abline(a=-0.3022907, b=1.6411377, col=1, lwd=3) ;
                 
TC.Deg.C<-mean(Calibration.T[c(2,4,8)])

abline(h=TC.Deg.C, col="BLUE")









