##############################################################################################################
# 
# 
# Program to Calibrate Oxygen sensor data collected from Apogee O2 201 Sensors to data collected simultanously as  
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
library(openxlsx) ;


###############################################################################################################
#                           Explore the files and directory and files with the data Oxygen calibration files
###############################################################################################################

### working with the O2SensorCalibration.xlsx file

O2SensorCalibration.data<-read.xlsx(xlsxFile = ".\\O2SensorTesting\\Calibration\\O2SensorCalibration.xlsx", sheet= "CR1000_Oxygen_FM202301" , startRow = 1 , colNames = TRUE) ;

head(O2SensorCalibration.data)
tail(O2SensorCalibration.data)

### There is an error in the time stamp after 12:59 pm. It changes to 1:00 AM

O2SensorCalibration.data[O2SensorCalibration.data$Time >= 0.54 & O2SensorCalibration.data$Time <= 0.55,] ;

### The error starts after Time 0.5414931, row no 310

length(O2SensorCalibration.data$Time)

O2SensorCalibration.data$Time[310:length(O2SensorCalibration.data$Time) ]

O2SensorCalibration.data$Time[311:length(O2SensorCalibration.data$Time) ]

#### correcting the time stamp

O2SensorCalibration.data$CorrectedTime<-NA ;

O2SensorCalibration.data$CorrectedTime[1:310]<-O2SensorCalibration.data$Time[1:310];

O2SensorCalibration.data$CorrectedTime[311:length(O2SensorCalibration.data$Time)]<-O2SensorCalibration.data$Time[311:length(O2SensorCalibration.data$Time)]+0.55 ;


### working with the O2Sensor Experiments.xlsx file

O2Sensor_Experiments.data<-read.xlsx(xlsxFile = ".\\O2SensorTesting\\Calibration\\O2Sensor Experiments.xlsx", sheet= "Data_AnalysisFM_202301" , startRow = 1 , colNames = TRUE) ;

head(O2Sensor_Experiments.data)

tail(O2Sensor_Experiments.data)

###############################################################################################################
#                           Explore the data
###############################################################################################################

### O2SensorCalibration.xlsx data

plot(S200Ox_kPa~CorrectedTime, data=O2SensorCalibration.data, col="BLUE") ;
points(OXYBaseOx_kPa~CorrectedTime, data=O2SensorCalibration.data, col="RED") ;

plot(OXYBaseOx_kPa~S200Ox_kPa, data=O2SensorCalibration.data, col="BLUE") ;
#text(O2SensorCalibration.data$OXYBaseOx_kPa, O2SensorCalibration.data$S200Ox_kPa,labels=O2SensorCalibration.data$CorrectedTime.h) ;


### O2Sensor Experiments.xlsx data

plot(O2_S200 ~ RN, data=O2Sensor_Experiments.data, col="BLUE") ;
points(OXYBaseOxygen ~ RN, data=O2Sensor_Experiments.data, col="RED") ;

### Select only the data from March 1 2021 after 1:00 pm and before 2:40 pm

plot(O2_S200 ~ RN, data=O2Sensor_Experiments.data[O2Sensor_Experiments.data$Date == 44256 & O2Sensor_Experiments.data$RN >= 300 & O2Sensor_Experiments.data$RN <= 800,], col="ORANGE") ;
points(O2_S400 ~ RN, data=O2Sensor_Experiments.data[O2Sensor_Experiments.data$Date == 44256 & O2Sensor_Experiments.data$RN >= 300 & O2Sensor_Experiments.data$RN <= 800,], col="BLUE") ;
points(OXYBaseOxygen ~ RN, data=O2Sensor_Experiments.data[O2Sensor_Experiments.data$Date == 44256 & O2Sensor_Experiments.data$RN >= 300 & O2Sensor_Experiments.data$RN <= 800,], col="GREY") ;


plot(O2Sensor_Experiments.data[O2Sensor_Experiments.data$Date == 44256 & O2Sensor_Experiments.data$RN >= 300 & O2Sensor_Experiments.data$RN <= 800,c("OXYBaseOxygen", "OXYBaseOxygen")], col="GREY") ;
points(O2Sensor_Experiments.data[O2Sensor_Experiments.data$Date == 44256 & O2Sensor_Experiments.data$RN >= 300 & O2Sensor_Experiments.data$RN <= 800,c("OXYBaseOxygen", "O2_S400")], col="BLUE") ;
points(O2Sensor_Experiments.data[O2Sensor_Experiments.data$Date == 44256 & O2Sensor_Experiments.data$RN >= 300 & O2Sensor_Experiments.data$RN <= 800,c("OXYBaseOxygen","O2_S200" )], col="ORange") ;


