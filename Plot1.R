## Plot1.R

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
png("Plot1.png", width=480, height=480, bg="transparent", antialias="n")
#png("Plot1.png", width=480, height=480, antialias="n")

## Plot the histagram chart with Global Active Power as the x-axis
hist(small_data$Global_active_power, freq=TRUE,
     xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")

## Close the device
dev.off()