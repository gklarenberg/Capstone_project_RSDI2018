# Geraldine Klarenberg
# University of Florida
# June 2018

# This script serves to extract data from the NEON website. It also creates the folders to
# store the data, merges all monthly data into 1 data set and gets rid of all the original 
# zipped and unzipped files that were downloaded.
# The location for which data is required can be specified/changed in the script.
# There is a package to extract NEON data that will be employed here. This needs to be downloaded 
# the Github repo. Explanation: https://www.neonscience.org/neonDataStackR

rm(list=ls(all=TRUE))

# You need the package 'devtools' to install from Github.
# install.packages("devtools")
# load devtools
library(devtools)
# install neonUtilities from GitHub
#install_github("NEONScience/NEON-utilities/neonUtilities", dependencies=TRUE)
# load neonUtilities
library(neonUtilities)

################ Download the data  and stack it - per site ################

# To download the files, you need to know the product ID
# Woody plant vegetation structure: DP1.10098.001
# Plant presence and percent cover: DP1.10058.001
# Plant phenology: DP1.10055.001
# Phenology images: DP1.00033.001
# Understory phenology: DP1.00042.001
# This script does not download LiDAR or other airborne observations. That is dealt with in a
# different script
# You also need to indicate the locations for which data needs to be downloaded. We are interested
# in the Ordway Swisher Biological Station (FL), Disney Wildlife Preserve (FL) and Jones 
# Ecological Research Center (GA) data, all southeast domain
# The code is: GUAN

# you have to download each site separately, and then process the data and remove the folder
# that is created during the download, before downloading for another site. The download
# always creates a folder with the same name (the product ID) which causes trouble if you try to 
# download the same product for different sites

# create a folders to save the data in
site_list <- c("GUAN")
for(i in site_list){
  dir.create(paste("Data/Veg_structure/",i,sep=""))
}

# Make a loop to download everything you need. This might take a while, depending on what you download
product_list <- c("DP1.10098.001","DP1.10058.001","DP1.10055.001","DP1.00033.001","DP1.00042.001")

for(i in site_list){
  for(j in product_list){
    # check if the data exists, and if not, skip this loop 
    download_test<-try(zipsByProduct(dpID=j, site=i,check.size=FALSE,
                                    savepath=paste(getwd(),"/Data/Veg_structure/",i,"/",sep="")),
                                    silent=TRUE)
    if ('try-error' %in% class(download_test)) next
  }
}

# You now have lots of folders with zipped files, for each month. Put them together
# Even though this script is contained in an Rproject, which set the working directory, the following 
# command still needs a full path - which is why getwd() is pasted together with the folder name 
for(i in site_list){
  # Make a list of all the folders with data
  all_folders <- list.files(path = paste(getwd(),"/Data/Veg_structure/",i,sep=""), pattern = "filesToStack*")
  # The following command combines all the data. It stays within the "filesToStack####" file, but
  # all zipped files are removed
  # first create a new directory for all the new data
  dir.create(paste(getwd(),"/Data/Veg_structure/",i,"/all_data",sep=""))
  for(p in all_folders){
    stackByTable(filepath=paste(getwd(),"/Data/Veg_structure/",i,"/",p,sep=""), savepath = paste(getwd(),"/Data/Veg_structure/",i,"/all_data",sep=""), folder = TRUE)
    # since the stackByTable fucntion creates a folder "stackedFiles" and then removes the zipped files,
    # you have to create a separate folder to put the stacked data in. There are now a bunch of empty
    # folder you need to get rid of
    unlink(paste(getwd(),"/Data/Veg_structure/",i,"/",p,sep=""),recursive=TRUE)
  }
  # the new data also sits two folders deep. Move it up to the 'all_data' folder
  file.copy(from = paste(getwd(),"/Data/Veg_structure/",i,"/all_data/stackedFiles",sep=""), 
            to = paste(getwd(),"/Data/Veg_structure/",i,sep=""), 
            recursive = TRUE, overwrite=TRUE)
  
  # now remove the older (deeper) folder
  unlink(paste(getwd(),"/Data/Veg_structure/",i,"/all_data/stackedFiles",sep=""), recursive=TRUE)
  unlink(paste(getwd(),"/Data/Veg_structure/",i,"/all_data",sep=""), recursive=TRUE)
  file.rename(from = paste(getwd(),"/Data/Veg_structure/",i,"/stackedFiles",sep=""), 
              to = paste(getwd(),"/Data/Veg_structure/",i,"/all_data",sep=""))
}

# All the data now sits in the folder:
# "Data/Veg_structure/GUAN/all_data"



