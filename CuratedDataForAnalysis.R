##############################################################################################################
# 
# 
# Program to gather all the compiled data from the oxygen sensor data collected from the Apogee S-210 sensors deployed in the 
#  Strategic Tillage USda-Nifa funded project
# 
#    
# 
# 
#  Felipe Montes 2023/04/11
# 
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


# The original download data was processed and cleaned using the  OxygenMeasurementsProcessing.R code 
# D:\Felipe\Current_Projects\CCC Based Experiments\StrategicTillage_NitrogenLosses_OrganicCoverCrops\
# DataAnalysis\RCode\OxygenSensorsMeasurementAnalysis\OxygenMeasurementsProcessing.R. 
# The data is stored in processed data directories in the downloaded folders.



Main.Directorys<-c("OxygenSensorsData2021" , "OxygenSensorsData2022_2023" ) ;

Main.Directorys

MD=1

Main.Directorys[MD]


Files.Directories<-list.files(paste0(".\\",Main.Directorys[MD]))  ;

Files.Directories


## Read which compiled data files are available in each download directory



Files.to.Read<-list.files(paste0(Main.Directorys[MD],"\\",Files.Directories[[3]])) ;

Read.Files <- grep(".csv",  x = Files.to.Read) ;


Files.to.Read[[Read.Files]]


###############################################################################################################
#                           Read all the compiled files
###############################################################################################################

# Initiate the data frame

O2.Data.2021.0<-data.frame( Corrected.TIME = character(), Block = integer() , C_Crop = character() , Treatment = character(), Depth_cm = integer() , 
                           Temperature_C = double() , Calibrated.O2_Kpa = double(), Panel_Temperature_C = double()  ) ;

str(O2.Data.2021.0)

# i = Files.Directories[[1]]

for (i in Files.Directories[3]) {
  
  Files.to.Read<-list.files(paste0(Main.Directorys[MD],"\\",i)) ;
  
  Read.Files <- grep(".csv",  x = Files.to.Read, value = T) ;
  
  O2.Data.2021.1<-read.csv(file= paste0(Main.Directorys[MD],"\\",i, "\\", Read.Files ), header = T) ;
  
  
  
  O2.Data.2021.2<-rbind(O2.Data.2021.0, O2.Data.2021.1) ;
  
  
  O2.Data.2021.0<-O2.Data.2021.2 ;
  
  rm(O2.Data.2021.2,O2.Data.2021.1 ) ;
  
  
}

str(O2.Data.2021.0)


#### Give each column the adequate format

O2.Data.2021.0[,c("Corrected.TIME")]<-as.POSIXct(O2.Data.2021.0[,c("Corrected.TIME")]) ;


O2.Data.2021.0$Block<-as.factor(O2.Data.2021.0$Block) ;

O2.Data.2021.0$C_Crop<-as.factor(O2.Data.2021.0$C_Crop) ;

O2.Data.2021.0$Treatment<-as.factor(O2.Data.2021.0$Treatment) ;

O2.Data.2021.0$Depth_cm<-as.factor(O2.Data.2021.0$Depth_cm) ;


str(O2.Data.2021.0)


##### check for duplicated data 

any(duplicated(O2.Data.2021.0))

anyDuplicated(O2.Data.2021.0)

O2.Data.2021.0[which(duplicated(O2.Data.2021.0)),]

#### Select Only unique data  ####

O2.Data.2021.2<-unique(O2.Data.2021.0) ;

any(duplicated(O2.Data.2021.2))

str(O2.Data.2021.2)




###############################################################################################################
#                           Plotting the data to explore
###############################################################################################################


####  Plot Panel temperature  #####

plot(Panel_Temperature_C ~ Corrected.TIME,   data = O2.Data.2021.2, type = "l")




####  Plot Data selection  #####


levels(O2.Data.2021.2$Block) ;  

levels(O2.Data.2021.2$C_Crop) ;

levels(O2.Data.2021.2$Treatment) ;

Block.sel ="3" 

C_Crop.sel = "Triticale" 

Treatment.sel = "B"


Plot.selected.data<-O2.Data.2021.2[O2.Data.2021.2$Block == Block.sel & 
                                        
                                        O2.Data.2021.2$C_Crop == C_Crop.sel &

                                        O2.Data.2021.2$Treatment == Treatment.sel ,]
                                      


str(O2.Data.2021.2)
                                  

#### Plot 1 to identify range ### 


plot(Panel_Temperature_C~Corrected.TIME, data=Plot.selected.data , col="BLUE", ylab = "Temperature °C" ,
     xlab = "Date" ,  main = paste0("Block-", Block.sel, "-", C_Crop.sel, "-" , Treatment.sel ))  ;



###############################################################################################################
#                           Plotting selected data to explore
###############################################################################################################


summary(Plot.selected.data)


Plot.date.range<-c(min(Plot.selected.data$Corrected.TIME), max(Plot.selected.data$Corrected.TIME)) ;


#Plot.date.range<-c(as.POSIXct("2018-08-09 00:30:00"),as.POSIXct("2021-12-31 11:30:00")) ;



