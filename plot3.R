#######################################################################
#  EDA Project 1 - PLOT 3                         Greg Lawrence
#
#  data file assumed to be in same directory as the source code
#######################################################################
library(dplyr)
library(readr)
hpc <- read_delim("./household_power_consumption.txt",delim=";",
                  col_names=TRUE,col_types="ccnnnnnnn",na="?")
hpc1 <- filter(hpc, hpc$Date %in% c("1/2/2007","2/2/2007") )
hpc1 <- tbl_df(hpc1)
hpc2 <- mutate(hpc1,dtChar=paste(as.Date(Date,format="%d/%m/%Y"),Time))
hpc3 <- mutate(hpc2,datetime=as.POSIXct(strptime(dtChar,format="%Y-%m-%d %H:%M:%S")))

#plot 3 setup
windows(8,8)
devwin <- dev.cur()

#plot3
ylim <- range(c(hpc3$Sub_metering_1,hpc3$Sub_metering_2,hpc3$Sub_metering_3))
plot(hpc3$datetime,hpc3$Sub_metering_1,type="l",ylim=ylim,col="black",ann=FALSE)
lines(hpc3$datetime,hpc3$Sub_metering_2,type="l",col="red")
lines(hpc3$datetime,hpc3$Sub_metering_3,type="l",col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lty=c(1,1,1))
title(main="", xlab="", ylab="Energy sub metering")

savePlot(filename="plot3.png",type="png")

dev.off()