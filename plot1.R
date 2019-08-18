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
## Draw Plot 1
hist(data1$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
## export PNG
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()