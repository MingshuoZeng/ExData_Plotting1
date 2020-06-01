# Unzip the file to data folder
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")

# Read files
hpc <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
hpc2 <- subset(hpc, Date %in% c("1/2/2007", "2/2/2007"))
hpc2$Date <- as.Date(hpc2$Date, format = "%d/%m/%y")
datetime <- paste(as.Date(hpc2$Date), hpc2$Time)
hpc2$Datetime <- as.POSIXct(datetime)

#partition
par(mfrow=c(2,2))

#1st plot
with(hpc2, {
  plot(Global_active_power~Datetime, type="l",
       ylab="Global Active Power", xlab="")
})

#2nd plot
with(hpc2, {
  plot(Voltage~Datetime, type="l",
       ylab="Voltage", xlab="datetime")
})

#3rd plot
with(hpc2, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Energy sub metering", xlab="")
})
with(hpc2, {
  lines(Sub_metering_2~Datetime, type="l",
        col="red")
})
with(hpc2, {
  lines(Sub_metering_3~Datetime, type="l",
        col="blue")
})

legend("topright",
       legend=c("Sub_meltering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"),
       lty=1, lwd=2, bty = "n")

#4th plot
with(hpc2, {
  plot(Global_reactive_power~Datetime, type="l",
       ylab="Global_reactive_power", xlab="datetime")
})



# Copy my plot to a PNG file
dev.copy(png, file = "plot4.png", width=480, height=480) 
dev.off()



