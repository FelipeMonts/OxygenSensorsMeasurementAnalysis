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

File.to.Download = 3

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

# i = Files.to.Read[2]

for (i in Files.to.Read) {
  
  O2.Data.2021.1<-read.csv(file= paste0(Main.Directorys[MD],"\\",Files.Directories[[File.to.Download]], "\\" , "ProcessedData" ,"\\", i),
           header = T) ;
  
  O2.Data.2021.2<-rbind(O2.Data.2021.0, O2.Data.2021.1) ;
  
  
  O2.Data.2021.0<-O2.Data.2021.2 ;
  
  rm(O2.Data.2021.2,O2.Data.2021.1 ) ;
  
  
}

str(O2.Data.2021.0)

### some of the crop names are 3spp and others are 3Spp

str(O2.Data.2021.0[O2.Data.2021.0$C_Crop == "3spp",])

str(O2.Data.2021.0[O2.Data.2021.0$C_Crop == "3Spp",])

O2.Data.2021.0[O2.Data.2021.0$C_Crop == "3spp", c("C_Crop")]<- "3Spp" ;


#### Give each column the adequate format

O2.Data.2021.0[,c("Corrected.TIME")]<-as.POSIXct(O2.Data.2021.0[,c("Corrected.TIME")]) ;


O2.Data.2021.0$Block<-as.factor(O2.Data.2021.0$Block) ;

O2.Data.2021.0$C_Crop<-as.factor(O2.Data.2021.0$C_Crop) ;

O2.Data.2021.0$Treatment<-as.factor(O2.Data.2021.0$Treatment) ;

O2.Data.2021.0$Depth_cm<-as.factor(O2.Data.2021.0$Depth_cm) ;


str(O2.Data.2021.0)


##### check for duplicated data 

anyDuplicated(O2.Data.2021.0)

any(duplicated(O2.Data.2021.0))

O2.Data.2021.0[which(duplicated(O2.Data.2021.0)),]

#### Select Only unique data  ####

O2.Data.2021<-unique(O2.Data.2021.0) ;


any(duplicated(O2.Data.2021))

### Because there is only one panel temperature for each download (all treatments and depths in a crop) it is difficult to include panel temperature.
### The panel temperature is stored as Treatment == "Panel"

str(O2.Data.2021[O2.Data.2021$Treatment != "Panel" & O2.Data.2021$Depth_cm != "-100" , ])

str(O2.Data.2021[O2.Data.2021$Treatment == "Panel" & O2.Data.2021$Depth_cm == "-100" , ])

### Merge the data without panel temperature with panel temperature. The idea is that each record date will have associated its panel temperature.

O2.Data.2021.Plot.1<-merge(O2.Data.2021[O2.Data.2021$Treatment != "Panel" & O2.Data.2021$Depth_cm != "-100" , ],
                           O2.Data.2021[O2.Data.2021$Treatment == "Panel" & O2.Data.2021$Depth_cm == "-100" , ],
                           by = c("Corrected.TIME", "Block" , "C_Crop"), all.x = T)  ;

str(O2.Data.2021.Plot.1)


### simplify columns, get rid of redundant columns

names(O2.Data.2021.Plot.1)[c(1:7, 10)]


O2.Data.2021.Plot<-O2.Data.2021.Plot.1[, names(O2.Data.2021.Plot.1)[c(1:7, 10)]]

str(O2.Data.2021.Plot)

head(O2.Data.2021.Plot)


### Correct column names


names(O2.Data.2021.Plot)[4:8]<-c("Treatment" , "Depth_cm" , "Temperature_C" , "Calibrated.O2_Kpa", "Panel_Temperature_C") 

str(O2.Data.2021.Plot)


### check if data merge correctly

str(O2.Data.2021)

str(O2.Data.2021[O2.Data.2021$Block == "3" & O2.Data.2021$Treatment == "Panel" & O2.Data.2021$C_Crop == "Triticale" , c("Temperature_C")])

str(O2.Data.2021.Plot[O2.Data.2021.Plot$Block == "3" &  O2.Data.2021.Plot$C_Crop == "Triticale" &
                        O2.Data.2021.Plot$Treatment == "A" &  O2.Data.2021.Plot$Depth_cm == "20", c("Panel_Temperature_C") ])

