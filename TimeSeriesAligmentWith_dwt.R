##############################################################################################################
# 
# 
# Program to align time series data based on the paper 
# 
# Giorgino, Toni. “Computing and Visualizing Dynamic Time Warping Alignments in R: 
# The Dtw Package.” Journal of Statistical Software 31 (August 14, 2009): 1–24. https://doi.org/10.18637/jss.v031.i07.
# 
# and the Package 
# 
# Giorgino, Toni. “Dtw: Dynamic Time Warping Algorithms,” September 19, 2022. https://CRAN.R-project.org/package=dtw.
#    
# 
# 
#  Felipe Montes 2023/04/05
# 
# 
# 
############################################################################################################### 



###############################################################################################################
#                             Setting up working directory  Loading Packages and Setting up working directory                        
###############################################################################################################

# readClipboard()

setwd("C:\\Users\\frm10\\OneDrive - The Pennsylvania State University\\O2Sensors") ;


###############################################################################################################
#                            Install the packages that are needed                       
###############################################################################################################


#install.packages("dtw", dependencies = T )



###############################################################################################################
#                           load the libraries that are needed   
###############################################################################################################

library("dtw")



###############################################################################################################
#                           Explore the files and directory and files with the data from Felipe's Downloads
###############################################################################################################

### Read the Directories, files and data from the download directory where the Oxygen data is stored 

#CampbellSci.files<-c("CR1000NEW_DataTableInfo.dat" , "CR1000NEW_Oxygen.dat" ,       "CR1000NEW_Public.dat"  ,      "CR1000NEW_Status.dat" ) ;


Main.Directorys<-c("./OxygenSensorsData2021" , "./OxygenSensorsData2022_2023" ) ;

Main.Directorys

MD=1


Main.Directorys[MD]

#Files.Directories<-list.files("./OxygenSensorsData2022_2023");

Files.Directories<-list.files(Main.Directorys[MD]);

Files.Directories

File.to.Download = 3

Files.Directories[[File.to.Download]]



Data.Files<-list.files(paste0(Main.Directorys[MD],"\\",Files.Directories[[File.to.Download]] , "\\ProcessedData\\")) ;

Data.Files



################################################################################
# 
# 
# The following data sets have the correct date and time
# 
# 20210903_Download1Clover
# 
# 20210903_Download13Spp
# 
# 20210903_Download43Spp
# 
# These can be used as reference to aling the other data sest with the correct date
# 
# 
################################################################################


###################################################
###           B1.Clover - Used as Refference
###################################################


B1.Clover.1 <- read.csv(file = paste0(Main.Directorys[MD],"\\",Files.Directories[[File.to.Download]] , 
                                      
                                      "\\ProcessedData\\", Data.Files[[2]] )) ;


str(B1.Clover.1)


B1.Clover <- B1.Clover.1[B1.Clover.1$Treatment == "Panel" , c("Corrected.TIME" , "Temperature_C")] ;


B1.Clover$index<-seq(1,dim(B1.Clover)[[1]])

str(B1.Clover)


###################################################
###         B3.3sppN
###################################################



B3.3sppN.1 <- read.csv(file = paste0(Main.Directorys[MD],"\\",Files.Directories[[File.to.Download]] 
                                     
                                     , "\\ProcessedData\\", Data.Files[[4]] )) ;

str(B3.3sppN.1)


B3.3sppN <- B3.3sppN.1[B3.3sppN.1$Treatment == "Panel" , c("Corrected.TIME" , "Temperature_C")]


B3.3sppN$index<-seq(1,dim(B3.3sppN)[[1]])




###################################################
###        B3.3sppN  aligned B1.Clover
###################################################



B3.3sppN_B1.Clover <-  dtw(x = B3.3sppN$Temperature_C, 
      
      y = B1.Clover$Temperature_C,
      
      keep=TRUE,step=asymmetric,
      
      open.end=TRUE,open.begin=TRUE)




plot(B3.3sppN_B1.Clover,type="two",off=10)

str(B3.3sppN_B1.Clover)

B3.3sppN_B1.Clover$index1

B3.3sppN_B1.Clover$index2


