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
png(filename = "Plot1.png",width = 480, height = 480, units = "px")

# Plot 1
hist(power$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

# device off
dev.off()
