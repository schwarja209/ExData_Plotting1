library(dplyr)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","PowerUse.zip")
PowerUse<-read.table(unz("PowerUse.zip", "household_power_consumption.txt"), header=TRUE,sep=";",na.strings="?")

PowerUse_plots2<-select(PowerUse,Date,Time,Global_active_power)%>%
    mutate(Date=as.Date(PowerUse$Date,"%d/%m/%Y"))%>%
    mutate(Date_Time=as.POSIXct(strptime(paste(PowerUse$Date,PowerUse$Time),
                                         format="%d/%m/%Y %H:%M:%S")))%>%
    filter(Date=="2007-02-01"|Date=="2007-02-02")%>%
    select(Date_Time,Global_active_power)

par(mfcol=c(1,1))

with(PowerUse_plots2,plot(x=Date_Time,y=Global_active_power, 
                           type="l",lwd=1,main="",col="black",xlab="",
                           ylab="Global Active Power (kilowatts)"))

dev.copy(png,file="Plot2.png",width=480,height=480)
dev.off()