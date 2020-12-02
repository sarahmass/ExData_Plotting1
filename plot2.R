## This code is to reproduce the histogram in plot2.png for Week 1's project in 
## Johns Hopkin UniversitY's Exploring Data Analysis course on Coursera
## 
library(lubridate)
library(dplyr)

## Create a temp file. 
temp <- tempfile()

## Download zipped data into temp file
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,temp)

## unzip data and read to a table
data <- read.table(unz(temp,"household_power_consumption.txt"),
                   header=TRUE,
                   sep = ";",
                   quote = "",
                   na.strings = "?")
unlink(temp)

## filter the data to only include data from Feb 1 thru Feb 2 2007
data <- filter(data, dmy(Date) %in% c(dmy("01/02/2007"),dmy("02/02/2007")))

## add a DateTime variable (a POSIXct date-time object)               
data$DateTime = paste(data$Date,data$Time, sep=" ")
data$DateTime = dmy_hms(data$DateTime)

## launch png graphics device
png(file = "plot2.png")

## plot the Global_active_power with respect to date,
with(data, plot(DateTime,Global_active_power,
                type = "l", # connect data with lines
                xlab = "",  # no label for the horizontal axis
                ylab = "Global Active Power (kilowatts)"))
## close graphics device
dev.off()