O2Sensor_Experiments.data[O2Sensor_Experiments.data$Date == 44256 & O2Sensor_Experiments.data$RN >= 300 & O2Sensor_Experiments.data$RN <= 800,]

###############################################################################################################
#                          start the calibration process; OXYBaseOx_kPa~S200Ox_kPa
###############################################################################################################

### Do linear regression analysis on OXYBaseOx_kPa~S200Ox_kPa. 
### What do we need to do to S200Ox_kPa measurements to approach the "true" O2  concentration OXYBaseOx_kPa

Calibration.O2SensorCalibration<-lm(OXYBaseOx_kPa~S200Ox_kPa, data=O2SensorCalibration.data) ;

summary(Calibration.O2SensorCalibration)

# Call:
#   lm(formula = OXYBaseOx_kPa ~ S200Ox_kPa, data = O2SensorCalibration.data)
# 
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -7.1051 -0.3399 -0.1920  0.2735  5.6823 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 1.316421   0.073197   17.98   <2e-16 ***
#   S200Ox_kPa  0.899866   0.005375  167.41   <2e-16 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.8958 on 376 degrees of freedom
# Multiple R-squared:  0.9868,	Adjusted R-squared:  0.9867 
# F-statistic: 2.803e+04 on 1 and 376 DF,  p-value: < 2.2e-16

coefficients(Calibration.O2SensorCalibration) ;


# (Intercept)  S200Ox_kPa 
# 1.3164205   0.8998665 



abline(a=1.30346, b=0.8998665, col="RED", lwd=3) ;

#### Removing the points that are farthest away from the 1:1 line to improve the calibration 


head(O2SensorCalibration.data)

### Add the fitted values to the data frame

O2SensorCalibration.data$Fitted.1<-1.3164205 + (O2SensorCalibration.data$S200Ox_kPa*0.8998665)  ;

points(O2SensorCalibration.data$S200Ox_kPa,O2SensorCalibration.data$Fitted.1, col="BLUE", cex=3) ;

### calculate the distance between the measurements and the fitted line

O2SensorCalibration.data$Distance.Fitted.1<-abs(O2SensorCalibration.data$OXYBaseOx_kPa - O2SensorCalibration.data$Fitted.1) ;

points(O2SensorCalibration.data$S200Ox_kPa,O2SensorCalibration.data$Distance.Fitted.1, col="GREEN") ;

### select the points that are within 2 KPa fomr the fitted line

O2SensorCalibration.data[O2SensorCalibration.data$Distance.Fitted.1<=2,]

plot(OXYBaseOx_kPa~S200Ox_kPa, data=O2SensorCalibration.data, col="BLUE") ;

abline(a=1.30346, b=0.8998665, col="RED", lwd=3) ;

points(O2SensorCalibration.data[O2SensorCalibration.data$Distance.Fitted.1<=2,c("S200Ox_kPa", "Fitted.1" )], pch=3, col="GREEN", cex=2)

### Do linear regression analysis on OXYBaseOx_kPa~S200Ox_kPa with only the points that are closer to the 1:1 line. 
### This eliminate points that are take long to equillibrate between the two sensors, have measurement issues (bubbles), Outliers.

Calibration.O2SensorCalibration.1<-lm(OXYBaseOx_kPa~S200Ox_kPa, data=O2SensorCalibration.data[O2SensorCalibration.data$Distance.Fitted.1<=2,]) ;

summary(Calibration.O2SensorCalibration.1)

# Call:
#   lm(formula = OXYBaseOx_kPa ~ S200Ox_kPa, data = O2SensorCalibration.data[O2SensorCalibration.data$Distance.Fitted.1 <= 
#                                                                              2, ])
# 
# Residuals:
#   Min       1Q   Median       3Q      Max 
# -1.50333 -0.12941 -0.08941  0.16644  1.73414 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 1.047576   0.030636   34.19   <2e-16 ***
#   S200Ox_kPa  0.916677   0.002225  412.03   <2e-16 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.3631 on 363 degrees of freedom
# Multiple R-squared:  0.9979,	Adjusted R-squared:  0.9979 
# F-statistic: 1.698e+05 on 1 and 363 DF,  p-value: < 2.2e-16
# 

coefficients(Calibration.O2SensorCalibration) ;

# (Intercept)  S200Ox_kPa 
# 1.3164205   0.8998665



