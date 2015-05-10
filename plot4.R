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
hpc$voltage <- as.numeric(as.character(hpc$voltage))
hpc$global_reactive_power <- as.numeric(as.character(hpc$global_reactive_power))
hpc$sub_metering_1 <- as.numeric(as.character(hpc$sub_metering_1))
hpc$sub_metering_2 <- as.numeric(as.character(hpc$sub_metering_2))
hpc$sub_metering_3 <- as.numeric(as.character(hpc$sub_metering_3))
hpc$datetime <- strptime(paste(hpc$date, hpc$time), "%Y-%m-%d %H:%M:%S")

png(filename = './plot4.png', width = 480, height = 480)

par(mfrow = c(2, 2))

with(hpc, {
  plot(datetime, global_active_power, type="l",
               xlab="",ylab='Global Active Power')
  
  plot(datetime, voltage, type="l", ylab='Voltage')
  
  plot(datetime, sub_metering_1, type="l", col="black",
               xlab="",ylab="Energy sub metering")
  points(datetime, sub_metering_2, type="l", col="red")
  points(datetime, sub_metering_3, type="l", col="blue")
  legend("topright", col = c("black","red", "blue"), lwd=1, bty="n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(datetime, global_reactive_power, type="l", ylab='Global_reactive_power')
})

dev.off()