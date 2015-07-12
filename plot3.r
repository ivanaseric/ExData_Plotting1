setwd('~/R/Exploratory_analysis/')

# Find the line number where Feb. 1. 2007 begins
line_number_start<-system("grep -nr ^1/2/2007 household_power_consumption.txt |cut -f1 -d:",intern=TRUE)
skip_read<-as.numeric(line_number_start[1])

# Find the line number where Feb. 1. 2007 ends
thursday_end <- as.numeric(tail(line_number_start, n=1))-skip_read

# Find the line number where Feb. 2. 2007 ends
line_number_end<-system("grep -nr ^2/2/2007 household_power_consumption.txt |cut -f1 -d:",intern=TRUE)
end_read<-as.numeric(tail(line_number_end, n=1))-skip_read

# Read the data set, only for Feb. 1. 2007 and Feb. 2. 2007
data1 = read.table("household_power_consumption.txt", header = TRUE, sep=";", 
                   na.strings = "?", skip = skip_read, nrows = end_read  ,
                   colClasses =  c("character", "character", "numeric", "numeric", "numeric","numeric", "numeric", "numeric", "numeric"), 
                   col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")) 

# 3rd plot
png(filename = "plot3.png",height=480, width=480)
plot(data1$Sub_metering_1, type = "l",axes=FALSE, ann=FALSE)
lines(data1$Sub_metering_2, col="red")
lines(data1$Sub_metering_3, col="blue")
box()
axis(1, at=c(1,thursday_end,end_read), lab=c("Thu","Fri","Sat"))
axis(2, at=c(0,10,20,30), lab=c(0,10,20,30))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.5,col=c("black","red","blue"), lty=1)
title(ylab="Energy sub metering")
dev.off() 