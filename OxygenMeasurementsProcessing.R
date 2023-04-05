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


#######   set the working directory

# readClipboard() Willow Rock Spring\\SkyCap_SelectionTrial\\DataCollection") ;
# #

setwd("C:\\Users\\frm10\\OneDrive - The Pennsylvania State University\\O2Sensors") ;


######  store the default graphics parameters 

def.par<-par()

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

#CampbellSci.files<-c("CR1000NEW_DataTableInfo.dat" , "CR1000NEW_Oxygen.dat" ,       "CR1000NEW_Public.dat"  ,      "CR1000NEW_Status.dat" ) ;


Main.Directorys<-c("./OxygenSensorsData2021" , "./OxygenSensorsData2022_2023" ) ;

Main.Directorys

MD=2


Main.Directorys[MD]

#Files.Directories<-list.files("./OxygenSensorsData2022_2023");

Files.Directories<-list.files(Main.Directorys[MD]);

Files.Directories

File.to.Download = 3

Files.Directories[[File.to.Download]]



Download.Treatments<-list.files(paste0(Main.Directorys[MD],"\\",Files.Directories[[File.to.Download]])) ;

Download.Treatments

File.Download.Treatment = 5


Download.Treatments[[File.Download.Treatment]]


##### Get the names of the files with the data in the directory ###

Download.Data.files<-list.files(paste0(Main.Directorys[MD], "\\",
                                       Files.Directories[[File.to.Download]] , "\\" ,Download.Treatments[[File.Download.Treatment]] ))

Download.Data.files

grep(pattern = "Oxygen" , Download.Data.files)

Download.Oxygen.file<-Download.Data.files[grep(pattern = "Oxygen" , Download.Data.files)] ;

Download.Oxygen.file


###### Get the Block and the Cover crop type from the file name ####

if (grepl(x = Download.Treatments[[File.Download.Treatment]], pattern = "pp" )) C_Crop.Type <- "3Spp" else
  
  C_Crop.Type<-strsplit(x = Download.Treatments[[File.Download.Treatment]], split = "[[:digit:]]" ) [[1]] [2] ;  
  

grepl(x = Download.Treatments[[File.Download.Treatment]], pattern = "pp" )


strsplit(x = Download.Treatments[[File.Download.Treatment]], split = "[[:digit:]]" ) [[1]] [2]


C_Crop.Type


regexpr(pattern = "[[:digit:]]" , text = Download.Treatments[[File.Download.Treatment]] )


Block.No<-substr(x = Download.Treatments[[File.Download.Treatment]], start = regexpr(pattern = "[[:digit:]]" , text = Download.Treatments[[File.Download.Treatment]] ),
                 stop = regexpr(pattern = "[[:digit:]]" , text = Download.Treatments[[File.Download.Treatment]] ) ) ;

Block.No



### Read the data from where the Oxygen data is stored ###



O2.Data.1<-read.csv(paste0(Main.Directorys[MD], "\\",Files.Directories[[File.to.Download]],
                           "\\", Download.Treatments[[File.Download.Treatment]], "\\" , Download.Oxygen.file ), header=F, skip=4, na.strings = "NAN") ;


names(O2.Data.1)<-read.csv(paste0(Main.Directorys[MD], "\\",Files.Directories[[File.to.Download]],
                                  "\\", Download.Treatments[[File.Download.Treatment]], "\\" , Download.Oxygen.file ), header=F, skip=1,nrows=1) ;

head(O2.Data.1) 

tail(O2.Data.1)

str(O2.Data.1)

### correct the time stamp fo the date and format it into a POSIXct Time-Date 



O2.Data.1$TIME<-as.POSIXct(O2.Data.1$TIMESTAMP) ;

length(O2.Data.1$TIME)


plot(O2.Data.1$TIME, col = "BLUE", main = Files.Directories[[File.to.Download]] )

### The first records have wrong the date 1999

O2.Data.1$Inverse.Record.No<-seq.int(from=(length(O2.Data.1$TIME)),to=1) ;

O2.Data.1$Corrected.TIME<-O2.Data.1$TIME[length(O2.Data.1$TIME)]-(O2.Data.1$Inverse.Record.No*30*60) ;

head(O2.Data.1) 

names(O2.Data.1)

plot(O2.Data.1$TIME,O2.Data.1$Corrected.TIME, col= "RED" , main = Files.Directories[[File.to.Download]])