Plot.selected.data<-O2.Data.2021.2[O2.Data.2021.2$Block == Block.sel & 
                                        
                                        O2.Data.2021.2$C_Crop == C_Crop.sel &
                                        
                                        O2.Data.2021.2$Treatment == Treatment.sel & 
                                        
                                        O2.Data.2021.2$Corrected.TIME >= Plot.date.range[1] &
                                        
                                        O2.Data.2021.2$Corrected.TIME <= Plot.date.range[2],]
                                      
                                    



Range.T<-c(min(min(Plot.selected.data$Temperature_C,na.rm = T), min(Plot.selected.data$Panel_Temperature_C,na.rm = T)),
           max(max(Plot.selected.data$Temperature_C,na.rm = T), max(Plot.selected.data$Panel_Temperature_C,na.rm = T)) ) ;

# Range.O2<-c(min(min(Plot.selected.data$Calibrated.O2_Kpa,na.rm = T), min(Plot.selected.data$Calibrated.O2_Kpa,na.rm = T)),
#            max(max(Plot.selected.data$Calibrated.O2_Kpa,na.rm = T), max(Plot.selected.data$Calibrated.O2_Kpa,na.rm = T)) ) ;


Range.O2<-c(0,25)




### Temperature Plot  ###


plot(Panel_Temperature_C~Corrected.TIME, data=Plot.selected.data[Plot.selected.data$Depth_cm == "5" ,] ,
     
     type = "l" , lwd = 4 ,col="MAGENTA", xlab = NA, ylab = "Temperature °C" , ylim = Range.T , xlim = Plot.date.range ,
     
     tck = 1,  cex.axis = 1.5 , cex.lab = 1.5 , main = paste0("Block-", Block.sel, "-", C_Crop.sel, "-" , Treatment.sel ) , format = "%Y-%m-%d" ) ;




points(Temperature_C~Corrected.TIME, data=Plot.selected.data[Plot.selected.data$Depth_cm == "5" , ]  , type = "l" , lwd = 4 , col="RED") ;

points(Temperature_C~Corrected.TIME, data=Plot.selected.data[Plot.selected.data$Depth_cm == "20" , ] , type = "l" , lwd = 4 , col="BLUE") ;




### O2  PLot   ###

par(mar = c(5, 4, 1 , 4) + 0.1) 


plot(Calibrated.O2_Kpa~Corrected.TIME,  data=Plot.selected.data[Plot.selected.data$Depth_cm == "5" ,],
     
      bty = "o", xlab="Date" , ylab ="O2 Kpa" , col="RED",  ylim = Range.O2, type = "l", lwd = 4,  tck = 1 ,cex.axis = 1.5 ,
     
     cex.lab = 1.5  ,format = "%Y-%m-%d" ) ;

points(Calibrated.O2_Kpa~Corrected.TIME,  data=Plot.selected.data[Plot.selected.data$Depth_cm == "20" ,], col="BLUE", type = "l", lwd = 4) ;




### forming the legend ##

legend.1<-c("Panel T", "5 cm" , "20 cm" )

legend.2<-c("solid" , "solid" , "solid") 

legend.4<-c("MAGENTA", "RED" , "BLUE" )

legend.5<-c( 3, 3 , 3)

# legend(x = "bottomleft" , legend = legend.1, lty = legend.2,  pch = legend.3 , col = legend.4, 
#        pt.cex= 2.0 , lwd = legend.5, bty = "n", horiz = T, ncol = 2)

legend(x = "bottomleft" , legend = legend.1, lty = legend.2, col = legend.4, 
       pt.cex= 2.0 , lwd = legend.5, bty = "n", horiz = T, cex =1.2)


###############################################################################################################
#                           Write the compiled and processed data into a csv file
###############################################################################################################



str(O2.Data.2021.2)




write.csv( x = O2.Data.2021.2,  file= paste0(Main.Directorys[MD], "\\", "CuredData",Main.Directorys[MD], 
                                             
                                             Sys.Date() ,".csv" ) , quote = F, row.names=F)  ;

###############################################################################################################
#                           Corrections to the compiled data
###############################################################################################################


###############################################################################################################
#  Data from 2021 has the 5cm and 20 cm measurement switched. 
#  by relabeling the levels in the treatment Depth_cm this can be corrected
###############################################################################################################
getwd()


list.files("OxygenSensorsData2021")

Data.to.Correct <- read.csv( file = "OxygenSensorsData2021\\CuredDataOxygenSensorsData20212023-04-13.csv" , header = T) ;

str(Data.to.Correct)

Data.to.Correct$Corrected.TIME <- as.POSIXct(Data.to.Correct$Corrected.TIME) ;

Data.to.Correct$Depth_cm <- as.factor(Data.to.Correct$Depth_cm)  ;

levels(Data.to.Correct$Depth_cm) <- c("20" , "5") ;



###############################################################################################################
#                           Write the compiled and processed data into a csv file
###############################################################################################################

str(Data.to.Correct)


write.csv( x = Data.to.Correct,  file= paste0(Main.Directorys[MD], "\\", "CuredData",Main.Directorys[MD], 
                                              
                                              Sys.Date() ,".csv" ) , quote = F, row.names=F)  ;

