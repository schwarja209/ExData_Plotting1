library(dplyr) #for easy sorting

#download data and read table from zip
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","PowerUse.zip")
PowerUse<-read.table(unz("PowerUse.zip", "household_power_consumption.txt"), header=TRUE,sep=";",na.strings="?")

PowerUse_plots2<-select(PowerUse,Date,Time,Global_active_power)%>% #filter data to columns used from source
    mutate(Date=as.Date(PowerUse$Date,"%d/%m/%Y"))%>% #fix date column format
    mutate(Date_Time=as.POSIXct(strptime(paste(PowerUse$Date,PowerUse$Time), #add column combining date and time in proper format
                                         format="%d/%m/%Y %H:%M:%S")))%>%
    filter(Date=="2007-02-01"|Date=="2007-02-02")%>% #filter to date range used in graph
    select(Date_Time,Global_active_power) #filter to columns used in graph

par(mfcol=c(1,1)) #reset graph area

with(PowerUse_plots2,plot(x=Date_Time,y=Global_active_power, #plot scatterplot with solid line
                           type="l",lwd=1,main="",col="black",xlab="",
                           ylab="Global Active Power (kilowatts)"))

dev.copy(png,file="Plot2.png",width=480,height=480) #copy plot to png
dev.off()