##############################################################################################################
# 
# 
# Program to Analyze and plot Oxygen sensor data collected from Apogee O2 201 Sensors  and CR1000 data loggers
# 
#  Installed in the CCC Strategic tillage experiment
#  
# 
# Felipe Montes 2021/08/26
# 
# Updated 01/16/2023
# 
# 
############################################################################################################### 

###############################################################################################################
#                       Campbell Scientific Data-logger Oxygen measurement program                       
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
#                             Setting up working directory  Loading Packages and Setting up working directory                        
###############################################################################################################


#      set the working directory

# readClipboard() Willow Rock Spring\\SkyCap_SelectionTrial\\DataCollection") ;
# #

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

### Read the Directories, files and data from the download directory where the Oxygen data is stored 

CampbellSci.files<-c("CR1000NEW_DataTableInfo.dat" , "CR1000NEW_Oxygen.dat" ,       "CR1000NEW_Public.dat"  ,      "CR1000NEW_Status.dat" ) ;


Files.Directories<-list.files("./OxygenSensorsData2022_2023");


O2.Data.1<-read.csv(paste0("./OxygenSensorsData2022_2023\\",Files.Directories[[5]],"\\",CampbellSci.files[[2]] ), header=F, skip=4) ;


names(O2.Data.1)<-read.csv(paste0("./OxygenSensorsData2022_2023\\",Files.Directories[[1]],"\\",CampbellSci.files[[2]] ), header=F, skip=1,nrows=1) ;

head(O2.Data.1) 

tail(O2.Data.1)

str(O2.Data.1)

### correct the time stamp fo the date and format it into a POSIXct Time-Date 



O2.Data.1$TIME<-as.POSIXct(O2.Data.1$TIMESTAMP) ;

length(O2.Data.1$TIME)


plot(O2.Data.1$TIME, col = "BLUE")

### The first records have wrong the date 1999

O2.Data.1$Inverse.Record.No<-seq.int(from=(length(O2.Data.1$TIME)),to=1) ;

O2.Data.1$Corrected.TIME<-O2.Data.1$TIME[length(O2.Data.1$TIME)]-(O2.Data.1$Inverse.Record.No*30*60) ;

head(O2.Data.1) 

names(O2.Data.1)

plot(O2.Data.1$TIME,O2.Data.1$Corrected.TIME, col= "RED")

# #  Select temperature and Oxygen data according to the depth 5cm or 20 cm
# 
# grep("5cmTemp",names(O2.Data.1))
# 
# grep("5cmTemp",names(O2.Data.1))
# 
# grep("20cmTemp",names(O2.Data.1))

plot(O2.Data.1$Corrected.TIME,O2.Data.1$BattV_Min)

plot(O2.Data.1$Corrected.TIME,O2.Data.1$BattV_Min, xlim=c(as.POSIXct("2022-12-17 17:30:00"), as.POSIXct("2022-12-20 17:30:00")))

plot(O2.Data.1$Corrected.TIME, O2.Data.1$PanelT)

plot(O2.Data.1$Corrected.TIME,O2.Data.1$PanelT, xlim=c(as.POSIXct("2022-12-17 17:30:00"), as.POSIXct("2022-12-29 17:30:00"))) ;


###############################################################################################################
#                           Processing the temperature data
###############################################################################################################


###### Treatment A #######

Temperature.Data.A5<-O2.Data.1[,c(grep("A5cmTemp",names(O2.Data.1)),which(names(O2.Data.1)== "Corrected.TIME" ))]  ;

Temperature.Data.A5$Depth_cm<-5 ;

Temperature.Data.A5$Treatment<-"A" ;

names(Temperature.Data.A5)[[1]]<-"Temperature_C"

str(Temperature.Data.A5)



Temperature.Data.A20<-O2.Data.1[,c(grep("A20cmTemp",names(O2.Data.1)),which(names(O2.Data.1)== "Corrected.TIME" ))]  ;

str(Temperature.Data.A20)


Temperature.Data.A20$Depth_cm<-20 ;

Temperature.Data.A20$Treatment<-"A" ;

names(Temperature.Data.A20)[[1]]<-"Temperature_C" ;

str(Temperature.Data.A20)

Temperature.Data.A<-rbind(Temperature.Data.A5,Temperature.Data.A20) ;

str(Temperature.Data.A)

###### Treatment B #######

