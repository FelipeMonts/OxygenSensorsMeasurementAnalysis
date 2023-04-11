##############################################################################################################
# 
# 
# Program to process weather data from stations around state College
# 

# University Park Airport AWOS weather station 
# # 
#    USAF-WBAN_ID STATION NAME                   COUNTRY                                            STATE 			      LATITUDE LONGITUDE ELEVATION
# ------------ ------------------------------ -------------------------------------------------- ------------------------------ -------- --------- ---------
#  725128 54739 UNIVERSITY PARK AIRPORT        UNITED STATES                                      PENNSYLVANIA                    +40.850  -077.850   +0377.7
# 
# 
# 
# NRCS Station at Rock Springs  station No 2036 
#------------ ------------------------------ -------------------------------------------------- 
#   
#   https://wcc.sc.egov.usda.gov/nwcc/site?sitenum=2036
# 
#   https://wcc.sc.egov.usda.gov/reportGenerator/
# 
# 
#  NOAA WBAN station at Rock Springs  
# ------------ ------------------------------ --------------------------------------------------
#   https://www.ncei.noaa.gov › cdo-web
# 
# 
# 
# #  Felipe Montes 2023/04/10
# 
# 
# 
# 
############################################################################################################### 


###############################################################################################################
#                             Setting up working directory  Loading Packages and Setting up working directory                        
###############################################################################################################


#      set the working directory

# C:\Users\frm10\Downloads\Weather data

setwd("C:\\Users\\frm10\\Downloads\\Weather data") ;  



###############################################################################################################
#                            Install the packages that are needed                       
###############################################################################################################


# Install the packages that are needed #

# install.packages('fields', dep=T)

# install.packages('LatticeKrig', dep=T)

# install.packages('rgeos', dep=T)

# install.packages('RColorBrewer', dep=T)

# install.packages('rgdal', dep=T)

# install.packages('sp', dep=T)

# install.packages('raster', dep=T)

# install.packages('openxlsx', dep=T)

# install.packages('openxlsx', dep=T)


# install.packages('lattice', dep=T)

# install.packages('stringi', dep=T)

# install.packages('rgl', dep=T)

# install_github('sorhawell/forestFloor')

# install.packages('nlme', dep=T)

# install.packages('nlme', dep=T)

###############################################################################################################
#                           load the libraries that are neded   
###############################################################################################################
# 
# 
# 
# library(RColorBrewer)
# 
# library(openxlsx)
# 
# library(lattice)
# 
# library(devtools)
# 
# # library(forestFloor)
# 
# # library(rgl)
# 
# # library(raster)
# # 
# # library(nlme)
# 


###############################################################################################################
#                        University Park Airport AWOS weather station
###############################################################################################################



###############################################################################################################
#      Read the data from the text files downloaded from University Park Airport AWOS weather station
###############################################################################################################

University.Park.Weather.1<-read.table(file='6094568232309dat.txt', header=T, as.is=T, na.strings = c("*","**","***","****","*****" )) ;


#   str(University.Park.Weather.1) ; View(University.Park.Weather.1)


### convert YR..MODAHRMN to .POSIXct date time format

University.Park.Weather.1$Date.Time<-as.POSIXct(as.character(University.Park.Weather.1$YR..MODAHRMN), tz = "", format=c("%Y%m%d%H%M")) ;

### Aggregate  the data by months to plot 

University.Park.Weather.1$Year.Month<-as.factor(as.character(format(University.Park.Weather.1$Date.Time, "%Y_%m")))


University.Park.Temp<-aggregate(TEMP~Year.Month, University.Park.Weather.1,FUN=mean ) ;

University.Park.Temp<-merge(University.Park.Temp, aggregate(MAX~Year.Month, University.Park.Weather.1,FUN=max ), by=c("Year.Month"), all=T)  ;

University.Park.Temp<-merge(University.Park.Temp, aggregate(MIN ~ Year.Month, University.Park.Weather.1,FUN=min ), by=c("Year.Month"), all=T)  ;

University.Park.Temp<-merge(University.Park.Temp, aggregate(PCP01~Year.Month, University.Park.Weather.1,FUN=sum ), by=c("Year.Month"), all=T)  ;

University.Park.Temp.Pcp<-University.Park.Temp ;

University.Park.Temp.Pcp[is.na(University.Park.Temp.Pcp$PCP01),c('PCP01')]<-0 ;


