## Plot4.R

## Set the current working directory as appropriate
setwd("~/Coursera/Data Science Specialty/Course 4")

## Read in the large table and coerce the date column to a usable format
pwr_data <- read.csv("household_power_consumption.txt", sep = ";")
pwr_data$Date <- as.Date(pwr_data$Date, "%d/%m/%Y")

## Subset the data for just the two days wanted.
small_data <- subset(pwr_data, (Date=="2007-02-01" | Date=="2007-02-02") &
                         (Global_active_power != "?" | Global_reactive_power != "?" |
                              Voltage != "?" | Sub_metering_1 != "?" |
                              Sub_metering_2 != "?" | Sub_metering_3 != "?"))

## To save memory we can remove the original data frame
rm(pwr_data)

## Turn the factors into numerics so that the values plot properly
small_data$Global_active_power <- as.numeric(as.character(small_data$Global_active_power))
small_data$Global_reactive_power <- as.numeric(as.character(small_data$Global_reactive_power))
small_data$Voltage <- as.numeric(as.character(small_data$Voltage))
small_data$Sub_metering_1 <- as.numeric(as.character(small_data$Sub_metering_1))
small_data$Sub_metering_2 <- as.numeric(as.character(small_data$Sub_metering_2))
small_data$Sub_metering_3 <- as.numeric(as.character(small_data$Sub_metering_3))


## Set the graphics device to be a PNG file, 480 px square and transparent
png("Plot4.png", width=480, height=480, bg="transparent", antialias="n")
#png("Plot4.png", width=480, height=480, antialias="n")

## Setup the 2X2 matrix of plots
par(mfcol=c(2,2))

## First plot the chart with Global Active Power as the y-axis and the combined
## date/time as the x-axis.
with(small_data, plot(x=as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"),
                      y=Global_active_power, type="l",
                      ylab="Global Active Power (kilowatts)", xlab=""))

## Plot the chart with Global Active Power as the y-axis and the combined date/time as
## the x-axis.
with(small_data, plot(x=as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"),
                      y=Sub_metering_1, type="n",
                      ylab="Energy sub metering", xlab=""))

with(small_data, lines(x=as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"),
                       y=Sub_metering_1))

with(small_data, lines(x=as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"),
                       y=Sub_metering_2, col="red"))

with(small_data, lines(x=as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"),
                       y=Sub_metering_3, col="blue"))

legend(x="topright", lty=c(1,1,1), col=c("black", "red", "blue"), bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Then plot the voltage
with(small_data, plot(x=as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"),
                      y=Voltage, type="l",
                      ylab="Voltage", xlab="datetime"))

## Then finally plot the Global_reactive_power
with(small_data, plot(x=as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"),
                      y=Global_reactive_power, type="l",
                      ylab="Global_reactive_power", xlab="datetime"))

## Close the device
dev.off()