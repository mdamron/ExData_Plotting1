# assumes household_power_consumption.txt is unzipped in working directory
# filter on the read using sql
library(sqldf)
power <- read.csv.sql("household_power_consumption.txt", 
             sql = "select * from file where Date in ('1/2/2007', '2/2/2007')",  
             header = TRUE, sep = ";")  
closeAllConnections()

# convert dates and times
power$datetime <- strptime(with(power, paste(Date, Time)), format = "%d/%m/%Y %T")

# Set PNG device
png(filename = "Plot4.png",width = 480, height = 480, units = "px")

# Plot 4
par(mfcol = c(2, 2))

# top left
with(power, plot(x = datetime, y = Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))

# bottom left"
with(power, plot(x = datetime, y = rep(max(Sub_metering_1, Sub_metering_2, Sub_metering_3), length(datetime))
                 , type = "n", ylim = c(0, 40)
                 , xlab = "", ylab = "Energy sub metering"))
with(power, points(x = datetime, y = Sub_metering_1, type = "l", col = "black"))
with(power, points(x = datetime, y = Sub_metering_2, type = "l", col = "red"))
with(power, points(x = datetime, y = Sub_metering_3, type = "l", col = "blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue")
       , lty = "solid", lwd = 1, bty = "n")

# top right
with(power, plot(x = datetime, y = Voltage, type = "l"))

# bottom right
with(power, plot(x = datetime, y = Global_reactive_power, type = "l"))

# reset mfcol
par(mfcol = c(1, 1))

# device off
dev.off()
