library(dplyr)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","PowerUse.zip")
PowerUse<-read.table(unz("PowerUse.zip", "household_power_consumption.txt"), header=TRUE,sep=";",na.strings="?")

PowerUse_plots3<-select(PowerUse,Date,Time,Sub_metering_1,Sub_metering_2,Sub_metering_3)%>%
    mutate(Date=as.Date(PowerUse$Date,"%d/%m/%Y"))%>%
    mutate(Date_Time=as.POSIXct(strptime(paste(PowerUse$Date,PowerUse$Time),
                                         format="%d/%m/%Y %H:%M:%S")))%>%
    filter(Date=="2007-02-01"|Date=="2007-02-02")%>%
    select(Date_Time,Sub_metering_1,Sub_metering_2,Sub_metering_3)

png(file="Plot3.png",width=480,height=480)
par(mfcol=c(1,1))

with(PowerUse_plots3,
     plot(x=Date_Time,y=Sub_metering_1,type="l",lwd=1,main="",col="black",xlab="",ylab="Energy sub metering"))
lines(x=PowerUse_plots3$Date_Time,y=PowerUse_plots3$Sub_metering_2,type="l",lwd=1,col="red")
lines(x=PowerUse_plots3$Date_Time,y=PowerUse_plots3$Sub_metering_3,type="l",lwd=1,col="blue")
legend(x="topright",lty=1,col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()