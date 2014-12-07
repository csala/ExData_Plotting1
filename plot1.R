grep_csv <- function(file, expr,...){
    header <- read.csv(file, nrows=1, header=FALSE,...)
    rows <- grep(expr,readLines(file),value=TRUE)
    data <- read.table(text=rows,...)
    names(data) <- header
    data
}
load_data <- function(){
    if file.exists('household_power_consumption.txt'){
        grep_csv('household_power_consumption.txt','^(1/2/2007|2/2/2007)',sep=';',stringsAsFactors=FALSE)
    } else {
        stop('File household_power_consumption.txt not found. Please download it from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip, uncompress it and try again')
    }
}

plot1 <- function(){
    data <- load_data()
    png('plot1.png')
    hist(data$Global_active_power, col='red',xlab='Global Active Power (kilowatts)',main='Global Active Power')
    dev.off()
}
