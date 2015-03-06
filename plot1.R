# read first 100 rows, divide by 100 and multiply by the number of entries
# to estimate the size in memory of the full dataset, the reason for this
# is that the 1st row is just strings and they take up more space than the
# rest of the objects
mem_total<-(object.size(read.csv("household_power_consumption.txt",nrow=100))/100)*2075259

# get data into the energy_data data
energy_data<-read.table("household_power_consumption.txt",header=TRUE,sep=";")

# filter data for the subset we need
energy_data<-energy_data[energy_data$Date=="1/2/2007"|energy_data$Date == "2/2/2007",]

# combine date and time into unique timestamp 
energy_data$Date <- strptime(paste(energy_data$Date, energy_data$Time),"%d/%m/%Y %H:%M:%S")

#drop the time column - no longer needed
energy_data$Time<-NULL

# now set all variables as numeric, they are all factors

energy_data$Global_active_power <- as.numeric(as.character(energy_data$Global_active_power))
energy_data$Sub_metering_1 <- as.numeric(as.character(energy_data$Sub_metering_1))
energy_data$Sub_metering_2 <- as.numeric(as.character(energy_data$Sub_metering_2))
energy_data$Sub_metering_3 <- as.numeric(as.character(energy_data$Sub_metering_3))
energy_data$Voltage <- as.numeric(as.character(energy_data$Voltage))
energy_data$Global_intensity <- as.numeric(as.character(energy_data$Global_intensity))
energy_data$Global_reactive_power <- as.numeric(as.character(energy_data$Global_reactive_power))

png(filename="plot1.png", width=480,height=480, bg="transparent")
hist(energy_data$Global_active_power,col="Red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()