# #  Select temperature and Oxygen data according to the depth 5cm or 20 cm
# 
# grep("5cmTemp",names(O2.Data.1))
# 
# grep("5cmTemp",names(O2.Data.1))
# 
# grep("20cmTemp",names(O2.Data.1))




###############################################################################################################
#   Plot the battery and the panel temperature to explore equipment malfunction
###############################################################################################################

pdf( file = paste0(Main.Directorys[MD], "\\",Files.Directories[[File.to.Download]] , "\\ProcessedData\\",

                   Files.Directories[[File.to.Download]], Block.No, C_Crop.Type, as.character.Date(Sys.Date(),format = "%Y_%m_%d") ,".pdf" ),

     paper = "USr", width = 10, height = 8 , onefile = T)  ;



par(mfrow = c(2,1), mar = c(2, 4, 4 , 4) + 0.1 , mgp = c(2, .6, 0))

### Temperature Plot  ###


plot(BattV_Min~Corrected.TIME, data = O2.Data.1 ,  type = "l" , lwd = 4 ,col="MAGENTA", 
     
     xlab = NA, ylab = "BattV_Min" ,tck = 1,  cex.axis = 1.5 ,    cex.lab = 1.5 , 
     
     main = Download.Treatments[[File.Download.Treatment]] , format = "%Y-%m-%d" ) ;


### forming the legend ##

legend.1<-c("BattV_Mi", "PanelT_C" )

legend.2<-c("solid" , "solid" ) 

legend.4<-c("MAGENTA", "RED" )

legend.5<-c( 3, 3)

# legend(x = "bottomleft" , legend = legend.1, lty = legend.2,  pch = legend.3 , col = legend.4, 
#        pt.cex= 2.0 , lwd = legend.5, bty = "n", horiz = T, ncol = 2)

legend(x = "topleft" , legend = legend.1, lty = legend.2, col = legend.4, 
       pt.cex= 2.0 , lwd = legend.5, bty = "n", cex =1.2)



par(mar = c(5, 4, 1 , 4) + 0.1) 


plot(PanelT~Corrected.TIME,  data = O2.Data.1 ,  bty = "o", xlab="Date" , ylab ="PanelT_C" , 
     
     col="RED", type = "l", lwd = 4,  tck = 1 ,cex.axis = 1.5 , cex.lab = 1.5  ,format = "%Y-%m-%d" ) ;



# dev.off()



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


Temperature.Data.B20$Depth_cm<-20 ;

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

Temperature.Data.C20$Depth_cm<-20 ;

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
#                           Processing Oxygen Data
###############################################################################################################

str(O2.Data.1)

###### Treatment A #######

Oxygen.Data.A5<-O2.Data.1[,c(grep("A5cmO2",names(O2.Data.1)),which(names(O2.Data.1)== "Corrected.TIME" ))]  ;

Oxygen.Data.A5$Depth_cm<-5 ;

Oxygen.Data.A5$Treatment<-"A" ;

names(Oxygen.Data.A5)[[1]]<-"Oxygen_Kpa"

str(Oxygen.Data.A5)



Oxygen.Data.A20<-O2.Data.1[,c(grep("A20cmO2",names(O2.Data.1)),which(names(O2.Data.1)== "Corrected.TIME" ))]  ;

str(Oxygen.Data.A20)


Oxygen.Data.A20$Depth_cm<-20 ;

Oxygen.Data.A20$Treatment<-"A" ;

names(Oxygen.Data.A20)[[1]]<-"Oxygen_Kpa" ;

str(Oxygen.Data.A20)

Oxygen.Data.A<-rbind(Oxygen.Data.A5,Oxygen.Data.A20) ;

str(Oxygen.Data.A)


###### Treatment B #######

Oxygen.Data.B5<-O2.Data.1[,c(grep("B5cmO2",names(O2.Data.1)),which(names(O2.Data.1)== "Corrected.TIME" ))]  ;

Oxygen.Data.B5$Depth_cm<-5 ;

Oxygen.Data.B5$Treatment<-"B" ;

names(Oxygen.Data.B5)[[1]]<-"Oxygen_Kpa"

str(Oxygen.Data.B5)



Oxygen.Data.B20<-O2.Data.1[,c(grep("B20cmO2",names(O2.Data.1)),which(names(O2.Data.1)== "Corrected.TIME" ))]  ;

str(Oxygen.Data.B20)


Oxygen.Data.B20$Depth_cm<-20 ;

Oxygen.Data.B20$Treatment<-"B" ;

names(Oxygen.Data.B20)[[1]]<-"Oxygen_Kpa" ;

str(Oxygen.Data.B20)

