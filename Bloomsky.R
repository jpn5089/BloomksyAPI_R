library(dplyr)
library(lubridate)
library(rnoaa)
library(ggplot2)
library(httr)
library(jsonlite)

options(stringsAsFactors = FALSE)

url <- "https://api.bloomsky.com/api/skydata/?format=json"

raw <-GET(url=url, add_headers(Authorization = "ueCzsdrWveDYntCov6OY59rRh9vUtsae"))

this.raw.content <- rawToChar(raw$content)
this.content <- fromJSON(this.raw.content, simplifyVector = FALSE)
this.content

#####################################################################################
### Manual Download of csv file                                                   ###
#####################################################################################

bloomsky <- read.csv(file = "C:\\Users\\John\\Downloads\\BloomSky_JP's Wx Station_01-02-17@0248PM-01-03-17@0248PM.csv") %>%
  mutate(Temperature = round((1.8*Temperature + 32),2)) %>%
  mutate(TS = ymd_hms(gsub("T"," ",TS)))
  
ggplot(bloomsky, aes(x = TS, y = Temperature)) +
  geom_line()