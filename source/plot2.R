library(sqldf)
#Read file with subsetting only dates for Feb 1st and 2nd 2007
myFile <- "../../data/household_power_consumption.txt"
dfData <- read.csv2.sql(myFile,sql="SELECT * FROM file WHERE Date='1/2/2007' OR 
                        Date='2/2/2007'",sep=";",na.strings="?")
names(dfData) <- gsub("_", "", tolower(names(dfData)))
#Merge data and time
dfData[,1] <- paste(dfData[,1], dfData[,2])

# Using png command for generating png file and then plotting
png("plot/plot2.png", width=480, height=480)
par(mar = c(4.2,5,4,2), bg="white")
plot(strptime(dfData[,1], "%d/%m/%Y %H:%M:%S"), dfData[,3], type="l", 
     xlab="", ylab="Global Active Power (kilowatts)")
dev.off()