plot3 <- function(){
  
  ##Set the WD, check if the file is downloaded and download if not
  setwd("~/Coursera/EDA/CP-1")
  if(!file.exists("CP-Data.Zip")){
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  destfile = "CP-Data.Zip")
    unzip("CP-Data.Zip")
  }
  ##Check if data is already in memory
  if(!exists("data.feb")){  
    ##Read the data in to memory
    data <- read.table("household_power_consumption.txt", header =T, sep =";", na.strings = "?")
    
    ##Filter the data to only the perscribed dates
    x <- as.Date(c("2007-02-01","2007-02-02"))
    data$Date <- as.Date(data$Date, "%d/%m/%Y")
    y <- data$Date == x[1] | data$Date == x[2]
    data.feb <- data[y,]
    z <- paste(data.feb$Date, data.feb$Time)
    datetime <- strptime(z, "%Y-%m-%d %H:%M:%S")
    data.feb <- cbind(datetime,data.feb)
  }
  
  setwd("~/Coursera/EDA/CP-1/ExData_Plotting1")
  
  ##Open the PNG
  png(filename = "plot3.png", width = 480, height = 480)
  
  ##Create the Plot in the PNG
  with(data.feb, plot(datetime,Sub_metering_1, col = "black",
                      xlab = "", 
                      ylab = "Energy sub metering", 
                      type ="l"))
  
  with(data.feb, points(datetime,Sub_metering_2, col = "red", type = "l"))
  with(data.feb, points(datetime,Sub_metering_3, col = "blue", type = "l"))
  legend("topright", pch = "--",
         col = c("black","red","blue"), 
         legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  ##Close the PNG
  dev.off()
  
}