# DOwnload the file and put the file in the data folder
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/Dataset.zip", method = "curl")

# Unzip the file to data folder
unzip(zipfile = "./data/Dataset.zip", exdir = "./data")

# Read files
hpc <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
hpc2 <- subset(hpc, Date %in% c("1/2/2007", "2/2/2007"))
hpc2$Date <- as.Date(hpc2$Date, format = "%d/%m/%y")
datetime <- paste(as.Date(hpc2$Date), hpc2$Time)
hpc2$Datetime <- as.POSIXct(datetime)

#plot
with(hpc2, {
  plot(Global_active_power~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  })

# Copy my plot to a PNG file
dev.copy(png, file = "plot2.png", width=480, height=480) 
dev.off()