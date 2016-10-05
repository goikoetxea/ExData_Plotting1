if(!file.exists("exdata-data-household_power_consumption.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./power.zip")
  file <- unzip("power.zip")
}

power <- read.table(file, header = T, sep =";")
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
df <- power[(power$Date == "2007-02-01")|(power$Date =="2007-02-02"),]
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))
df <- transform(df, date_time=as.POSIXct(paste(Date, Time)))
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

plot3 <- function(){
  plot(df$date_time, df$Sub_metering_1, xlab="", ylab = "Energy sub metering", type = "l")
  lines(df$date_time, df$Sub_metering_2, col="red")
  lines(df$date_time, df$Sub_metering_3, col="blue")
  legend("topright", col = c("black", "red", "blue"), c("Sub_mettering_1 ","Sub_mettering_2 ", "Sub_mettering_3 "))
  dev.copy(png, file="plot3.png", width=480, height=480)
  dev.off()
}
plot3()