library(dplyr)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","PowerUse.zip")
PowerUse<-read.table(unz("PowerUse.zip", "household_power_consumption.txt"), header=TRUE,sep=";",na.strings="?")

PowerUse_plots4<-mutate(PowerUse,Date=as.Date(PowerUse$Date,"%d/%m/%Y"))%>%
    mutate(Date_Time=as.POSIXct(strptime(paste(PowerUse$Date,PowerUse$Time),
                                         format="%d/%m/%Y %H:%M:%S")))%>%
    filter(Date=="2007-02-01"|Date=="2007-02-02")

png(file="Plot4.png",width=480,height=480)
par(mfcol=c(2,2))

with(PowerUse_plots4,plot(x=Date_Time,y=Global_active_power, 
                          type="l",lwd=1,main="",col="black",xlab="",
                          ylab="Global Active Power (kilowatts)"))

with(PowerUse_plots4,
     plot(x=Date_Time,y=Sub_metering_1,type="l",lwd=1,main="",col="black",xlab="",ylab="Energy sub metering"))
lines(x=PowerUse_plots4$Date_Time,y=PowerUse_plots4$Sub_metering_2,type="l",lwd=1,col="red")
lines(x=PowerUse_plots4$Date_Time,y=PowerUse_plots4$Sub_metering_3,type="l",lwd=1,col="blue")
legend(x="topright",lty=1,box.lty=0,col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

with(PowerUse_plots4,plot(x=Date_Time,y=Voltage, 
                          type="l",lwd=1,main="",col="black",xlab="datetime",
                          ylab="Voltage"))

with(PowerUse_plots4,plot(x=Date_Time,y=Global_reactive_power, 
                          type="l",lwd=1,main="",col="black",xlab="datetime",
                          ylab="Global_reactive_power"))

dev.off()