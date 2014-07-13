library(sqldf)
#Read file with subsetting only dates for Feb 1st and 2nd 2007
myFile <- "../../data/household_power_consumption.txt"
dfData <- read.csv2.sql(myFile,sql="SELECT * FROM file WHERE Date='1/2/2007' OR 
                        Date='2/2/2007'",sep=";",na.strings="?")
names(dfData) <- gsub("_", "", tolower(names(dfData)))
#Merge data and time
dfData[,1] <- paste(dfData[,1], dfData[,2])
# Using png command for generating png file and then plotting
png("plot/plot4.png", width=480, height=480)
par(mar = c(4.2,5,4,3), bg="white", mfrow=c(2,2))
plot(strptime(dfData[,1], "%d/%m/%Y %H:%M:%S"), dfData[,3], type="l", 
     xlab="", ylab="Global Active Power")
plot(strptime(dfData[,1], "%d/%m/%Y %H:%M:%S"), dfData[,5], type="l", 
     xlab="datetime", ylab="Voltage")
plot(strptime(dfData[,1], "%d/%m/%Y %H:%M:%S"), dfData[,7], type="l", 
     xlab="", ylab="Energy sub metering")
lines(strptime(dfData[,1], "%d/%m/%Y %H:%M:%S"), dfData[,8], col="red")
lines(strptime(dfData[,1], "%d/%m/%Y %H:%M:%S"), dfData[,9], col="blue")
#Note the bty=n and cex=0.8 for removing the legend box and scaling it slightly down 
# for matching reference plot
legend("topright", lwd=1, bty="n", cex=0.8, col=c("black", "red", "blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot(strptime(dfData[,1], "%d/%m/%Y %H:%M:%S"), dfData[,4], type="l", 
     xlab="datetime", ylab="Global_reactive_power")
dev.off()