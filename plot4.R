## Scripts for Coursera Exploratory Data Analysis

# course project 1
#

# estimate the memory in MB, assuming 8 bytes per number
2075259 * 9 * 8 / 2^20
# yields about 142 MB, no big deal to read in memory

data <- read.csv("./household_power_consumption.txt", sep=";", na.strings="?")

library(prpr)  # for object_size
print(object.size(data), units="MB")
#> 127 MB
#
# the data and time columns used less memory, this can be confirmed by
print(object.size(data[,3:9]) /7 * 9, units="MB")
#> 142 MB as estimated

# subset the data for 1/2/2007 and 2/2/2007
data2 <- subset(data, Date %in% c('2/1/2007', '2/2/2007'))
#
# or
data2 <- subset(data, Date=='1/2/2007' | Date=='2/2/2007')

# Now coerce the Date and Time columns to use Date/Time classes
#
# data$Date <- as.Date(data$Date, format='%d/%m/%Y')
# data$Time <- strptime(data$Time, format='%H:%M:%S')
#
# or simply make a new DateTime variable
data2$DateTime <- strptime(paste(data2$Date, data2$Time, sep=' '), '%d/%m/%Y %H:%M:%S')

plot3 <- function(data2){
  with(data2, plot(DateTime, Sub_metering_1, type='n', xlab='', ylab='Energy sub metering'))
  with(data2, lines(DateTime, Sub_metering_1))
  with(data2, lines(DateTime, Sub_metering_2, col='red'))
  with(data2, lines(DateTime, Sub_metering_3, col='blue'))
  legend('topright', pch=1, col=c('black','red','blue'), legend=names(data2)[7:9])
}

# plot 4
png(file='plot4.png', width=480, height=480)
par(mfrow = c(2,2), cex=0.65)  # for screen
par(mfrow = c(2,2), cex=0.8)   # for png file
with(data2, {
  plot(DateTime, Global_active_power, type='l', xlab='', ylab='Global Active Power')
  plot(DateTime, Voltage, type='l', xlab='datetime')
  plot3(data2)
  plot(DateTime, Global_reactive_power, type='l', xlab='datetime')
})
# dev.copy(png, file = 'plot4.png', width=480, height=480)
dev.off()