Temperature.Data.B5<-O2.Data.1[,c(grep("B5cmTemp",names(O2.Data.1)),which(names(O2.Data.1)== "Corrected.TIME" ))]  ;

str(Temperature.Data.B5)

Temperature.Data.B5$Depth_cm<-5 ;

Temperature.Data.B5$Treatment<-"B" ;

names(Temperature.Data.B5)[[1]]<-"Temperature_C" ;

str(Temperature.Data.B5)


Temperature.Data.B20<-O2.Data.1[,c(grep("B20cmTemp",names(O2.Data.1)),which(names(O2.Data.1)== "Corrected.TIME" ))]  ;

str(Temperature.Data.B20)


Temperature.Data.B20$Depth_cm<-5 ;

Temperature.Data.B20$Treatment<-"B" ;

names(Temperature.Data.B20)[[1]]<-"Temperature_C" ;

str(Temperature.Data.B20)


Temperature.Data.B<-rbind(Temperature.Data.B5,Temperature.Data.B20) ;

str(Temperature.Data.B)


###### Treatment C #######

Temperature.Data.C5<-O2.Data.1[,c(grep("C5cmTemp",names(O2.Data.1)),which(names(O2.Data.1)== "Corrected.TIME" ))]  ;

str(Temperature.Data.C5)

Temperature.Data.C5$Depth_cm<-5 ;

Temperature.Data.C5$Treatment<-"C" ;

names(Temperature.Data.C5)[[1]]<-"Temperature_C" ;

str(Temperature.Data.C5)



Temperature.Data.C20<-O2.Data.1[,c(grep("C20cmTemp",names(O2.Data.1)),which(names(O2.Data.1)== "Corrected.TIME" ))]  ;

str(Temperature.Data.C20)

Temperature.Data.C20$Depth_cm<-5 ;

Temperature.Data.C20$Treatment<-"C" ;

names(Temperature.Data.C20)[[1]]<-"Temperature_C" ;

str(Temperature.Data.C20)


Temperature.Data.C<-rbind(Temperature.Data.C5,Temperature.Data.C20) ;

str(Temperature.Data.C)



###### Panel #######

Temperature.Data.Panel<-O2.Data.1[,c(grep("PanelT",names(O2.Data.1)),which(names(O2.Data.1)== "Corrected.TIME" ))]  ;

str(Temperature.Data.Panel)

Temperature.Data.Panel$Depth_cm<--100 ;

Temperature.Data.Panel$Treatment<-"Panel" ;

names(Temperature.Data.Panel)[[1]]<-"Temperature_C" ;

str(Temperature.Data.Panel)


##### combining all #### 


Temperature.Data<-rbind(Temperature.Data.A5 , Temperature.Data.A20 , Temperature.Data.B5 , Temperature.Data.B20 ,
                          Temperature.Data.C5 , Temperature.Data.C20 , Temperature.Data.Panel) ;

str(Temperature.Data);

Temperature.Data$FAC.Depth_cm<-as.factor(Temperature.Data$Depth_cm) ;

Temperature.Data$FAC.Treatment<-as.factor(Temperature.Data$Treatment) ;

str(Temperature.Data);




###############################################################################################################
#                           Reshape the data form wide to long from processing and calibration
###############################################################################################################
head(O2.Data.1) 

tail(O2.Data.1)

names(O2.Data.1)

str(O2.Data.1)

O2.Data.1.O2_Kpa<-reshape(data = O2.Data.1, idvar="Corrected.TIME", timevar="Measurement",
                        varying = names(O2.Data.1)[c(9,11,13,15)], v.names=c("Value"), 
                        times=names(O2.Data.1)[c(9,11,13,15)],  drop = c(1,2,3,4,5,6,7,8,10,12,14,16,17,18), 
                        new.row.names = NULL ,direction = "long" );

str(O2.Data.1.O2_Kpa)

# #  Select temperature and Oxygen data according to the depth 5cm or 20 cm
# 
# grep("5cmTemp",names(O2.Data.1))
# 
# grep("5cmTemp",names(O2.Data.1))
# 
# grep("20cmTemp",names(O2.Data.1))


O2.Data.1.Temp_C<-reshape(data = O2.Data.1, idvar="Corrected.TIME", timevar="Measurement",
                        varying = names(O2.Data.1)[c(10,12,14,16)], v.names=c("Value"), 
                        times=names(O2.Data.1)[c(10,12,14,16)],  drop = c(1,2,3,4,5,6,7,8,9,11,13,15,17,18), 
                        new.row.names = NULL ,direction = "long" );

