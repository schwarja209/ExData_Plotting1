library(dplyr) #for easy sorting

#download data and read table from zip
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","PowerUse.zip")
PowerUse<-read.table(unz("PowerUse.zip", "household_power_consumption.txt"), header=TRUE,sep=";",na.strings="?")

PowerUse_plots1<-select(PowerUse,Date,Global_active_power)%>% #filter data to two columns used in graph
    mutate(Date=as.Date(PowerUse$Date,"%d/%m/%Y"))%>% #fix date column format
    filter(Date=="2007-02-01"|Date=="2007-02-02") #filter to date range used in graph

par(mfcol=c(1,1)) #reset graph area

hist(PowerUse_plots1$Global_active_power, col="red", #plot histogram
     xlab="Global Active Power (kilowatts)",
     main="Global Active Power")

dev.copy(png,file="Plot1.png",width=480,height=480) #copy plot to png
dev.off()