###############################################################################################################
#
#                           Transform the data to SI units
#
#                 https://www.nist.gov/pml/weights-and-measures/si-units
#                  https://www.nist.gov/pml/special-publication-330
#
###############################################################################################################



###### Transform the data to SI units #########

# View(University.Park.Temp.Pcp)  ; str(University.Park.Temp.Pcp)


University.Park.Temp.Pcp$TEMP_C<-(University.Park.Temp.Pcp$TEMP-32)/1.8 ;

University.Park.Temp.Pcp$MAX_C<-(University.Park.Temp.Pcp$MAX-32)/1.8  ;

University.Park.Temp.Pcp$MIN_C<-(University.Park.Temp.Pcp$MIN-32)/1.8   ;

University.Park.Temp.Pcp$PCP_MM<-University.Park.Temp.Pcp$PCP01*25.4  ;

###############################################################################################################
#                           Read the data from the text files
#    
#    Plot the Hyetograph together with the temperature using the R Water Module 3
#           https://web.ics.purdue.edu/~vmerwade/rwater.html
#
#
###############################################################################################################


###### set the graphical parameters right for creating the hyetograph

#There are a lof of NA values in the data set

University.Park.Temp.Pcp[is.na(University.Park.Temp.Pcp$PCP01),] ;

# Return the Year.Month to a date form of POSIXct class

University.Park.Temp.Pcp$Date.Year.Month<-as.Date(paste0(as.character(University.Park.Temp.Pcp$Year.Month),"_1"),format="%Y_%m_%d")


# mar :A numerical vector of the form c(bottom, left, top, right) which gives the number of lines of margin to be specified on the four sides of the plot. The default is c(5, 4, 4, 2) + 0.1.




# find the range of values to be plotted

Pcp.range<-range(University.Park.Temp.Pcp$PCP_MM) ; 

Temp.range<-range(range(University.Park.Temp.Pcp[,c('TEMP_C')]),range(University.Park.Temp.Pcp[!is.na(University.Park.Temp.Pcp$MAX_C),c('MAX_C')]), range(University.Park.Temp.Pcp[!is.na(University.Park.Temp.Pcp$MIN_C),c('MIN_C')])) ; 


DateTime.range<-range(University.Park.Weather.1[!is.na(University.Park.Weather.1$Date.Time),"Date.Time"]);

### adding a year to make the axis better

DateTime.range.2<-DateTime.range ;

DateTime.range.2[2]<-as.Date(DateTime.range[2])+365


##### Create the graphics in EPS Postscript format ######

postscript(file="..\\Agronomy Journal\\JournalResponse20201117\\AceptedVersion20210105\\Figure1Weather.eps" , onefile=F, width=8, height=4, paper= "letter", family='Times')


par(mar=c(3,5,1,4)+0.1);


#  plot the pcp
plot(University.Park.Temp.Pcp$Date.Year.Month, University.Park.Temp.Pcp$PCP_MM, type="h",yaxt="n",xaxt="n", ylim=rev(c(0,4*Pcp.range[2])), bty="n", main="University Park Airport",col="light blue",ylab=NA,xlab=NA, lwd=3, font.main=2,cex.main=1.5);

# add axis with proper labeling

axis(side = 3, pos = 0, tck = 0,xaxt = "n") ;
axis(side = 4, at = pretty(seq(0, floor(Pcp.range[2] + 1),length=c(5))),labels=pretty(seq(0, floor(Pcp.range[2] + 1),length=c(5))), font=2, cex.axis=1.1) ;
mtext(side=4,"Precipitation mm",line = 2, cex = 1.3, adj = 0.95, font=2) ;

#add Temp  plot
par(new=T);

par(mar=c(5.1, 4.1, 4.1 ,2.1))

plot(University.Park.Temp.Pcp$Date.Year.Month,University.Park.Temp.Pcp$TEMP_C, type='l',col="BLACK",axes=F, yaxt='n', ylab="Temperature ?C",xlab="Date", ylim =c(-25,40),font.lab=2,cex.lab=1.3,cex.axis=1.1);

#coordinates for the Temp max min polygon

#  View(University.Park.Temp.Pcp) ; str(University.Park.Temp.Pcp)  ; names(University.Park.Temp.Pcp)

Polygon.coords<-University.Park.Temp.Pcp[seq(7,96),c("TEMP_C" , "MAX_C" , "MIN_C" , "PCP_MM", "Date.Year.Month")] ;

Polygon.coords[1,c("MAX_C", "MIN_C")]<-(Temp.range[1]+Temp.range[2])/2 ;