plot(x = B1.Clover$index , y = B1.Clover$Temperature_C, type = "l" , col = "BLUE"  )

points(x = B3.3sppN$index , y = B3.3sppN$Temperature_C, type = "l" , col = "GREEN"  )


###### Aligned series



B3.3sppN$index.A <- B3.3sppN$index + B3.3sppN_B1.Clover$index2[[1]]-2

points(x = B3.3sppN$index.A , y =B3.3sppN$Temperature_C, type = "l" , col = "RED"  )



######## Correct the time stamp


  
head(B3.3sppN)

head(B1.Clover)



B3.3sppN$Corrected.TIME <- as.POSIXct(B3.3sppN$Corrected.TIME) 

B1.Clover$Corrected.TIME <- as.POSIXct(B1.Clover$Corrected.TIME) 


Time.shift <- as.POSIXct(B1.Clover[B1.Clover$index == 45 , c("Corrected.TIME")]) -  
  as.POSIXct(B3.3sppN[B3.3sppN$index == 1 , c("Corrected.TIME")])


B3.3sppN$True.Time<-as.POSIXct(B3.3sppN$Corrected.TIME) + Time.shift



######## check Correct the time stamp ##########################################



plot(x = B3.3sppN$True.Time , y = B3.3sppN$Temperature_C, type = "l" , col = "BLUE")

points(x = B1.Clover$Corrected.TIME, B1.Clover$Temperature_C, type = "l" ,  col = "RED")



######## Write the time aligned data series in the corrected file ##############


str(B3.3sppN.1)

B3.3sppN.1$True.Time <- as.POSIXct(B3.3sppN.1$Corrected.TIME)   + Time.shift

B3.3sppN.write <- B3.3sppN.1[, c( "Corrected.TIME" , "Block" , "C_Crop" , "Treatment" , "Depth_cm" , "Temperature_C", "Calibrated.O2_Kpa") ] ;

B3.3sppN.write$Corrected.TIME <- B3.3sppN.1$True.Time ;


str(B3.3sppN.write)


write.csv( x = B3.3sppN.write,
           
           file = paste0(Main.Directorys[MD],"\\",Files.Directories[[File.to.Download]] , "\\ProcessedData\\", Data.Files[[4]] ),
           
           quote = F, row.names=F)  ;



###################################################
###         B3.Triticale
###################################################



B3.Triticale.1 <- read.csv(file = paste0(Main.Directorys[MD],"\\",Files.Directories[[File.to.Download]] 
                                         
                                         , "\\ProcessedData\\", Data.Files[[6]] )) ;

str(B3.Triticale.1)


B3.Triticale <- B3.Triticale.1[B3.Triticale.1$Treatment == "Panel" , c("Corrected.TIME" , "Temperature_C")]


B3.Triticale$index<-seq(1,dim(B3.Triticale)[[1]])

str(B3.Triticale)


###################################################
###        B3.Triticale  aligned B1.Clover
###################################################



B3.Triticale_B1.Clover <-  dtw(x = B3.Triticale$Temperature_C, 
                           
                           y = B1.Clover$Temperature_C,
                           
                           keep=TRUE,step=asymmetric,
                           
                           open.end=TRUE,open.begin=TRUE)




plot(B3.Triticale_B1.Clover,type="two",off=10)

str(B3.Triticale_B1.Clover)

B3.Triticale_B1.Clover$index1

B3.Triticale_B1.Clover$index2


plot(x = B1.Clover$index , y = B1.Clover$Temperature_C, type = "l" , col = "BLUE"  )

points(x = B3.Triticale$index , y = B3.Triticale$Temperature_C, type = "l" , col = "GREEN"  )



######  Aligned series #########################################################



B3.Triticale$index.A <- B3.Triticale$index + B3.Triticale_B1.Clover$index2[[1]]-5

points(x = B3.Triticale$index.A , y =B3.Triticale$Temperature_C, type = "l" , col = "RED"  )


######## Correct the time stamp ################################################

head(B3.Triticale)

head(B1.Clover)



B3.Triticale$Corrected.TIME <- as.POSIXct(B3.Triticale$Corrected.TIME) 

