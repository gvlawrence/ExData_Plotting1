#######################################################################
#  EDA Project 1 - PLOT 1                         Greg Lawrence
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

#plot 1 setup
windows(8,8)
devwin <- dev.cur()

#plot 1
hist(hpc1$Global_active_power, col = "red",ann=FALSE)
title(main="Global Active Power", xlab="Global Active Power (kilowatts)", 
      ylab="Frequency")

savePlot(filename="plot1.png",type="png")

dev.off()