polygon(x=c(Polygon.coords$Date.Year.Month, rev(Polygon.coords$Date.Year.Month)), y=c(Polygon.coords$MAX,rev(Polygon.coords$MIN)),col="GRAY")


#add axis with appropriate labels
axis.Date(side=1, at=seq(DateTime.range[1],DateTime.range.2[2],by='year'), font=2, cex.axis=1.2) 

#axis.POSIXct(side=1,University.Park.Temp.Pcp$Date.Year.Month, at=seq(DateTime.range[1],DateTime.range[2],length.out=5),labels=format(seq(DateTime.range[1],DateTime.range[2],length.out=5),"%Y")) ;
axis(side=2,at=pretty(seq(-25,40,length=15)), font=2, cex.axis=1.2) ;


#add aditional flow data 
lines(University.Park.Temp.Pcp$Date.Year.Month,University.Park.Temp.Pcp$TEMP_C, col="BLACK")

lines(University.Park.Temp.Pcp$Date.Year.Month,University.Park.Temp.Pcp$MAX_C, col="RED")

lines(University.Park.Temp.Pcp$Date.Year.Month,University.Park.Temp.Pcp$MIN_C, col="BLUE")


invisible(dev.off())

###############################################################################################################
#                       NRCS Station at Rock Springs  station No 2036 
###############################################################################################################

RockSrpings.NRCS.1<-read.csv(file = "RockSprings2036_2020_2023.csv", skip = 68,  header = T)

head(RockSrpings.NRCS.1)

str(RockSrpings.NRCS.1)

names(RockSrpings.NRCS.1)


################################################################################################################ 
# Convert Date into POSIXct format
################################################################################################################   

head(RockSrpings.NRCS.1$Date, 50)


RockSrpings.NRCS.1$Date.Time <- as.POSIXct(x = as.character(RockSrpings.NRCS.1$Date),format = "%Y-%m-%d %H:%M")


################################################################################################################ 
# Remove the station name from the column names
################################################################################################################   

str(RockSrpings.NRCS.1)

names(RockSrpings.NRCS.1)[2:(length(names(RockSrpings.NRCS.1))-1)] <- substring( text = names(RockSrpings.NRCS.1)[2:(length(names(RockSrpings.NRCS.1))-1)], first = 24)  ;

################################################################################################################ 
# Check Precipt.Data
################################################################################################################   


plot(Precipitation.Increment..in. ~ Date.Time, type = "h", data = RockSrpings.NRCS.1, col = "BLUE")



plot(Precipitation.Accumulation..in. ~ Date.Time, type = "l", data = RockSrpings.NRCS.1 [!is.na(RockSrpings.NRCS.1$Precipitation.Accumulation..in.),], col = "RED")


################################################################################################################ 
# Check soil Moisture Data
################################################################################################################ 
str(RockSrpings.NRCS.1)


plot(Soil.Moisture.Percent..2in..pct. ~ Date.Time, type = "l", data = RockSrpings.NRCS.1, col = "BLUE4")

points(Soil.Moisture.Percent..4in..pct. ~ Date.Time, type = "l", data = RockSrpings.NRCS.1, col = "BLUE3")

points(Soil.Moisture.Percent..8in..pct. ~ Date.Time, type = "l", data = RockSrpings.NRCS.1, col = "BLUE2")

points(Soil.Moisture.Percent..20in..pct. ~ Date.Time, type = "l", data = RockSrpings.NRCS.1, col = "BLUE1")

points(Soil.Moisture.Percent..40in..pct. ~ Date.Time, type = "l", data = RockSrpings.NRCS.1, col = "BLUE")


################################################################################################################ 
# Check soil Moisture Data
################################################################################################################ 
str(RockSrpings.NRCS.1)

plot(Soil.Temperature.Observed..2in..degF. ~ Date.Time, type = "l", data = RockSrpings.NRCS.1, col = "RED4")

points(Soil.Temperature.Observed..4in..degF. ~ Date.Time, type = "l", data = RockSrpings.NRCS.1, col = "RED3")

points(Soil.Temperature.Observed..8in..degF. ~ Date.Time, type = "l", data = RockSrpings.NRCS.1, col = "RED2")

points(Soil.Temperature.Observed..20in..degF. ~ Date.Time, type = "l", data = RockSrpings.NRCS.1, col = "RED1")

points(Soil.Temperature.Observed..40in..degF. ~ Date.Time, type = "l", data = RockSrpings.NRCS.1, col = "RED")

