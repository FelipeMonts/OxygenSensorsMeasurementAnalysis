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


O2.Data.1<-read.csv(paste0("./OxygenSensorsData2022_2023\\",Files.Directories[[1]],"\\",CampbellSci.files[[2]] ), header=F, skip=4) ;


names(O2.Data.1)<-read.csv(paste0("./OxygenSensorsData2022_2023\\",Files.Directories[[1]],"\\",CampbellSci.files[[2]] ), header=F, skip=1,nrows=1) ;

head(O2.Data.1) 

 tail(O2.Data.1)

### correct the time stamp fo the date and format it into a POSIXct Time-Date 


O2.Data.1$TIME<-as.POSIXct(O2.Data.1$TIMESTAMP) ;
length(O2.Data.1$TIME)


### The first records have wrong the date 1999

O2.Data.1$Inverse.Record.No<-seq.int(from=(length(O2.Data.1$TIME)),to=1) ;

O2.Data.1$Corrected.TIME<-O2.Data.1$TIME[length(O2.Data.1$TIME)]-(O2.Data.1$Inverse.Record.No*30*60) ;

head(O2.Data.1) 

names(O2.Data.1)

#  Select temperature and Oxygen data according to the depth 5cm or 20 cm

grep("5cmTemp",names(O2.Data.1))

grep("5cmTemp",names(O2.Data.1))

grep("20cmTemp",names(O2.Data.1))

###############################################################################################################
#                           Reshape the data form wide to long from processing and calibration
###############################################################################################################
head(O2.Data.1) 

tail(O2.Data.1)

names(O2.Data.1)[3:16]


O2.Data.1.long<-reshape(data = O2.Data.1, idvar="Corrected.TIME", timevar="Measurement",varying = c(4:16), v.names=c("Value"), times=names(O2.Data.1)[4:16],  drop = c(1,2,3,17,18), new.row.names = NULL ,direction = "long" );




###############################################################################################################
#                          Get precipitation date to explore the oxygen sensor measurements
###############################################################################################################



# #### read precipitation data from https://wcc.sc.egov.usda.gov/nwcc/site?sitenum=2036
# 
# Precipitation<-read.csv("C:\\Users\\frm10\\Downloads\\2036_18_YEAR=2021.csv" , header= T, skip=3)
# 
# 
# str(Precipitation)
# 
# 
#   
# Precipitation$Date.Time<-as.POSIXct(paste0(Precipitation$Date," ", Precipitation$Time),format="%Y-%m-%d %H:%M");
# 
# Pcp.range<-range(Precipitation[which(Precipitation$Date.Time>=min(O2.Data.Alli.data$TIME) & Precipitation$Date.Time<=max(O2.Data.Alli.data$TIME)),c("PRCP.H.1..in.")])
# 
# 
# 
# DateTime.range<-as.Date(range(O2.Data.Alli.data$TIME)) ;
# 
# O2.range<-range(O2.Data.Alli.data$B1CloverA5cmO2_Med)

###############################################################################################################
#                          Use lab calibration curve to  update the oxygen data
###############################################################################################################

# The calibration of one of the S200 was done using simultaneous mesurements with an OxyBase O2 that is NIST traceable.
# 
# The R code used for the calibration is at:
# 
#   D:\Felipe\CCC Based Experiments\StrategicTillage_NitrogenLosses_OrganicCoverCrops\DataAnalysis\RCode\OxygenSensorsMeasurementAnalysis
#   and at github
# 
# 
#
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


###############################################################################################################
#                          Adjust oxygen measurement data based on the Lab Calibration
###############################################################################################################




###############################################################################################################
#                          Plot and Explore the data 
###############################################################################################################




plot(O2.Data.Alli.data$TIME,O2.Data.Alli.data$B1CloverC5cmO2_Med, col="RED" ) #, ylim=c(8,12) )


rasterImage(O2Picture3,xleft=as.POSIXct("2021-08-23 11:30:00 EDT"), ybottom=8.6, xright =as.POSIXct("2021-08-23 20:30:00 EDT") , ytop = 9.0)
plot(O2.Data.1$TIME,O2.Data.1$B1CloverC20cmO2_Med, col="BLUE");

min(O2.Data.Alli.data$TIME)

max(O2.Data.Alli.data$TIME)