Oxygen.Data.B<-rbind(Oxygen.Data.B5,Oxygen.Data.B20) ;

str(Oxygen.Data.B)


###### Treatment C #######

Oxygen.Data.C5<-O2.Data.1[,c(grep("C5cmO2",names(O2.Data.1)),which(names(O2.Data.1)== "Corrected.TIME" ))]  ;

Oxygen.Data.C5$Depth_cm<-5 ;

Oxygen.Data.C5$Treatment<-"C" ;

names(Oxygen.Data.C5)[[1]]<-"Oxygen_Kpa"

str(Oxygen.Data.C5)



Oxygen.Data.C20<-O2.Data.1[,c(grep("C20cmO2",names(O2.Data.1)),which(names(O2.Data.1)== "Corrected.TIME" ))]  ;

str(Oxygen.Data.C20)


Oxygen.Data.C20$Depth_cm<-20 ;

Oxygen.Data.C20$Treatment<-"C" ;

names(Oxygen.Data.C20)[[1]]<-"Oxygen_Kpa" ;

str(Oxygen.Data.C20)

Oxygen.Data.C<-rbind(Oxygen.Data.C5,Oxygen.Data.C20) ;

str(Oxygen.Data.C)



##### combining all #### 


Oxygen.Data<-rbind(Oxygen.Data.A5 , Oxygen.Data.A20 , Oxygen.Data.B5 , Oxygen.Data.B20 ,
                   Oxygen.Data.C5 , Oxygen.Data.C20) ;

str(Oxygen.Data);

Oxygen.Data$FAC.Depth_cm<-as.factor(Oxygen.Data$Depth_cm) ;

Oxygen.Data$FAC.Treatment<-as.factor(Oxygen.Data$Treatment) ;

str(Oxygen.Data);


###############################################################################################################
#                  Merging Oxygen Data and Temperature Data
###############################################################################################################


str(Oxygen.Data);

str(Temperature.Data);  ### temperature data has the panel temperature records as well.

str(Temperature.Data[Temperature.Data$FAC.Treatment != "Panel" ,])


Data.Oxygen.Temperature.1<-merge(Oxygen.Data, Temperature.Data[Temperature.Data$FAC.Treatment != "Panel" ,]) ;

head(Data.Oxygen.Temperature.1)

head(O2.Data.1)

str(Data.Oxygen.Temperature.1)


Temperature.Data.Panel.2<-Temperature.Data[Temperature.Data$FAC.Treatment == "Panel" ,] ;

Temperature.Data.Panel.2$Oxygen_Kpa<-NA ;

head(Temperature.Data.Panel.2)

str(Temperature.Data.Panel.2)

Data.Oxygen.Temperature<-rbind(Data.Oxygen.Temperature.1,Temperature.Data.Panel.2 )

head(Data.Oxygen.Temperature)

tail(Data.Oxygen.Temperature)

str(Data.Oxygen.Temperature)

levels(Data.Oxygen.Temperature$FAC.Treatment)

# Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="Panel", ]

#### Adding the block  (Block.No) and cover crop  (C_Crop.Type) factors

Data.Oxygen.Temperature$Block<-as.factor(Block.No) ;

Data.Oxygen.Temperature$C_Crop<-as.factor(C_Crop.Type) ;

str(Data.Oxygen.Temperature)

###############################################################################################################
#                  Plotting to visualize the data
###############################################################################################################


####  Treatment B #####

par(mfrow = c(2,1), mar = c(2, 4, 4 , 4) + 0.1 , mgp = c(2, .6, 0))

### Temperature Plot  ###

str(Data.Oxygen.Temperature)

summary(Data.Oxygen.Temperature)

range(Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="B" | Data.Oxygen.Temperature$FAC.Treatment =="Panel" , c("Temperature_C")], na.rm = T) 


plot(Temperature_C~Corrected.TIME, data = Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="Panel",],
     
     ylim = range(Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="B" | Data.Oxygen.Temperature$FAC.Treatment =="Panel" , c("Temperature_C")], na.rm = T) ,
     
     type = "l" , lwd = 4 , col="MAGENTA",  xlab = NA, ylab = "Temperature °C" ,  tck = 1,  cex.axis = 1.5 , 
     
     cex.lab = 1.5 ,  main = paste("B" , Block.No , C_Crop.Type , "Treatment B" ) , format = "%Y-%m-%d" ) ;

points(Temperature_C~Corrected.TIME, col="RED" , type = "l", lwd = 4 ,
       
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="B" &  Data.Oxygen.Temperature$FAC.Depth_cm =="5",] ) ;