plot(O2.Data.2021.Plot[O2.Data.2021.Plot$Block == "1" &  O2.Data.2021.Plot$C_Crop == "3Spp" &
                         O2.Data.2021.Plot$Treatment == "A" &  O2.Data.2021.Plot$Depth_cm == "20", c("Panel_Temperature_C") ],
     O2.Data.2021[O2.Data.2021$Block == "1" & O2.Data.2021$Treatment == "Panel" & O2.Data.2021$C_Crop == "3Spp" , c("Temperature_C")])
                        


###############################################################################################################
#                           Plotting the data to explore
###############################################################################################################




####  Plot Data selection  #####


levels(O2.Data.2021.Plot$Block) ;  

levels(O2.Data.2021.Plot$C_Crop) ;

levels(O2.Data.2021.Plot$Treatment) ;

Block.sel ="1" 

C_Crop.sel = "Clover" 

Treatment.sel = "B"


Plot.selected.data<-O2.Data.2021.Plot[O2.Data.2021.Plot$Block == Block.sel & 
                                        
                                        O2.Data.2021.Plot$C_Crop == C_Crop.sel &

                                        O2.Data.2021.Plot$Treatment == Treatment.sel ,
                                      
                                      c("Corrected.TIME" , "Depth_cm" , "Temperature_C" , "Calibrated.O2_Kpa" ,"Panel_Temperature_C")]


str(Plot.selected.data)
                                  

#### Plot 1 to identify range ### 


plot(Panel_Temperature_C~Corrected.TIME, data=Plot.selected.data , col="BLUE", ylab = "Temperature °C" ,
     xlab = "Date" ,  main = paste0("Block-", Block.sel, "-", C_Crop.sel, "-" , Treatment.sel ))  ;


#### Plot zoom in ### 



summary(Plot.selected.data)


Plot.date.range<-c(min(Plot.selected.data$Corrected.TIME), max(Plot.selected.data$Corrected.TIME)) ;


#Plot.date.range<-c(as.POSIXct("2018-08-09 00:30:00"),as.POSIXct("2021-12-31 11:30:00")) ;



Plot.selected.data<-O2.Data.2021.Plot[O2.Data.2021.Plot$Block == Block.sel & 
                                        
                                        O2.Data.2021.Plot$C_Crop == C_Crop.sel &
                                        
                                        O2.Data.2021.Plot$Treatment == Treatment.sel & 
                                        
                                        O2.Data.2021.Plot$Corrected.TIME >= Plot.date.range[1] &
                                        
                                        O2.Data.2021.Plot$Corrected.TIME <= Plot.date.range[2],
                                      
                                      c("Corrected.TIME" , "Depth_cm" , "Temperature_C" , "Calibrated.O2_Kpa" ,"Panel_Temperature_C")]



Range.T<-c(min(min(Plot.selected.data$Temperature_C,na.rm = T), min(Plot.selected.data$Panel_Temperature_C,na.rm = T)),
           max(max(Plot.selected.data$Temperature_C,na.rm = T), max(Plot.selected.data$Panel_Temperature_C,na.rm = T)) ) ;

# Range.O2<-c(min(min(Plot.selected.data$Calibrated.O2_Kpa,na.rm = T), min(Plot.selected.data$Calibrated.O2_Kpa,na.rm = T)),
#            max(max(Plot.selected.data$Calibrated.O2_Kpa,na.rm = T), max(Plot.selected.data$Calibrated.O2_Kpa,na.rm = T)) ) ;


Range.O2<-c(0,20)


##### Composing the Plot double Y axis ####

par(mar = c(5, 4, 4, 4) + 0.3)


plot(Panel_Temperature_C~Corrected.TIME, data=Plot.selected.data[Plot.selected.data$Depth_cm == "5" ,] ,
     
     type = "l" , lwd = 4 ,col="MAGENTA", ylab = "Temperature °C" ,  xlab = "Date", ylim = Range.T , xlim = Plot.date.range,
     
     main = paste0("Block-", Block.sel, "-", C_Crop.sel, "-" , Treatment.sel ) ) ;

points(Temperature_C~Corrected.TIME, data=Plot.selected.data[Plot.selected.data$Depth_cm == "5" , ]  , type = "l" , lwd = 4 , col="RED") ;

