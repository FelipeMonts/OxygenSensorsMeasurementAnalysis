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
# 
############################################################################################################### 



###############################################################################################################
#                             Tell the program where the package libraries are stored                        
###############################################################################################################


#  Tell the program where the package libraries are  #####################

.libPaths("C:/Felipe/SotwareANDCoding/R_Library/library")  ;


###############################################################################################################
#                             Setting up working directory  Loading Packages and Setting up working directory                        
###############################################################################################################


#      set the working directory

# readClipboard() Willow Rock Spring\\SkyCap_SelectionTrial\\DataCollection") ;   # 

"https://pennstateoffice365.sharepoint.com/:f:/s/StrategicTillageAndN2O/Ehl9Lh_gza5FiOtKIyDD7MQBOKFdFk6h_k4EEYEktWJUYw?e=uYLqL0"

#setwd("C:\\Felipe\\Willow_Project\\Willow_Experiments\\

###############################################################################################################
#                            Install the packages that are needed                       
###############################################################################################################
install.packages("magick", dependencies = T)

install.packages("jpeg", dependencies = T)

install.packages("Rcpp", dependencies = T)


###############################################################################################################
#                           load the libraries that are needed   
###############################################################################################################

library(openxlsx)

library(lattice)

library(jpeg)

library(magick)



###############################################################################################################
#                           Explore the files and directory and files with the data from Felipe's Downloads
###############################################################################################################
### Read the Directories where the GC data are stored

DownloadDate = "20210903Download"  ;

O2.Directory ="B1Clover" ;

CampbellSci.files<-c("CR1000_DataTableInfo.dat" , "CR1000_Oxygen.dat" ,       "CR1000_Public.dat"  ,      "CR1000_Status.dat" ) ;


Directory.List<-list.files(paste0("C:\\Users\\frm10\\The Pennsylvania State University\\StrategicTillageAndN2O - Documents\\Data\\O2Sensors\\", DownloadDate , "\\", O2.Directory));

O2.Data.1.Names<-read.csv(paste0("C:\\Users\\frm10\\The Pennsylvania State University\\StrategicTillageAndN2O - Documents\\Data\\O2Sensors\\20210825Download\\",O2.Directory, "\\",CampbellSci.files[2] ), header=F, skip=1, nrows=1)

O2.Data.1<-read.csv(paste0("C:\\Users\\frm10\\The Pennsylvania State University\\StrategicTillageAndN2O - Documents\\Data\\O2Sensors\\20210825Download\\",O2.Directory, "\\",CampbellSci.files[2] ), header=F, skip=4, nrows=-1) ;

names(O2.Data.1)<-O2.Data.1.Names[1,] ;

str(O2.Data.1)

### Prepare a detailed and well formatted data frame for data analysis and exploration

O2.Data.1$TIME<-as.POSIXct(O2.Data.1$TIMESTAMP) ;



###############################################################################################################
#                           Explore the files and directory and files with the data from Alli's downloads
###############################################################################################################

### Read the data from Alli's downloads

O2.Data.Alli.names<-read.csv("09172021B1Clover.dat", skip=1, header=T, nrows=1);

O2.Data.Alli.data<-read.csv("09172021B1Clover.dat", skip=4, header=F);


names(O2.Data.Alli.data)<-names(O2.Data.Alli.names)


str(O2.Data.Alli.data)

### Prepare a detailed and well formatted data frame for data analysis and exploration

O2.Data.Alli.data$TIME<-as.POSIXct(O2.Data.Alli.data$TIMESTAMP) ;






#### Read picture of the O2 Sensor Installed
  


O2Picture<-readJPEG(paste0("C:\\Users\\frm10\\The Pennsylvania State University\\StrategicTillageAndN2O - Documents\\Pictures\\Pictures_O2Sensors_20210927\\IMG_0073.JPG")) ;


O2Picture2<-image_read(paste0("C:\\Users\\frm10\\The Pennsylvania State University\\StrategicTillageAndN2O - Documents\\Pictures\\Pictures_O2Sensors_20210927\\IMG_0073.JPG")) ;

O2Picture3<-image_rotate(O2Picture2, -90);


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





