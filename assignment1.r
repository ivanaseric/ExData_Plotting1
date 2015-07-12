
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

# 1st plot
png(filename = "plot1.png",height=480, width=480)
with(data1, hist(data1$Global_active_power, col="red", xlab="Global Active Power (kilowatts)",main="Global Active Power",xlim=c(0, 6)))
dev.off() 

# 2nd plot
png(filename = "plot2.png",height=480, width=480)
plot(data1$Global_active_power, type = "l",axes=FALSE, ann=FALSE)
axis(1, at=c(1,thursday_end,end_read), lab=c("Thu","Fri","Sat"))
box()
axis(2, at=c(0,2,4,6), lab=c(0,2,4,6))
title(xlab="", ylab="Global Active Power (kilowatts)")
dev.off() 

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

# 4th plot
png(filename = "plot4.png",height=480, width=480) 
par(mfrow = c(2, 2), mar = c(5, 5, 1, 1), oma = c(0, 0, 2, 0))
plot(data1$Global_active_power, type = "l",axes=FALSE, ann=FALSE, pch=20)
axis(1, at=c(1,thursday_end,end_read), lab=c("Thu","Fri","Sat"))
box()
axis(2, at=c(0,2,4,6), lab=c(0,2,4,6))
title(xlab="", ylab="Global Active Power (kilowatts)")

plot(data1$Voltage, type = "l",axes=FALSE, ann=FALSE, pch=20)
axis(1, at=c(1,thursday_end,end_read), lab=c("Thu","Fri","Sat"))
axis(2, at=seq(234, 246, by=2))
box()
title(xlab="datetime", ylab="Voltage")

plot(data1$Sub_metering_1, type = "l",axes=FALSE, ann=FALSE, pch=20)
lines(data1$Sub_metering_2, col="red")
lines(data1$Sub_metering_3, col="blue")
box()
axis(1, at=c(1,thursday_end,end_read), lab=c("Thu","Fri","Sat"))
axis(2, at=c(0,10,20,30), lab=c(0,10,20,30))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=1,col=c("black","red","blue"), lty=1)
title(xlab="", ylab="Energy sub metering")

plot(data1$Global_reactive_power, type = "l",axes=FALSE, ann=FALSE, pch=20)
axis(1, at=c(1,thursday_end,end_read), lab=c("Thu","Fri","Sat"))
box()
axis(2, at=seq(0, 0.5, by=.1), lab=seq(0, 0.5, by=.1))
title(xlab="datetime", ylab="Global_reactive_power")
dev.off() 
