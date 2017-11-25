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
png(filename = "Plot2.png",width = 480, height = 480, units = "px")

# Plot 2
with(power, plot(x = datetime, y = Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

# device off
dev.off()
