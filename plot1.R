plot1 <- function(){
  
  ##Set the WD, check if the file is downloaded and download if not
  setwd("~/Coursera/EDA/CP-1")
  if(!file.exists("CP-Data.Zip")){
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  destfile = "CP-Data.Zip")
    unzip("CP-Data.Zip")
  }
  
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
  png(filename = "plot1.png", width = 480, height = 480)
  
  ##Create the Plot in the PNG
  hist(data.feb$Global_active_power, 
       col ="red", 
       main = "Global Active Power", 
       xlab = "Global Active Power (kilowatts)")
  
  ##Close the PNG
  dev.off()
  
}