points(Temperature_C~Corrected.TIME, col="BLUE" , type = "l", lwd = 4,
       
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="B" &  Data.Oxygen.Temperature$FAC.Depth_cm =="20",] ) ;

### forming the legend ##

legend.1<-c("PanelT_C" , "5 cm"  , "20 cm")

legend.2<-c("solid" , "solid", "solid" ) 

legend.4<-c("MAGENTA", "RED" , "BLUE")

legend.5<-c( 3, 3 , 3)

# legend(x = "bottomleft" , legend = legend.1, lty = legend.2,  pch = legend.3 , col = legend.4, 
#        pt.cex= 2.0 , lwd = legend.5, bty = "n", horiz = T, ncol = 2)

legend(x = "topleft" , legend = legend.1, lty = legend.2, col = legend.4, 
       pt.cex= 2.0 , lwd = legend.5, bty = "n", cex =1.2)





### O2  PLot   ###


range(Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="B" , c("Oxygen_Kpa")], na.rm = T)


par(mar = c(5, 4, 1 , 4) + 0.1) 



plot(Oxygen_Kpa~Corrected.TIME, bty = "o", xlab="Date" , ylab ="Oxygen Kpa" ,  col="RED", type = "l", lwd = 4,
     
     tck = 1 ,cex.axis = 1.5 , cex.lab = 1.5  , format = "%Y-%m-%d" , 
     
     ylim = range(Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="B" , c("Oxygen_Kpa")], na.rm = T) ,
     
     data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="B" &  Data.Oxygen.Temperature$FAC.Depth_cm =="5",] ) ;

points(Oxygen_Kpa~Corrected.TIME, col="BLUE", type = "l", lwd = 4,
       
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="B" &  Data.Oxygen.Temperature$FAC.Depth_cm =="20",] ) ;



# dev.off() 

####  Treatment C  #####


par(mfrow = c(2,1), mar = c(2, 4, 4 , 4) + 0.1 , mgp = c(2, .6, 0))

### Temperature Plot  ###

range(Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="C" | Data.Oxygen.Temperature$FAC.Treatment =="Panel" , c("Temperature_C")], na.rm = T)



plot(Temperature_C~Corrected.TIME, data = Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="Panel",],
     
    ylim =range(Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="C" | Data.Oxygen.Temperature$FAC.Treatment =="Panel" , c("Temperature_C")], na.rm = T),
     
     type = "l" , lwd = 4 , col="MAGENTA",  xlab = NA, ylab = "Temperature °C" ,  tck = 1,  cex.axis = 1.5 , 
     
     cex.lab = 1.5 ,  main = paste("B" , Block.No , C_Crop.Type , "Treatment C" ) , format = "%Y-%m-%d" ) ;


points(Temperature_C~Corrected.TIME, col="RED" , type = "l", lwd = 4 ,
       
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="C" &  Data.Oxygen.Temperature$FAC.Depth_cm =="5",]) ;

points(Temperature_C~Corrected.TIME, col="BLUE" , type = "l", lwd = 4,
       
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="C" &  Data.Oxygen.Temperature$FAC.Depth_cm =="20",] ) ;

### forming the legend ##

legend.1<-c("PanelT_C" , "5 cm"  , "20 cm")

legend.2<-c("solid" , "solid", "solid" ) 

legend.4<-c("MAGENTA", "RED" , "BLUE")

legend.5<-c( 3, 3 , 3)

# legend(x = "bottomleft" , legend = legend.1, lty = legend.2,  pch = legend.3 , col = legend.4, 
#        pt.cex= 2.0 , lwd = legend.5, bty = "n", horiz = T, ncol = 2)

legend(x = "topleft" , legend = legend.1, lty = legend.2, col = legend.4, 
       pt.cex= 2.0 , lwd = legend.5, bty = "n", cex =1.2)



### O2  PLot   ###


par(mar = c(5, 4, 1 , 4) + 0.1) 

range(Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="C", c("Oxygen_Kpa")], na.rm = T)


plot(Oxygen_Kpa~Corrected.TIME, bty = "o", xlab="Date" , ylab ="Oxygen Kpa" ,  col="RED", type = "l", lwd = 4,
     
     ylim = range(Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="C", c("Oxygen_Kpa")], na.rm = T),
     
     tck = 1 ,cex.axis = 1.5 , cex.lab = 1.5  , format = "%Y-%m-%d" ,
     
     data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="C" &  Data.Oxygen.Temperature$FAC.Depth_cm =="5",] ) ;

