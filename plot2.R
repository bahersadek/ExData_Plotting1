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
data_full <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", nrows=2075259, check.names=F, 
                      stringsAsFactors=F, comment.char="", quote='\"')
## convert to date format
data1 <- subset(data_full, Date %in% c("1/2/2007","2/2/2007"))
data1$Date <- as.Date(data1$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(data1$Date), data1$Time)
data1$Datetime <- as.POSIXct(datetime)

## Draw Plot 2
with(data1, {
  plot(Global_active_power~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
})
## export PNG
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()