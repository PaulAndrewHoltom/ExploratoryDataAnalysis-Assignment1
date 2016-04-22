# unzip the data and load the table 
unzip("exdata-data-household_power_consumption.zip")

data <- read.table(file="household_power_consumption.txt", header=TRUE, sep=";")

# quick check
head(data)
str(data)

# fix date format
data$Date<- as.Date(data$Date,'%d/%m/%Y')

# subset data for the 2 days separately, then combine
data_01 <- data[data$Date=="2007/02/01",]
data_02 <- data[data$Date=="2007/02/02",]

data_subset <- rbind(data_01,data_02)

# quick check
str(data_subset)
names(data_subset)
table(data_subset$Date) # 1440 elements for each date (= number of minutes in a day)

# fix format for variable we wish to plot, Global_active_power
data_subset$Global_active_power <- as.numeric(as.character(data_subset$Global_active_power))

# plot on screen device
hist(data_subset$Global_active_power, col="red",
    xlab="Global Active Power (kilowatts)", 
    main="Global Active Power")

# create PNG file
png(filename = "plot1.png", width = 480, height = 480,
    units = "px", pointsize = 12, bg = "white")
hist(data_subset$Global_active_power, col="red",
     xlab="Global Active Power (kilowatts)", 
     main="Global Active Power")

dev.off()