plot(Precipitation[which(Precipitation$Date.Time>=min(O2.Data.Alli.data$TIME) & Precipitation$Date.Time<=max(O2.Data.Alli.data$TIME)),c("Date.Time")],Precipitation[which(Precipitation$Date.Time>=min(O2.Data.Alli.data$TIME) & Precipitation$Date.Time<=max(O2.Data.Alli.data$TIME)),c("PRCP.H.1..in.")])

plot(Precipitation$Date.Time, Precipitation$PRCP.H.1..in., xlim=c(as.POSIXct("2021-08-20 11:30:00 EDT"), as.POSIXct("2021-08-30 11:30:00 EDT")))

plot(O2.Data.1$TIME,O2.Data.1$B4TriticaleA5cmTemp_Med, col="BLUE" )
plot(O2.Data.1$TIME,O2.Data.1$B4TriticaleA20cmTemp_Med, col="RED" )



##### Create the graphics in EPS Postscript format ######

postscript(file="B1CloverC.eps" , onefile=F, width=8, height=4, paper= "letter", family='Times') ;


par(mar=c(3,5,1,4)+0.1);


# plot the pcp
plot(Precipitation[which(Precipitation$Date.Time>=min(O2.Data.Alli.data$TIME) & Precipitation$Date.Time<=max(O2.Data.Alli.data$TIME)),c("Date.Time")],Precipitation[which(Precipitation$Date.Time>=min(O2.Data.Alli.data$TIME) & Precipitation$Date.Time<=max(O2.Data.Alli.data$TIME)),c("PRCP.H.1..in.")], type="h",yaxt="n",xaxt="n", ylim=rev(c(0,4*Pcp.range[2])), bty="n", main="University Park Airport",col="light blue",ylab=NA,xlab=NA, lwd=3, font.main=2,cex.main=1.5);



# add axis with proper labeling

axis(side = 3, pos = 0, tck = 0,xaxt = "n") ;
axis(side = 4, at = pretty(seq(0, floor(Pcp.range[2] + 1),length=c(5))),labels=pretty(seq(0, floor(Pcp.range[2] + 1),length=c(5))), font=2, cex.axis=1.1) ;
mtext(side=4,"Precipitation in",line = 2, cex = 1.3, adj = 0.95, font=2) ;

#add O2 plot
par(new=T);

par(mar=c(5.1, 4.1, 4.1 ,2.1))

plot(O2.Data.Alli.data$TIME,O2.Data.Alli.data$B1CloverA5cmO2_Med, type='o',col="RED", yaxt='n', ylab="O2",xlab="Date", ylim = O2.range ,font.lab=2,cex.lab=1.3,cex.axis=1.1, bty="l");
points(O2.Data.Alli.data$TIME,O2.Data.Alli.data$B1CloverA20cmO2_Med, type='o',col="BLUE", yaxt='n', ylab="O2",xlab="Date", ylim = O2.range ,font.lab=2,cex.lab=1.3,cex.axis=1.1, bty="l");




#coordinates for the Temp max min polygon

#  View(University.Park.Temp.Pcp) ; str(University.Park.Temp.Pcp)  ; names(University.Park.Temp.Pcp)


#add axis with appropriate labels
axis.Date(side=1, at=Precipitation[which(Precipitation$Date.Time>=min(O2.Data.Alli.data$TIME) & Precipitation$Date.Time<=max(O2.Data.Alli.data$TIME)),c("Date.Time")],Precipitation[which(Precipitation$Date.Time>=min(O2.Data.Alli.data$TIME) & Precipitation$Date.Time<=max(O2.Data.Alli.data$TIME)),c("Date.Time")], font=2, cex.axis=1.2) 

axis.Date(side=1, at=seq(DateTime.range[1],DateTime.range[2],by='day'), font=2, cex.axis=1.2) 

#axis.POSIXct(side=1,University.Park.Temp.Pcp$Date.Year.Month, at=seq(DateTime.range[1],DateTime.range[2],length.out=5),labels=format(seq(DateTime.range[1],DateTime.range[2],length.out=5),"%Y")) ;
axis(side=2,at=pretty(seq(-25,40,length=15)), font=2, cex.axis=1.2) ;


invisible(dev.off())

### Prepare a detailed and well formatted data frame for data analysis and exploration

O2.Data.1$TIME<-as.POSIXct(O2.Data.1$TIMESTAMP) ;

O2.Data.1$BLOCK<-c("NONE") ;





