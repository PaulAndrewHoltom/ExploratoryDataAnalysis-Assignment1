# unzip the data and load the table 
unzip("exdata-data-household_power_consumption.zip")

data <- read.table(file="household_power_consumption.txt", header=TRUE, sep=";")

# fix date format
data$Date<- as.Date(data$Date,'%d/%m/%Y')

# subset data for the 2 days separately, add a DateTime field, then combine
data_01 <- data[data$Date=="2007/02/01",]
data_01$DateTime <- paste(data_01$Date, data_01$Time)
data_02 <- data[data$Date=="2007/02/02",]
data_02$DateTime <- paste(data_02$Date, data_02$Time)
data_subset <- rbind(data_01,data_02)

# quick check
str(data_subset)
names(data_subset)
table(data_subset$Date) # 1440 elements for each date (= number of minutes in a day)

# fix DateTime format
data_subset$DateTime <- strptime(data_subset$DateTime, format= "%Y-%m-%d %H:%M:%S")

# fix format for variable we wish to plot, Global_active_power
data_subset$Global_active_power <- as.numeric(as.character(data_subset$Global_active_power))

# plot to screen device
plot(data_subset$DateTime,data_subset$Global_active_power, 
     type="l", col="black",xlab="", 
     ylab="Global Active Power (kilowatts)")

# create PNG file
png(filename = "plot2.png", width = 480, height = 480,
    units = "px", pointsize = 12, bg = "white")
plot(data_subset$DateTime,data_subset$Global_active_power, 
     type="l", col="black",xlab="", 
     ylab="Global Active Power (kilowatts)")

dev.off()