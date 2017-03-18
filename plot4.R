
getElectricData <- function(fileUrl){
  fileName <- "Electric_Power_Consumption.zip"
  fileNameAfterUnzip <- "household_power_consumption.txt" 
  download.file(fileUrl, fileName , mode = "wb")
  unzip(fileName, overwrite = TRUE)
  selectedLines <- grep("^(Date|[1,2]/2/2007)", readLines(fileNameAfterUnzip), value = TRUE)
  dataSet <- read.table(header = TRUE, 
                        sep = ";",
                        text = selectedLines,
                        colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
  dataSet$DateTime <- strptime(paste(dataSet$Date,dataSet$Time),"%d/%m/%Y %H:%M:%S")
  finalDataSet <- dataSet[,c("DateTime", colnames(dataSet)[3:9])]
  dataSet <- NULL
  finalDataSet
}

getPlot4 <- function (){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
  finalDataSet <- getElectricData(fileUrl)
  png("plot4.png", width = 480, height = 480, units = "px")
  par(mfcol = c(2,2), mar = c(4,4,2,2))
  plot(finalDataSet$DateTime, finalDataSet$Global_active_power, xlab= "", ylab = "Global Active Power", type = "l")
  plot(finalDataSet$DateTime, finalDataSet$Sub_metering_1, xlab= "", ylab = "Energy sub metering", type = "l")
  lines(finalDataSet$DateTime, finalDataSet$Sub_metering_2, col = "red")
  lines(finalDataSet$DateTime, finalDataSet$Sub_metering_3, col = "blue")
  legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black", "red", "blue"), lty = c(1,1,1), bty = "n")
  plot(finalDataSet$DateTime, finalDataSet$Voltage,xlab = "datetime", ylab = "Voltage", type = "l")
  plot(finalDataSet$DateTime, finalDataSet$Global_reactive_power,xlab = "datetime", ylab = "Global_reactive_power", type = "l")
  dev.off()
}

getPlot4()
