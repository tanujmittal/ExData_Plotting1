
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

getPlot2 <- function (){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
  finalDataSet <- getElectricData(fileUrl)
  png("plot2.png", width = 480, height = 480, units = "px")
  plot(finalDataSet$DateTime, finalDataSet$Global_active_power, xlab= "", ylab = "Global Active Power (kilowatts)", type = "l")
  dev.off()
}

getPlot2()
