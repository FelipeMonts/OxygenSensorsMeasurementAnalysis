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


#      set the working directory

# readClipboard()

setwd("‪C:\\Users\\frm10\\Downloads") ;



###############################################################################################################
#                            Install the packages that are needed                       
###############################################################################################################


install.packages("dtw", dependencies = T )



###############################################################################################################
#                           load the libraries that are needed   
###############################################################################################################

library("dtw")



###############################################################################################################
#                           Working on the examples
###############################################################################################################


data("aami3a")

ref <- window(aami3a, start = 0, end = 2)

test <- window(aami3a, start = 2.7, end = 5)

alignment <- dtw(test, ref)

alignment$distance

symmetric2