str(O2.Data.1.Temp_C)

head(O2.Data.1.Temp_C)



###############################################################################################################
# #                         Calibration with temperature
# 
#   Based on the S0-100_200 manual page 14
# 
#   https://www.apogeeinstruments.com/content/SO-100-200-manual.pdf 
# #
#     O2 = O2M +C3*(Ts^3) + C2*(Ts^2) + C1*Ts + C0
# 
#     C0=-(C3*(Tc^3) + C2*(TC^2) + C1*TC)
#     
#     where Ts = measured sensor temperature [C]
#           C0 = C0 is the offset coefficient calculated from measured temperature at calibration (TC) [C]
#           C3 = -4.333e-6 
#           C2 = 1.896e-3
#           C1 = -3.610e-2
#           
#     TC = 21 °C (obtained from the calibration data)      
#           
#           
# 
###############################################################################################################

head(O2.Data.1.O2_Kpa)

head(O2.Data.1.Temp_C)

O2.Data.2<-merge(O2.Data.1.Temp_C,O2.Data.1.O2_Kpa, by="Corrected.TIME") ;

str(O2.Data.2)

names(O2.Data.2)<-c("Corrected.TIME" , "Temperature" ,"Deg.C" , "Oxygen" , "Kpa") ;

tail(O2.Data.2)


#coorection Factors

 C3 = -4.333e-6
 C2 = 1.896e-3
 C1 = -3.610e-2
 TC = 21 
 C0 = -((C3 * (TC^3)) + (C2 * (TC^2)) +(C1 * TC))  


 
O2.Data.2$Temp.Corected.O2_Kpa<-O2.Data.2$Kpa + (C3 * (O2.Data.2$Deg.C^3 )) + (C2 * (O2.Data.2$Deg.C^2 )) + (C1 * O2.Data.2$Deg.C) + C0 ;

###############################################################################################################
#                         Calibration of the data based on the calibration equation obtained from  
#                         simultaneous measurements with the NIST traceable OXYBaseOx_kPa~S200Ox_kPa
#                          and temperature
###############################################################################################################


# #  The results of the calibration process are as follows
# 
# summary(Calibration.O2SensorCalibration.1)
# 
# 
# Call:
# 
# lm(formula = OXYBaseOx_kPa ~ S200Ox_kPa, 
#  data = O2SensorCalibration.data[O2SensorCalibration.data$Distance.Fitted.1 <= 2, ])
#                                                                         
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
# (Intercept)  S200Ox_kPa 
#1.0475757   0.9166775 



O2.Data.2$Calibrated.O2_Kpa<-(O2.Data.2$Temp.Corected.O2_Kpa * 0.9166775) + 1.0475757 ;

plot(O2.Data.2$Corrected.TIME, O2.Data.2$Kpa, col="Blue") ;
points(O2.Data.2$Corrected.TIME, O2.Data.2$Calibrated.O2_Kpa, col="RED");

plot(O2.Data.2$Kpa,O2.Data.2$Calibrated.O2_Kpa, col="RED" )
abline(b=1,a=0, col="Blue")


plot(O2.Data.2$Corrected.TIME,O2.Data.2$Deg.C, col="MAGENTA" )

names(O2.Data.2)

# ### Add the panel temperature to the data
# 
# head(O2.Data.1.Temp_C) 
# 
# O2.Data.1.Temp_C[O2.Data.1.Temp_C$Measurement == "PanelT",]
# 
# 
# plot(O2.Data.1.Temp_C[O2.Data.1.Temp_C$Measurement == "PanelT",c("Corrected.TIME", "Value")])
# 
# str(O2.Data.1.Temp_C)
# 
# O2.Data.2$PanelT<-O2.Data.1.Temp_C[O2.Data.1.Temp_C$Measurement == "PanelT", c("Value")] ;
# 
# str(O2.Data.2$PanelT)
# 
# head(O2.Data.2)
# 
# plot(O2.Data.2$Corrected.TIME, O2.Data.2$PanelT, col="BLUE" )


### Get ready the panel temperature PanelT for plotting
names(O2.Data.1)

str(O2.Data.1)

Panel.T<-O2.Data.1[,c("Corrected.TIME", "PanelT")]

str(Panel.T)

