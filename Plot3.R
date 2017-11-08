library(dplyr) #for easy sorting

#download data and read table from zip
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","PowerUse.zip")
PowerUse<-read.table(unz("PowerUse.zip", "household_power_consumption.txt"), header=TRUE,sep=";",na.strings="?")

PowerUse_plots3<-select(PowerUse,Date,Time,Sub_metering_1,Sub_metering_2,Sub_metering_3)%>% #filter data to columns used in source
    mutate(Date=as.Date(PowerUse$Date,"%d/%m/%Y"))%>% #fix date column format
    mutate(Date_Time=as.POSIXct(strptime(paste(PowerUse$Date,PowerUse$Time), #add column combining date and time in proper format
                                         format="%d/%m/%Y %H:%M:%S")))%>%
    filter(Date=="2007-02-01"|Date=="2007-02-02")%>% #filter to date range used in graph
    select(Date_Time,Sub_metering_1,Sub_metering_2,Sub_metering_3) #filter to columns used in graph

png(file="Plot3.png",width=480,height=480) #initialize interface
par(mfcol=c(1,1)) #reset graph area

with(PowerUse_plots3, #plot scatterplot with solid line
     plot(x=Date_Time,y=Sub_metering_1,type="l",lwd=1,main="",col="black",xlab="",ylab="Energy sub metering"))
with(PowerUse_plots3,lines(x=Date_Time,y=Sub_metering_2,type="l",lwd=1,col="red")) #add second line
with(PowerUse_plots3,lines(x=Date_Time,y=Sub_metering_3,type="l",lwd=1,col="blue")) #add third line
legend(x="topright",lty=1,col=c("black","red","blue"), #add legend
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()