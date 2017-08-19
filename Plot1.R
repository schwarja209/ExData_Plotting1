library(dplyr)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","PowerUse.zip")
PowerUse<-read.table(unz("PowerUse.zip", "household_power_consumption.txt"), header=TRUE,sep=";",na.strings="?")

PowerUse_plots1<-select(PowerUse,Date,Global_active_power)%>%
    mutate(Date=as.Date(PowerUse$Date,"%d/%m/%Y"))%>%
    filter(Date=="2007-02-01"|Date=="2007-02-02")

par(mfcol=c(1,1))

hist(PowerUse_plots1$Global_active_power, col="red",
     xlab="Global Active Power (kilowatts)",
     main="Global Active Power")

dev.copy(png,file="Plot1.png",width=480,height=480)
dev.off()