plot(Panel.T[,c("Corrected.TIME", "PanelT")], col="GREEN") ;

str(O2.Data.2[O2.Data.2$Temperature == "B3TriticaleB5cmTemp_Med",c("Corrected.TIME","Deg.C")])

plot(Panel.T$PanelT,  O2.Data.2[O2.Data.2$Temperature == "B3TriticaleB5cmTemp_Med",c("Deg.C")] , col="BLUE") ;

str

####### There are a few measurements that exceed 20 Kpa

plot(O2.Data.2[O2.Data.2$Calibrated.O2_Kpa >=25 ,c("Deg.C", "Calibrated.O2_Kpa")])

plot(O2.Data.2[O2.Data.2$Calibrated.O2_Kpa <=22 ,c("Deg.C", "Calibrated.O2_Kpa")])

plot(O2.Data.2[O2.Data.2$Temp.Corected.O2_Kpa >=25 ,c("Deg.C", "Calibrated.O2_Kpa")])

plot(O2.Data.2[O2.Data.2$Temp.Corected.O2_Kpa <=22 ,c("Deg.C", "Calibrated.O2_Kpa")])

plot(O2.Data.2[O2.Data.2$Kpa >=25 ,c("Deg.C", "Calibrated.O2_Kpa")])

plot(O2.Data.2[O2.Data.2$Kpa <=22 ,c("Deg.C", "Calibrated.O2_Kpa")])

# remove the data points that have O2 measurements above 21 kpa


O2.calibrated.Data<-O2.Data.2[O2.Data.2$Kpa <= 25  &  O2.Data.2$Deg.C >= -20,] ;


names(O2.calibrated.Data)

head(O2.calibrated.Data)


max(O2.calibrated.Data$Kpa, na.rm=T)

O2.calibrated.Data$Percent.O2<-(O2.calibrated.Data$Calibrated.O2_Kpa/21)*100 ;

plot(O2.calibrated.Data$Deg.C,O2.calibrated.Data$Percent.O2)

plot(O2.calibrated.Data$PanelT,O2.calibrated.Data$Percent.O2)

plot(O2.calibrated.Data[O2.calibrated.Data$PanelT >= 50,c("PanelT")],O2.calibrated.Data[O2.calibrated.Data$PanelT >= 50,c("Percent.O2")])


##@# There are some measurements with panel Temperature above 100 °C

O2.calibrated.Data[O2.calibrated.Data$PanelT >= 50,]

max(O2.calibrated.Data$PanelT,na.rm=T) 

O2.calibrated.Data[O2.calibrated.Data$PanelT == 105.8171,]

#### it seems that at PanelT == 105.8171 there is a maximum that signals an error


plot(O2.calibrated.Data$Corrected.TIME,O2.calibrated.Data$PanelT)  ;

O2.calibrated.Data[O2.calibrated.Data$PanelT == 105.8171 & !is.na(O2.calibrated.Data$PanelT),]    ;

diff(O2.calibrated.Data[O2.calibrated.Data$PanelT == 105.8171 & !is.na(O2.calibrated.Data$PanelT),c("PanelT")],lag=1)   ;

as.numeric(row.names(O2.calibrated.Data))  ;

diff(as.numeric(row.names(O2.calibrated.Data[O2.calibrated.Data$PanelT == 105.8171 & !is.na(O2.calibrated.Data$PanelT),]))) ;

#### the error occurs every 5059 records. It seems that at 5059 records the memory capacity is reached and there is a signal
#### that sets the PanelT to 105.8171 and adds to NA rows. Remove these records

Remove.NA<-which(is.na(O2.calibrated.Data$Corrected.TIME)) ;

Remove.MemCap<-which(O2.calibrated.Data$PanelT == 105.8171) ;

O2.Clean.Data<-O2.calibrated.Data[!O2.calibrated.Data %in% Remove.NA | !O2.calibrated.Data %in% Remove.MemCap]


plot(O2.Clean.Data$Corrected.TIME,O2.Clean.Data$Kpa, col = "BLUE") ;

plot(O2.Clean.Data$Corrected.TIME,O2.Clean.Data$Percent.O2, col = "GREEN") ;

plot(O2.Clean.Data$Corrected.TIME,O2.Clean.Data$PanelT , col = "RED" ) ;

plot(O2.Clean.Data$Corrected.TIME,O2.Clean.Data$Deg.C, col = "MAGENTA")


