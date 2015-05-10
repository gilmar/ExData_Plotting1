library(dplyr)
library(lubridate)

Sys.setlocale(category = "LC_ALL", locale = "en_US.UTF-8")
setwd('/home/gilmarj/courses/coursera/exdata-014/ExData_Plotting1')
if(!file.exists("./data")){dir.create("./data")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- tempfile()
download.file(fileUrl,method="curl",file)

df <- read.csv(unz(file,"household_power_consumption.txt"),sep=';')

unlink(file)

names(df) <- tolower(names(df))
df$date <- as.Date(df$date,format='%d/%m/%Y')

hpc <- filter(df, date >= '2007-02-01' & date <= '2007-02-02')

hpc$global_active_power <- as.numeric(as.character(hpc$global_active_power))
hpc$datetime <- strptime(paste(hpc$date, hpc$time), "%Y-%m-%d %H:%M:%S")

png(filename = './plot2.png', width = 480, height = 480)

with(hpc, plot(datetime, global_active_power, type="l",
               xlab="",ylab='Global Active Power (kilowatts)'))

dev.off()