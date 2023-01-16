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
#                             Tell the program where the package libraries are stored                        
###############################################################################################################


#  Tell the program where the package libraries are  #####################

#.libPaths("C:/Felipe/SotwareANDCoding/R_Library/library")  ;


###############################################################################################################
#                             Setting up working directory  Loading Packages and Setting up working directory                        
###############################################################################################################


#      set the working directory

# readClipboard() Willow Rock Spring\\SkyCap_SelectionTrial\\DataCollection") ;   # 

"https://pennstateoffice365.sharepoint.com/:f:/s/StrategicTillageAndN2O/Ehl9Lh_gza5FiOtKIyDD7MQBOKFdFk6h_k4EEYEktWJUYw?e=uYLqL0"

setwd("D:\\Felipe\\CCC Based Experiments\\StrategicTillage_NitrogenLosses_OrganicCoverCrops\\Data\\Oxygen") ;

###############################################################################################################
#                            Install the packages that are needed                       
###############################################################################################################

install.packages("openxlxs", dependencies = T)

# 
# install.packages("magick", dependencies = T)
# 
# install.packages("jpeg", dependencies = T)
# 
# install.packages("Rcpp", dependencies = T)


###############################################################################################################
#                           load the libraries that are needed   
###############################################################################################################

library(openxlsx)

# library(lattice)
# 
# library(jpeg)
# 
# library(magick)



###############################################################################################################
#                           Explore the files and directory and files with the data from Felipe's Downloads
###############################################################################################################
### Read the Directories, files and data from the download directory where the GC data are stored

CampbellSci.files<-c("CR1000NEW_DataTableInfo.dat" , "CR1000NEW_Oxygen.dat" ,       "CR1000NEW_Public.dat"  ,      "CR1000NEW_Status.dat" ) ;


Directory.List.Locations<-list.files("./OxygenSensorsData2022");


O2.Data.1<-read.csv(paste0("./OxygenSensorsData2022\\",Directory.List.Locations[[1]],"\\",CampbellSci.files[[2]] ), header=F, skip=4) ;


names(O2.Data.1)<-read.csv(paste0("./OxygenSensorsData2022\\",Directory.List.Locations[[1]],"\\",CampbellSci.files[[2]] ), header=F, skip=1,nrows=1) ;

head(O2.Data.1) 

 tail(O2.Data.1)

### correct the time stamp fo the date and format it into a POSIXct Time-Date 


O2.Data.1$TIME<-as.POSIXct(O2.Data.1$TIMESTAMP) ;
length(O2.Data.1$TIME)

### The first records have worng the date 1999

O2.Data.1$Inverse.Record.No<-seq.int(from=(length(O2.Data.1$TIME)),to=1) ;

O2.Data.1$Corrected.TIME<-O2.Data.1$TIME[length(O2.Data.1$TIME)]-(O2.Data.1$Inverse.Record.No*30*60) ;

### Reshape the data from a wide format where block and treatments are in separate columns to one in which all are in the same column with separate rows

O2.Data<-O2.Data.1[1:6] ;

head(O2.Data);

O2.Data$Block.Treat<-names(O2.Data)[5]


names(O2.Data)[c(5,6)]<-c("O2.conc", "Temp.C") ;

head(O2.Data)

O2.Data.1[c(1,2,3,4,7,8)] 


###############################################################################################################
#                           Explore the files and directory and files with the data from Alli's downloads
###############################################################################################################





  

#### read precipitation data from https://wcc.sc.egov.usda.gov/nwcc/site?sitenum=2036

Precipitation<-read.csv("C:\\Users\\frm10\\Downloads\\2036_18_YEAR=2021.csv" , header= T, skip=3)


str(Precipitation)


  
Precipitation$Date.Time<-as.POSIXct(paste0(Precipitation$Date," ", Precipitation$Time),format="%Y-%m-%d %H:%M");

Pcp.range<-range(Precipitation[which(Precipitation$Date.Time>=min(O2.Data.Alli.data$TIME) & Precipitation$Date.Time<=max(O2.Data.Alli.data$TIME)),c("PRCP.H.1..in.")])



DateTime.range<-as.Date(range(O2.Data.Alli.data$TIME)) ;

O2.range<-range(O2.Data.Alli.data$B1CloverA5cmO2_Med)

#####  Start plotting

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





