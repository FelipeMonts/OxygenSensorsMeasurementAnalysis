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
library(lattice)




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

File.to.Download = 1

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

O2.Data.2021<-data.frame( Corrected.TIME = character(), Block = integer() , C_Crop = character() , Treatment = character(), Depth_cm = integer() , 
                           Temperature_C = double() , Calibrated.O2_Kpa = double()  ) ;

str(O2.Data.2021)

# i = Files.to.Read[2]

for (i in Files.to.Read) {
  
  O2.Data.2021.1<-read.csv(file= paste0(Main.Directorys[MD],"\\",Files.Directories[[File.to.Download]], "\\" , "ProcessedData" ,"\\", i),
           header = T) ;
  
  O2.Data.2021.2<-rbind(O2.Data.2021, O2.Data.2021.1) ;
  
  
  O2.Data.2021<-O2.Data.2021.2 ;
  
  rm(O2.Data.2021.2,O2.Data.2021.1 ) ;
  
  
}

str(O2.Data.2021)

### some of the crop nmeas are 3spp and others are 3Spp

str(O2.Data.2021[O2.Data.2021$C_Crop == "3spp",])

str(O2.Data.2021[O2.Data.2021$C_Crop == "3Spp",])

O2.Data.2021[O2.Data.2021$C_Crop == "3spp", c("C_Crop")]<- "3Spp" ;


#### Give each column the adequate format

O2.Data.2021[,c("Corrected.TIME")]<-as.POSIXct(O2.Data.2021[,c("Corrected.TIME")]) ;


O2.Data.2021$Block<-as.factor(O2.Data.2021$Block) ;

O2.Data.2021$C_Crop<-as.factor(O2.Data.2021$C_Crop) ;

O2.Data.2021$Treatment<-as.factor(O2.Data.2021$Treatment) ;

O2.Data.2021$Depth_cm<-as.factor(O2.Data.2021$Depth_cm) ;


str(O2.Data.2021)


##### check for duplicated data 

anyDuplicated(O2.Data.2021)

any(duplicated(O2.Data.2021))


###############################################################################################################
#                           Plotting the data to explore
###############################################################################################################



####  Plot 1 #####

Plot.date.range<-c(as.POSIXct("2018-01-01 11:30:00"),as.POSIXct("2021-12-31 11:30:00"))

Plot.block<-levels(O2.Data.2021$Block) ;  

Plot.crop<-levels(O2.Data.2021$C_Crop) ;

Plot.treatment<-levels(O2.Data.2021$Treatment) ;

Plot.depth<-levels(O2.Data.2021$Depth_cm) ;

Plot.date.range ; Plot.block ; Plot.crop ; Plot.treatment ; Plot.depth


### Because there is only one panel temperature for each download (all treatments and depths in a crop) it is difficult to include panel temperature.
### The panel temperature is stored as Treatment == "Panel"

str(O2.Data.2021[O2.Data.2021$Treatment != "Panel" & O2.Data.2021$Depth_cm != "-100" , ])

str(O2.Data.2021[O2.Data.2021$Treatment == "Panel" & O2.Data.2021$Depth_cm == "-100" , ])



O2.Data.2021.Plot.1<-merge(O2.Data.2021[O2.Data.2021$Treatment != "Panel" & O2.Data.2021$Depth_cm != "-100" , ],
           O2.Data.2021[O2.Data.2021$Treatment == "Panel" & O2.Data.2021$Depth_cm == "-100" , ],
           by = c("Corrected.TIME", "Block" , "C_Crop"), all.x = T)  ;

str(O2.Data.2021.Plot.1)

names(O2.Data.2021.Plot.1)[c(1:7, 10)]


O2.Data.2021.Plot<-O2.Data.2021.Plot.1[, names(O2.Data.2021.Plot.1)[c(1:7, 10)]]

str(O2.Data.2021.Plot)

head(O2.Data.2021.Plot)

