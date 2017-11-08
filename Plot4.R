library(dplyr) #for easy sorting

#download data and read table from zip
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","PowerUse.zip")
PowerUse<-read.table(unz("PowerUse.zip", "household_power_consumption.txt"), header=TRUE,sep=";",na.strings="?")

PowerUse_plots4<-mutate(PowerUse,Date=as.Date(PowerUse$Date,"%d/%m/%Y"))%>% #fix date column format
    mutate(Date_Time=as.POSIXct(strptime(paste(PowerUse$Date,PowerUse$Time), #add column combining date and time in proper format
                                         format="%d/%m/%Y %H:%M:%S")))%>%
    filter(Date=="2007-02-01"|Date=="2007-02-02") #filter to date range used in graph

png(file="Plot4.png",width=480,height=480) #initialize interface
par(mfcol=c(2,2)) #set graph parameters

with(PowerUse_plots4,plot(x=Date_Time,y=Global_active_power,  #plot first scatterplot with solid line
                          type="l",lwd=1,main="",col="black",xlab="",
                          ylab="Global Active Power (kilowatts)"))

with(PowerUse_plots4, #plot second scatterplot with solid line
     plot(x=Date_Time,y=Sub_metering_1,type="l",lwd=1,main="",col="black",xlab="",ylab="Energy sub metering"))
with(PowerUse_plots4,lines(x=Date_Time,y=Sub_metering_2,type="l",lwd=1,col="red")) #add second line
with(PowerUse_plots4,lines(x=Date_Time,y=Sub_metering_3,type="l",lwd=1,col="blue")) #add third line
legend(x="topright",lty=1,box.lty=0,col=c("black","red","blue"), #add legend with no box
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

with(PowerUse_plots4,plot(x=Date_Time,y=Voltage, #plot third scatterplot with solid line
                          type="l",lwd=1,main="",col="black",xlab="datetime",
                          ylab="Voltage"))

with(PowerUse_plots4,plot(x=Date_Time,y=Global_reactive_power, #plot fourth scatterplot with solid line
                          type="l",lwd=1,main="",col="black",xlab="datetime",
                          ylab="Global_reactive_power"))

dev.off()