points(Temperature_C~Corrected.TIME, data=Plot.selected.data[Plot.selected.data$Depth_cm == "20" , ] , type = "l" , lwd = 4 , col="BLUE") ;


par(new=T)

plot(Calibrated.O2_Kpa~Corrected.TIME,  data=Plot.selected.data[Plot.selected.data$Depth_cm == "5" ,],
     
     axes = F , bty = "n", xlab="" , ylab ="" , col="RED",  ylim = Range.O2, pch = 16, cex=2) ;

axis( side = 4, at = NULL) ;

mtext("Oxygen Kpa", side=4, line=2)

points(Calibrated.O2_Kpa~Corrected.TIME,  data=Plot.selected.data[Plot.selected.data$Depth_cm == "20" ,], col="BLUE", pch = 16, cex=2) ;

### forming the legend ##

legend.1<-c("Panel T", "T°C 5 cm" , "T°C 20 cm" , "O2 5 cm" , "O2 20 cm"  )

legend.2<-c("solid" , "solid" , "solid" , "blank" , "blank" ) 

legend.3<-c(NA, NA, NA, 16, 16)

legend.4<-c("MAGENTA", "RED" , "BLUE" ,"RED" , "BLUE")

legend.5<-c(2, 2, 2, 3, 3)

# legend(x = "bottomleft" , legend = legend.1, lty = legend.2,  pch = legend.3 , col = legend.4, 
#        pt.cex= 2.0 , lwd = legend.5, bty = "n", horiz = T, ncol = 2)

legend(x = "bottomleft" , legend = legend.1, lty = legend.2,  pch = legend.3 , col = legend.4, 
       pt.cex= 2.0 , lwd = legend.5, bty = "n", ncol = 2)

#### Multiple panels only one Y axis ####

# #### From stackoverflow https://stackoverflow.com/questions/45546085/how-to-create-a-multiple-plots-having-same-x-axis
# 
# set.seed(32273438)
# A1 <- rnorm(100)
# B1 <- rnorm(100)
# B2 <- rnorm(100)
# B3 <- rnorm(100)
# 
# par(mfcol = c(3, 1), mar = numeric(4), oma = c(4, 4, .5, .5), 
#     mgp = c(2, .6, 0))
# plot(A1, B1, axes = FALSE)
# axis(2L)
# box()
# plot(A1, B2, axes = FALSE)
# axis(2L)
# box()
# plot(A1, B3, axes = FALSE)
# axis(1L)
# axis(2L)
# box()
# mtext("A1", side = 1, outer = TRUE, line = 2.2)
# mtext("B", side = 2, outer = TRUE, line = 2.2)
# 
# 
# ##### Other option  ##### 
# 
# par(mar=c(6,6,4,4))
# layout(matrix(1:3, ncol = 1), widths = 1, heights = c(2.3,2,2.3), respect = FALSE)
# par(mar = c(0, 4.1, 4.1, 2.1))
# plot(B1,A1,xaxt='n')
# par(mar = c(0, 4.1, 0, 2.1))
# plot(B2,A1,xaxt='n')
# par(mar = c(4.1, 4.1, 0, 2.1))
# plot(B3,A1)
# 
###### Also manipulating the axis tick marks and labels  https://r-charts.com/base-r/axes/ 



# par(mfcol = c(2,1), mar = numeric(4), oma = c(4, 4, .5, .5), mgp = c(2, .6, 0))
# 
# par(mfrow = c(2,1), mar = numeric(4) )
# 
# par(mfrow = c(2,1), oma = c(4, 4, .5, .5))
# 
# par(mfrow = c(2,1), mgp = c(2, .6, 0) )

par(mfrow = c(2,1), mar = c(2, 4, 4 , 4) + 0.1 , mgp = c(2, .6, 0))

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


write.csv( x = O2.Data.2021.Plot,  file= paste0(Main.Directorys[MD], "\\", Files.Directories[[File.to.Download]] , "\\" , 
                                                
                                                "CompiledData" , Files.Directories[[File.to.Download]] , 
                                                
                                                Sys.Date() ,".csv" ) , quote = F, row.names=F)  ;