names(O2.Data.2021.Plot)[4:8]<-c("Treatment" , "Depth_cm" , "Temperature_C." , "Calibrated.O2_Kpa", "Panel_Temperature_C") 

str(O2.Data.2021.Plot)



str(merge(Plot.selected.data,Plot.selected.panel, by = c("Corrected.TIME", "Block" , "C_Crop"), all.x = T))


Plot.selected.data<-O2.Data.2021[O2.Data.2021$Block == Plot.block[3] & O2.Data.2021$C_Crop == Plot.crop[2] &
                                   
                                   O2.Data.2021$Treatment == Plot.treatment[1] &
                                   
                                   O2.Data.2021$Depth_cm == Plot.depth[1] &
                                   
                                   O2.Data.2021$Corrected.TIME >= Plot.date.range[1] & O2.Data.2021$Corrected.TIME <= Plot.date.range[2],]


                                   
                                   
                                   
                                   
                                 

                        
str(Plot.selected.data)

Plot.selected.panel<-O2.Data.2021[O2.Data.2021$Block == Plot.block[3] & O2.Data.2021$C_Crop == Plot.crop[2] & O2.Data.2021$Treatment == Plot.treatment[4] &
                                    O2.Data.2021$Corrected.TIME >= Plot.date.range[1] & O2.Data.2021$Corrected.TIME <= Plot.date.range[2],]



str(Plot.selected.panel)

par(mar = c(5, 4, 4, 4) + 0.3)


plot(Temperature_C~Corrected.TIME, data=Plot.selected.data<-O2.Data.2021[O2.Data.2021$Block == Plot.block[3] & O2.Data.2021$C_Crop == Plot.crop[2] & O2.Data.2021$Treatment == Plot.treatment[2] &
                                                                           O2.Data.2021$Corrected.TIME >= Plot.date.range[1] & O2.Data.2021$Corrected.TIME <= Plot.date.range[2],],
     col="BLUE", main = paste("B" , Block.No , C_Crop.Type , "Treatment B" ), ylim =c(-20,40) , ylab = "Temperature °C" ,
     xlab = "Date") ;

points(Temperature_C~Corrected.TIME, 
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="B" &  Data.Oxygen.Temperature$FAC.Depth_cm =="5",],
       col="RED") ;

points(Temperature_C~Corrected.TIME, 
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="B" &  Data.Oxygen.Temperature$FAC.Depth_cm =="20",],
       col="GREEN")


par(new=T)

plot(Oxygen_Kpa~Corrected.TIME, 
     data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="B" &  Data.Oxygen.Temperature$FAC.Depth_cm =="5",],
     axes = F , bty = "n", xlab="" , ylab ="", lty= 1,  type = "l", col="RED", ylim = c(0,20), lwd = 3) ;
axis( side = 4, at = NULL)
mtext("Oxygen Kpa", side=4, line=2)

points(Oxygen_Kpa~Corrected.TIME, 
       data=Data.Oxygen.Temperature[Data.Oxygen.Temperature$FAC.Treatment =="B" &  Data.Oxygen.Temperature$FAC.Depth_cm =="20",],
       lty= 1,  type = "l" , col="GREEN", lwd = 3) ;

legend.1<-c("Panel T", "T°C 5 cm" , "T°C 20 cm" , "O2 5 cm" , "O2 20 cm"  )

legend.2<-c("blank" , "blank" , "blank" , "solid" , "solid")

legend.3<-c(16, 16, 16, NA , NA)

legend.4<-c("BLUE", "RED" , "GREEN" ,"RED" , "GREEN")

legend.5<-c(1, 1, 1, 3, 3)

# legend(x = "bottomleft" , legend = legend.1, lty = legend.2, pch = legend.3 , col = legend.4, title = "Legend" , pt.cex= 2.0 , lwd = legend.5)

legend(x = "bottom" , legend = legend.1, lty = legend.2, pch = legend.3 , col = legend.4, title = "Legend" , pt.cex= 2.0 , lwd = legend.5, ncol = 2)


