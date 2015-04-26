#install.packages("jsonlite")
#install.packages("curl")
library(jsonlite)
library(curl)
setwd("C:/Users/Benjamin/Desktop/DC Stuff/walkscore_api_json_converstion
")

dc_lib <- read.csv("dc_libraries.csv")
dc_lib$unique_id <- paste0(dc_lib$FSCSKEY,dc_lib$FSCS_SEQ)

test <- data.frame()
for (i in unique(dc_lib$unique_id)){
	lib_id <- subset(dc_lib,unique_id==i)
	lat <- lib_id$LATITUDE[1]
	lon <- lib_id$LONGITUDE[1]
	address <- lib_id$ADDRESS[1]
	city <- lib_id$CITY[1]
	zip <- lib_id$ZIP[1]
	county <- lib_id$CNTY[1]
	lib_name <- lib_id$LIBNAME[1]

	ws <- as.data.frame(fromJSON(paste0("http://api.walkscore.com/score?format=json&lat=",a$snapped_lat,"&lon=",a$snapped_lon,"&wsapikey=<INSERT KEY HERE>")))
	
	walkscore <- ws$walkscore
	description <- ws$description

	new_row <- cbind(lat,lon,address,city,zip,county,lib_name,walkscore,description)
	test <- rbind(test,new_row)
}