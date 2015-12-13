#######################################################################
#  EDA Project 1 - PLOT 4                         Greg Lawrence
#
#  data file assumed to be in same directory as the source code
#######################################################################
library(dplyr)
library(readr)
hpc <- read_delim("household_power_consumption.txt",delim=";",
                  col_names=TRUE,col_types="ccnnnnnnn",na="?")
hpc1 <- filter(hpc, hpc$Date %in% c("1/2/2007","2/2/2007") )
hpc1 <- tbl_df(hpc1)
hpc2 <- mutate(hpc1,dtChar=paste(as.Date(Date,format="%d/%m/%Y"),Time))
hpc3 <- mutate(hpc2,datetime=as.POSIXct(strptime(dtChar,format="%Y-%m-%d %H:%M:%S")))

#plot 4 setup
windows(8,8)
devwin <- dev.cur()
par(mfrow=c(2,2))

#plot4a
plot(hpc3$datetime,hpc3$Global_active_power,type="l",
     main="",xlab="",ylab="Global Active Power")

#plot4b
with(hpc3, plot(datetime,Voltage,type="l",main=""))

#plot4c
plot(hpc3$datetime,hpc3$Sub_metering_1,type="l",ylim=ylim,
     main="",xlab="",ylab="Energy sub metering")
lines(hpc3$datetime,hpc3$Sub_metering_2,type="l",col="red")
lines(hpc3$datetime,hpc3$Sub_metering_3,type="l",col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lty=c(1,1,1),bty="n")

#plot4d
with(hpc3, plot(datetime,Global_reactive_power,type="l",main=""))
savePlot(filename="plot4.png",type="png")

dev.off()