points(Oxygen_Kpa~Corrected.TIME, col="BLUE", type = "l", lwd = 4,
       
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="C" &  Data.Oxygen.Temperature$FAC.Depth_cm =="20",] ) ;





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

str(Data.Oxygen.Temperature)



str(Data.Oxygen.Temperature[Data.Oxygen.Temperature$Treatment != "Panel",])



#correction Factors

 C3 = -4.333e-6
 C2 = 1.896e-3
 C1 = -3.610e-2
 TC = 21 
 C0 = -((C3 * (TC^3)) + (C2 * (TC^2)) +(C1 * TC))  


 
Data.Oxygen.Temperature$Temp.Corrected.O2_Kpa<-Data.Oxygen.Temperature$Oxygen_Kpa + 
   (C3 * (Data.Oxygen.Temperature$Temperature_C^3 )) + (C2 * (Data.Oxygen.Temperature$Temperature_C^2 )) +
   (C1 * Data.Oxygen.Temperature$Temperature_C) + C0  ;


####  Checking Treatment B  #####

str(Data.Oxygen.Temperature)


range(Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment == "B" , c("Oxygen_Kpa" , "Temp.Corrected.O2_Kpa" )], na.rm = T)

plot(Oxygen_Kpa~Corrected.TIME,  col="RED",  main = paste("B" , Block.No , C_Crop.Type , "Treatment B" ), ylab = "O2 Kpa",type = "l", lwd = 4,
     
     ylim = range(Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment == "B" , c("Oxygen_Kpa" , "Temp.Corrected.O2_Kpa" )], na.rm = T),
     
     
     data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment == "B" &  Data.Oxygen.Temperature$FAC.Depth_cm =="5",]    ) ;


points(Temp.Corrected.O2_Kpa~Corrected.TIME, col="BLUE" , type = "l", lwd = 4,
       
     data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment == "B" &  Data.Oxygen.Temperature$FAC.Depth_cm =="5",] ) ;


points(Oxygen_Kpa~Corrected.TIME, col="MAGENTA" , type = "l", lwd = 4,
       
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="B" &  Data.Oxygen.Temperature$FAC.Depth_cm =="20",]);


points(Temp.Corrected.O2_Kpa~Corrected.TIME, col="GREEN" ,  type = "l", lwd = 4,
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="B" &  Data.Oxygen.Temperature$FAC.Depth_cm =="20",] ) ;


legend.1<-c("Oxygen_Kpa 5 cm", "Temp.Corrected.O2_Kpa 5 cm" , "Oxygen_Kpa 20 cm" , "Temp.Corrected.O2_Kpa 20 cm"  )

legend.2<-c("solid" , "solid" , "solid" , "solid")

legend.3<-c(16, 16, 16, 16)

legend.4<-c( "RED" ,"BLUE", "MAGENTA" , "GREEN")

legend(x = "topleft" , legend = legend.1, col = legend.4, pt.cex= 2.0 , bty = "n" ,lty = legend.2, lwd = 2)
#legend(x = "bottom" , legend = legend.1, lty = legend.2, pch = legend.3 , col = legend.4, title = "Legend" , pt.cex= 2.0 , lwd = legend.5, ncol = 3)





####  Checking Treatment C  #####


range(Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment == "C" , c("Oxygen_Kpa" , "Temp.Corrected.O2_Kpa" )], na.rm = T)

plot(Oxygen_Kpa~Corrected.TIME, col="RED", main = paste("B" , Block.No , C_Crop.Type , "Treatment C" ),  type = "l", lwd = 4,
     
     ylim = range(Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment == "C" , c("Oxygen_Kpa" , "Temp.Corrected.O2_Kpa" )], na.rm = T) ,
     
     data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="C" &  Data.Oxygen.Temperature$FAC.Depth_cm =="5",] ) ;


points(Temp.Corrected.O2_Kpa~Corrected.TIME, col="BLUE" , type = "l", lwd = 4,
       
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="C" &  Data.Oxygen.Temperature$FAC.Depth_cm =="5",] ) ;


points(Oxygen_Kpa~Corrected.TIME, col= "MAGENTA" , type = "l", lwd = 4 ,
       
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="C" &  Data.Oxygen.Temperature$FAC.Depth_cm =="20",] ) ;

points(Temp.Corrected.O2_Kpa~Corrected.TIME, col= "GREEN" , type = "l", lwd = 4 ,
       
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="C" &  Data.Oxygen.Temperature$FAC.Depth_cm =="20",] ) ;


