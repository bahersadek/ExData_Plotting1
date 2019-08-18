## Baher Anwar Workaround for data source;
filename <- "exdata_data_household_power_consumption.zip"
## check if not file exist to download
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, method="curl")
}  
## check if file need to be extracted from zip file
if (!file.exists("household_power_consumption.txt")) { 
  unzip(filename) 
}
## reading Data Source
data_full <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", nrows=2075259, 
                      check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
## Filter data between required dates (1/2/2007 and 2/2/2007)
data1 <- subset(data_full, Date %in% c("1/2/2007","2/2/2007"))
## convert to date format
data1$Date <- as.Date(data1$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(data1$Date), data1$Time)
data1$Datetime <- as.POSIXct(datetime)
## Change global plot parameters
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data1, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, cex = 0.6,
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})
## export PNG
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