B1.Clover$Corrected.TIME <- as.POSIXct(B1.Clover$Corrected.TIME) 


Time.shift <- as.POSIXct(B1.Clover[B3.Triticale$index.A [[1]] , c("Corrected.TIME")]) -  
  as.POSIXct(B3.Triticale[B3.Triticale$index [[1]] , c("Corrected.TIME")])


B3.Triticale$True.Time<-as.POSIXct(B3.Triticale$Corrected.TIME) + Time.shift



######## check Correct the time stamp ##########################################


plot(x = B3.Triticale$True.Time , y = B3.Triticale$Temperature_C, type = "l" , col = "BLUE")

points(x = B1.Clover$Corrected.TIME, B1.Clover$Temperature_C, type = "l" ,  col = "RED")




######## Write the time aligned data series in the corrected file ##############


str(B3.Triticale.1)

B3.Triticale.1$True.Time <- as.POSIXct(B3.Triticale.1$Corrected.TIME)  + Time.shift

B3.Triticale.write <- B3.Triticale.1[, c( "Corrected.TIME" , "Block" , "C_Crop" , "Treatment" , "Depth_cm" , "Temperature_C", "Calibrated.O2_Kpa") ] ;

B3.Triticale.write$Corrected.TIME <- B3.Triticale.1$True.Time ;


str(B3.Triticale.write)


write.csv( x = B3.Triticale.write,
           
           file = paste0(Main.Directorys[MD],"\\",Files.Directories[[File.to.Download]] , "\\ProcessedData\\", Data.Files[[6]] ),
           
           quote = F, row.names=F)  ;






###################################################
###         B4.Clover
###################################################



B4.Clover.1 <- read.csv(file = paste0(Main.Directorys[MD],"\\",Files.Directories[[File.to.Download]] 
                                      
                                      , "\\ProcessedData\\", Data.Files[[10]] )) ;

str(B4.Clover.1)


B4.Clover <- B4.Clover.1[B4.Clover.1$Treatment == "Panel" , c("Corrected.TIME" , "Temperature_C")]


B4.Clover$index<-seq(1,dim(B4.Clover)[[1]])

str(B4.Clover)


###################################################
###        B4.Clover  aligned B1.Clover
###################################################



B4.Clover_B1.Clover <-  dtw(x = B4.Clover$Temperature_C, 
                               
                               y = B1.Clover$Temperature_C,
                               
                               keep=TRUE,step=asymmetric,
                               
                               open.end=TRUE,open.begin=TRUE)




plot(B4.Clover_B1.Clover,type="two",off=10)

str(B4.Clover_B1.Clover)

B4.Clover_B1.Clover$index1

B4.Clover_B1.Clover$index2


plot(x = B1.Clover$index , y = B1.Clover$Temperature_C, type = "l" , col = "BLUE"  )

points(x = B4.Clover$index , y = B4.Clover$Temperature_C, type = "l" , col = "GREEN"  )

###### Aligned series

B4.Clover$index.A <- B4.Clover$index + B4.Clover_B1.Clover$index2[[1]]-2

points(x = B4.Clover$index.A , y =B4.Clover$Temperature_C, type = "l" , col = "RED"  )


######## Correct the time stamp

head(B4.Clover)

head(B1.Clover)



B4.Clover$Corrected.TIME <- as.POSIXct(B4.Clover$Corrected.TIME) 

B1.Clover$Corrected.TIME <- as.POSIXct(B1.Clover$Corrected.TIME) 


Time.shift <- as.POSIXct(B1.Clover[B4.Clover$index.A [[1]] , c("Corrected.TIME")]) -  
  as.POSIXct(B4.Clover[B4.Clover$index [[1]] , c("Corrected.TIME")])


B4.Clover$True.Time<-as.POSIXct(B4.Clover$Corrected.TIME) + Time.shift



######## check Correct the time stamp 

plot(x = B4.Clover$True.Time , y = B4.Clover$Temperature_C, type = "l" , col = "BLUE")

points(x = B1.Clover$Corrected.TIME, B1.Clover$Temperature_C, type = "l" ,  col = "RED")




######## Write the time aligned data series in the corrected file ##############


str(B4.Clover.1)