legend.1<-c("Oxygen_Kpa 5 cm", "Temp.Corrected.O2_Kpa 5 cm" , "Oxygen_Kpa 20 cm" , "Temp.Corrected.O2_Kpa 20 cm"  ) 

legend.2<-c("solid" , "solid" , "solid" , "solid")

legend.3<-c(16, 16, 16, 16)

legend.4<-c( "RED" ,"BLUE", "MAGENTA" , "GREEN")

# legend(x = "bottomleft" , legend = legend.1, pch = legend.3 , col = legend.4, title = "Legend" , pt.cex= 2.0 )

legend(x = "topleft" , legend = legend.1, col = legend.4, title = "Legend" , pt.cex= 2.0 , bty = "n",lty = legend.2, lwd = 2)



###############################################################################################################
#                         Calibration of the data based on the calibration equation obtained from  
#                         simultaneous measurements with the NIST traceable OXYBaseOx_kPa~S200Ox_kPa
#                          and temperature
###############################################################################################################


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

# (Intercept) S210_1_Smv_Med 
# -0.3022907      1.6411377 
###############################################################################################################



str(Data.Oxygen.Temperature);


Data.Oxygen.Temperature$Calibrated.O2_Kpa<-(Data.Oxygen.Temperature$Temp.Corrected.O2_Kpa * 1.6411377) + -0.3022907 ;


####  Checking Treatment B  #####

range(Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment == "B" , c("Oxygen_Kpa" , "Calibrated.O2_Kpa")], na.rm = T)

plot(Oxygen_Kpa~Corrected.TIME, col="RED", main = paste("B" , Block.No , C_Crop.Type , "Treatment B" ) , type = "l", lwd = 4 ,
     
     ylim = range(Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment == "B" , c("Oxygen_Kpa" , "Calibrated.O2_Kpa")], na.rm = T) ,
     
     data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="B" &  Data.Oxygen.Temperature$FAC.Depth_cm =="5",]) ;


points(Calibrated.O2_Kpa~Corrected.TIME, col="BLUE" , type = "l", lwd = 4 ,
       
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="B" &  Data.Oxygen.Temperature$FAC.Depth_cm =="5",] ) ;


points(Oxygen_Kpa~Corrected.TIME,  col = "MAGENTA"  , type = "l", lwd = 4 , 
       
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="B" &  Data.Oxygen.Temperature$FAC.Depth_cm =="20",] ) ;


points(Calibrated.O2_Kpa~Corrected.TIME, col = "GREEN" , type = "l", lwd = 4 ,
       
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="B" &  Data.Oxygen.Temperature$FAC.Depth_cm =="20",] ) ;


legend.1<-c("Temp.Corrected.O2_Kpa 5 cm", "Calibrated.O2_Kpa 5 cm" , "Temp.Corrected.O2_Kpa 20 cm", "Calibrated.O2_Kpa 20 cm" )

legend.2<-c("solid" , "solid" , "solid" , "solid")

legend.3<-c(16, 16, 16, 16)

legend.4<-c( "RED" ,"BLUE", "MAGENTA" , "GREEN")

#legend(x = "bottomleft" , legend = legend.1 , col = legend.4, title = "Legend" , pt.cex= 2.0 )

legend(x = "topleft" , legend = legend.1 , col = legend.4, lty = legend.2, lwd = 2, bty = "n")



####  Checking Treatment C  #####

range(Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment == "C" , c("Oxygen_Kpa" , "Calibrated.O2_Kpa")], na.rm = T)

plot(Oxygen_Kpa~Corrected.TIME, col="RED", main = paste("B" , Block.No , C_Crop.Type , "Treatment C" ) , type = "l", lwd = 4 ,
     
     ylim = range(Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment == "C" , c("Oxygen_Kpa" , "Calibrated.O2_Kpa")], na.rm = T) ,
     
     data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="C" &  Data.Oxygen.Temperature$FAC.Depth_cm =="5",] ) ;


points(Calibrated.O2_Kpa~Corrected.TIME, col="BLUE", type = "l", lwd = 4 ,
       
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="C" &  Data.Oxygen.Temperature$FAC.Depth_cm =="5",] ) ;

points(Oxygen_Kpa~Corrected.TIME, col = "MAGENTA", type = "l", lwd = 4 ,
       
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="C" &  Data.Oxygen.Temperature$FAC.Depth_cm =="20",] ) ;

