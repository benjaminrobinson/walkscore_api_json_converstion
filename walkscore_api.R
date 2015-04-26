#install.packages("jsonlite")
library(jsonlite)
library(ggmap)
setwd("C:/Users/Benjamin/Desktop/DC Stuff/walkscore_api_json_converstion")

us_lib <- read.csv("us_libraries.csv",stringsAsFactors=FALSE)
dc_lib <- us_lib[which(us_lib$STABR=='DC'),]
cin_lib <- us_lib[which(us_lib$CITY=='CINCINNATI'),]

##CHUNK 5000 address per file
ws_1 <- us_lib[1:5000,]
ws_2 <- us_lib[5001:10000,]
ws_3 <- us_lib[10001:15000,]
ws_4 <- us_lib[15001:17586,]

test <- data.frame()
for (b in unique(dc_lib$LIBID)){
	lib_code <- subset(dc_lib,LIBID==b)
	lat <- lib_code$LATITUDE[1]
	lon <- lib_code$LONGITUDE[1]
	address <- lib_code$ADDRESS[1]
	city <- lib_code$CITY[1]
	state <- lib_code$STABR[1]
	zip <- lib_code$ZIP[1]
	county <- lib_code$CNTY[1]
	lib_name <- lib_code$LIBNAME[1]

	ws <- fromJSON(paste0("http://api.walkscore.com/score?format=json&lat=",lat,"&lon=",lon,"&wsapikey=<INSERT KEY HERE>"))
	
	walkscore <- ws$walkscore
	description <- ws$description

	new_row <- cbind(lat,lon,address,city,zip,county,lib_name,walkscore,description)
	test <- rbind(test,new_row)
}

##MAP TIME!