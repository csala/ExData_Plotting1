grep_csv <- function(file, expr,...){
    header <- read.csv(file, nrows=1, header=FALSE,...)
    rows <- grep(expr,readLines(file),value=TRUE)
    data <- read.table(text=rows,...)
    names(data) <- header
    data
}
load_data <- function(){
    if (file.exists('household_power_consumption.txt')){
        grep_csv('household_power_consumption.txt','^(1/2/2007|2/2/2007)',sep=';',stringsAsFactors=FALSE)
    } else {
        stop('File household_power_consumption.txt not found. Please download it from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip, uncompress it and try again')
    }
}

plot3 <- function(){
    data <- load_data()
    data$DateTime <- strptime(paste(data$Date,data$Time),'%d/%m/%Y %H:%M:%S')
    Sys.setlocale("LC_TIME", "en_US.UTF-8")
    png('plot3.png')
    plot(data$DateTime, data$Sub_metering_1, type='line',ylab='Energy sub metering',xlab='')
    lines(data$DateTime, data$Sub_metering_2, col = 'red')
    lines(data$DateTime, data$Sub_metering_3, col = 'blue')
    legend('topright', legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), col=c('black','red','blue'), lty=c(1,1))
    dev.off()
}