points(Calibrated.O2_Kpa~Corrected.TIME, col = "GREEN" , type = "l", lwd = 4 ,
       
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="C" &  Data.Oxygen.Temperature$FAC.Depth_cm =="20",] ) ;



legend.1<-c("Temp.Corrected.O2_Kpa 5 cm", "Calibrated.O2_Kpa 5 cm" , "Temp.Corrected.O2_Kpa 20 cm", "Calibrated.O2_Kpa 20 cm" )

legend.2<-c("solid" , "solid" , "solid" , "solid")

legend.3<-c(16, 16, 16, 16)

legend.4<-c( "RED" ,"BLUE", "MAGENTA" , "GREEN")

#legend(x = "bottomleft" , legend = legend.1, pch = legend.3 , col = legend.4, title = "Legend" , pt.cex= 2.0 )

legend(x = "topleft" , legend = legend.1, col = legend.4 , lty = legend.2 , lwd = 2, bty = "n" )


###############################################################################################################
#                         Final plot with the temperature corrected and calibrated O2 Data
###############################################################################################################



#### Treatment B  #####

par(mfrow = c(2,1), mar = c(2, 4, 4 , 4) + 0.1 , mgp = c(2, .6, 0))

range(Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment == "B" , c("Oxygen_Kpa" , "Calibrated.O2_Kpa")], na.rm = T)

plot(Oxygen_Kpa~Corrected.TIME, data = Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment == "B" &  Data.Oxygen.Temperature$FAC.Depth_cm =="5",],
     
    ylim = range(Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment == "B" , c("Oxygen_Kpa" , "Calibrated.O2_Kpa")], na.rm = T) ,
 
    type = "l" , lwd = 4 , col="MAGENTA",  xlab = NA, ylab = paste0("Oxygen Kpa - 5 cm") ,  tck = 1,  cex.axis = 1.5 , 
    
    cex.lab = 1.5  ,  main = paste("B" , Block.No , C_Crop.Type , "Treatment B" ) , format = "%Y-%m-%d" ) ;


points(Temp.Corrected.O2_Kpa~Corrected.TIME, col="BLUE" , type = "l", lwd = 4 ,
       
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="B" &  Data.Oxygen.Temperature$FAC.Depth_cm =="5",]) ;


points(Calibrated.O2_Kpa~Corrected.TIME, col="RED" , type = "l", lwd = 4,
       
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="B" &  Data.Oxygen.Temperature$FAC.Depth_cm =="5",] ) ;



### forming the legend ##

legend.1<-c("Raw Data" , "Temp Corrected"  , "Calibrated")

legend.2<-c("solid" , "solid", "solid" ) 

legend.4<-c("MAGENTA", "BLUE" ,"RED")

legend.5<-c( 3, 3 , 3)

# legend(x = "bottomleft" , legend = legend.1, lty = legend.2,  pch = legend.3 , col = legend.4, 
#        pt.cex= 2.0 , lwd = legend.5, bty = "n", horiz = T, ncol = 2)

legend(x = "topleft" , legend = legend.1, lty = legend.2, col = legend.4,  cex = 2 , lwd = legend.5, bty = "n")


par(mar = c(5, 4, 1 , 4) + 0.1) 

range(Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment == "B" , c("Oxygen_Kpa" , "Calibrated.O2_Kpa")], na.rm = T)


plot(Oxygen_Kpa~Corrected.TIME, data = Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment == "B" &  Data.Oxygen.Temperature$FAC.Depth_cm =="20",] ,
     
     ylim = range(Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment == "B" , c("Oxygen_Kpa" , "Calibrated.O2_Kpa")], na.rm = T) ,
     
     type = "l" , lwd = 4 , col="MAGENTA",  xlab = "Date", ylab = paste0("Oxygen Kpa - 20 cm") ,  tck = 1,  cex.axis = 1.5 , 
     
     cex.lab = 1.5  , format = "%Y-%m-%d" ) ;


points(Temp.Corrected.O2_Kpa~Corrected.TIME, col="BLUE" , type = "l", lwd = 4 ,
       
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="B" &  Data.Oxygen.Temperature$FAC.Depth_cm =="20",]) ;


points(Calibrated.O2_Kpa~Corrected.TIME, col="RED" , type = "l", lwd = 4,
       
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="B" &  Data.Oxygen.Temperature$FAC.Depth_cm =="20",] ) ;




#### Treatment C  #####


par(mfrow = c(2,1), mar = c(2, 4, 4 , 4) + 0.1 , mgp = c(2, .6, 0))