B4.Clover.1$True.Time <- as.POSIXct(B4.Clover.1$Corrected.TIME)  + Time.shift

B4.Clover.write <- B4.Clover.1[, c( "Corrected.TIME" , "Block" , "C_Crop" , "Treatment" , "Depth_cm" , "Temperature_C", "Calibrated.O2_Kpa") ] ;


B4.Clover.write$Corrected.TIME <- B4.Clover.1$True.Time ;


str(B4.Clover.write)


write.csv( x = B4.Clover.write,
           
           file = paste0(Main.Directorys[MD],"\\",Files.Directories[[File.to.Download]] , "\\ProcessedData\\", Data.Files[[10]] ),
           
           quote = F, row.names=F)  ;







###################################################
###         B4.Triticale
###################################################



B4.Triticale.1 <- read.csv(file = paste0(Main.Directorys[MD],"\\",Files.Directories[[File.to.Download]] 
                                         
                                         , "\\ProcessedData\\", Data.Files[[12]] )) ;


str(B4.Triticale.1)


B4.Triticale <- B4.Triticale.1[B4.Triticale.1$Treatment == "Panel" , c("Corrected.TIME" , "Temperature_C")]


B4.Triticale$index<-seq(1,dim(B4.Triticale)[[1]])

str(B4.Triticale)


###################################################
###        B4.Triticale  aligned B1.Clover
###################################################



B4.Triticale_B1.Clover <-  dtw(x = B4.Triticale$Temperature_C, 
                            
                            y = B1.Clover$Temperature_C,
                            
                            keep=TRUE,step=asymmetric,
                            
                            open.end=TRUE,open.begin=TRUE)




plot(B4.Triticale_B1.Clover,type="two",off=10)

str(B4.Triticale_B1.Clover)

B4.Triticale_B1.Clover$index1

B4.Triticale_B1.Clover$index2


plot(x = B1.Clover$index , y = B1.Clover$Temperature_C, type = "l" , col = "BLUE"  )

points(x = B4.Triticale$index , y = B4.Triticale$Temperature_C, type = "l" , col = "GREEN"  )

###### Aligned series

B4.Triticale$index.A <- B4.Triticale$index + B4.Triticale_B1.Clover$index2[[1]]-1

points(x = B4.Triticale$index.A , y =B4.Triticale$Temperature_C, type = "l" , col = "RED"  )


######## Correct the time stamp

head(B4.Triticale)

head(B1.Clover)



B4.Triticale$Corrected.TIME <- as.POSIXct(B4.Triticale$Corrected.TIME) 

B1.Clover$Corrected.TIME <- as.POSIXct(B1.Clover$Corrected.TIME) 


Time.shift <- as.POSIXct(B1.Clover[B4.Triticale$index.A [[1]] , c("Corrected.TIME")]) -  
  as.POSIXct(B4.Triticale[B4.Triticale$index [[1]] , c("Corrected.TIME")])


B4.Triticale$True.Time<-as.POSIXct(B4.Triticale$Corrected.TIME) + Time.shift - (60*60)



######## check Correct the time stamp 

plot(x = B4.Triticale$True.Time , y = B4.Triticale$Temperature_C, type = "l" , col = "BLUE")

points(x = B1.Clover$Corrected.TIME, B1.Clover$Temperature_C, type = "l" ,  col = "RED")


######## Write the time aligned data series in the corrected file ##############


str(B4.Triticale.1)

B4.Triticale.1$True.Time <- as.POSIXct(B4.Triticale.1$Corrected.TIME)  + Time.shift - (60*60)

B4.Triticale.write <- B4.Triticale.1[, c( "Corrected.TIME" , "Block" , "C_Crop" , "Treatment" , "Depth_cm" , "Temperature_C", "Calibrated.O2_Kpa") ] ;

B4.Triticale.write$Corrected.TIME <- B4.Triticale.1$True.Time ;


str(B4.Triticale.write)


write.csv( x = B4.Triticale.write,
           
           file = paste0(Main.Directorys[MD],"\\",Files.Directories[[File.to.Download]] , "\\ProcessedData\\", Data.Files[[12]] ),
           
           quote = F, row.names=F)  ;








