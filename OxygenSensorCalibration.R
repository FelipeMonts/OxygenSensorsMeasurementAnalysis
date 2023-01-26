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



###############################################################################################################
#                           Explore the files and directory and files with the data from Felipe's Downloads
###############################################################################################################