range(Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment == "C" , c("Oxygen_Kpa" , "Calibrated.O2_Kpa")], na.rm = T)


plot(Oxygen_Kpa~Corrected.TIME, data = Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment == "C" &  Data.Oxygen.Temperature$FAC.Depth_cm =="5",],
     
     ylim = range(Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment == "C" , c("Oxygen_Kpa" , "Calibrated.O2_Kpa")], na.rm = T) ,
     
     type = "l" , lwd = 4 , col="MAGENTA",  xlab = NA, ylab = paste0("Oxygen Kpa - 5 cm") ,  tck = 1,  cex.axis = 1.5 , 
     
     cex.lab = 1.5  ,  main = paste("B" , Block.No , C_Crop.Type , "Treatment C" ) , format = "%Y-%m-%d" ) ;


points(Temp.Corrected.O2_Kpa~Corrected.TIME, col="BLUE" , type = "l", lwd = 4 ,
       
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="C" &  Data.Oxygen.Temperature$FAC.Depth_cm =="5",]) ;


points(Calibrated.O2_Kpa~Corrected.TIME, col="RED" , type = "l", lwd = 4,
       
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="C" &  Data.Oxygen.Temperature$FAC.Depth_cm =="5",] ) ;



### forming the legend ##
### forming the legend ##

legend.1<-c("Raw Data" , "Temp Corrected"  , "Calibrated")

legend.2<-c("solid" , "solid", "solid" ) 

legend.4<-c("MAGENTA", "BLUE" ,"RED")

legend.5<-c( 3, 3 , 3)

# legend(x = "bottomleft" , legend = legend.1, lty = legend.2,  pch = legend.3 , col = legend.4, 
#        pt.cex= 2.0 , lwd = legend.5, bty = "n", horiz = T, ncol = 2)

legend(x = "topleft" , legend = legend.1, lty = legend.2, col = legend.4,  cex = 2 , lwd = legend.5, bty = "n")


par(mar = c(5, 4, 1 , 4) + 0.1) 


range(Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment == "C" , c("Oxygen_Kpa" , "Calibrated.O2_Kpa")], na.rm = T)

plot(Oxygen_Kpa~Corrected.TIME, data = Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment == "C" &  Data.Oxygen.Temperature$FAC.Depth_cm =="20",],
     
     ylim = range(Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment == "C" , c("Oxygen_Kpa" , "Calibrated.O2_Kpa")], na.rm = T) ,
     
     type = "l" , lwd = 4 , col="MAGENTA",  xlab = "Date", ylab = paste0("Oxygen Kpa - 20 cm") ,  tck = 1,  cex.axis = 1.5 , 
     
     cex.lab = 1.5  , format = "%Y-%m-%d" ,main = paste("B" , Block.No , C_Crop.Type , "Treatment C" )) ;


points(Temp.Corrected.O2_Kpa~Corrected.TIME, col="BLUE" , type = "l", lwd = 4 ,
       
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="C" &  Data.Oxygen.Temperature$FAC.Depth_cm =="20",]) ;


points(Calibrated.O2_Kpa~Corrected.TIME, col="RED" , type = "l", lwd = 4,
       
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="C" &  Data.Oxygen.Temperature$FAC.Depth_cm =="20",] ) ;



dev.off() 





###############################################################################################################
#                         Writing the processed and clean data to an excel file
###############################################################################################################

Data.Oxygen.Temperature.Write<-Data.Oxygen.Temperature [,c("Corrected.TIME" , "Block" , "C_Crop", "FAC.Treatment" , "FAC.Depth_cm"  , "Temperature_C" , "Calibrated.O2_Kpa")] ;

names(Data.Oxygen.Temperature.Write)[ which(names(Data.Oxygen.Temperature.Write) == "FAC.Depth_cm")]<-"Depth_cm" ;

names(Data.Oxygen.Temperature.Write)[ which(names(Data.Oxygen.Temperature.Write) == "FAC.Treatment")]<-"Treatment" ;

head(Data.Oxygen.Temperature.Write)

str(Data.Oxygen.Temperature.Write)

getwd()

Files.Directories[[File.to.Download]]

Sys.Date()


# write.csv( x = Data.Oxygen.Temperature.Write,
            file= paste0(Main.Directorys[MD], "\\",Files.Directories[[File.to.Download]] ,
                         "\\ProcessedData\\",Files.Directories[[File.to.Download]], Block.No, C_Crop.Type, Sys.Date() ,".csv" ) ,
             quote = F, row.names=F)  ;


