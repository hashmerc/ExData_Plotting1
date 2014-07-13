library(sqldf)

#Alternate way to read file using grep command in the read statement
#dat <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),header=F, sep=';')

#Read file with subsetting only dates for Feb 1st and 2nd 2007
myFile <- "../../data/household_power_consumption.txt"
dfData <- read.csv2.sql(myFile,sql="SELECT * FROM file WHERE Date='1/2/2007' OR 
                        Date='2/2/2007'",sep=";",na.strings="?")
names(dfData) <- gsub("_", "", tolower(names(dfData)))
#Merge data and time
dfData[,1] <- paste(dfData[,1], dfData[,2])

# Using png command for generating png file and then plotting
png("plot/plot1.png", width=480, height=480)
par(mar = c(4.2,5,4,2), bg="white")
hist(dfData[,3], main = "Global Active Power", col = "red", 
     xlab="Global Active Power (kilowatts)")
#dev.copy(png, file="plot/plot1.png")
dev.off()