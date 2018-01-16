## Plot2.R

## Set the current working directory as appropriate
setwd("~/Coursera/Data Science Specialty/Course 4")

## Read in the large table and coerce the date column to a usable format
pwr_data <- read.csv("household_power_consumption.txt", sep = ";")
pwr_data$Date <- as.Date(pwr_data$Date, "%d/%m/%Y")

## Subset the data for just the two days wanted.
small_data <- subset(pwr_data, (Date=="2007-02-01" | Date=="2007-02-02") &
                         Global_active_power != "?")

## To save memory we can remove the original data frame
rm(pwr_data)

## Turn the factors into numerics so that the values plot properly
small_data$Global_active_power <- as.numeric(as.character(small_data$Global_active_power))

## Set the graphics device to be a PNG file, 480 px square and transparent
png("Plot2.png", width=480, height=480, bg="transparent", antialias="n")
#png("Plot2.png", width=480, height=480, antialias="n")

## Plot the chart with Global Active Power as the y-axis and the combined date/time as
## the x-axis.
with(small_data, plot(x=as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"),
                      y=Global_active_power, type="l",
                      ylab="Global Active Power (kilowatts)", xlab=""))

## Close the device
dev.off()