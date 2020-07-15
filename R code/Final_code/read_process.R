# Downloading data
if(!file.exists('Data/')){
        dir.create('Data/')
        dir.create('Data/Raw_data')
}
if(!file.exists('Data/Raw_data/activity.zip')){
        fileURL <- 'https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip'
        download.file(fileURL, 
                      destfile = './Data/Raw_data/activity.zip',
                      method='curl')
}

# Loading the data
activity <- read.table(unz('Data/Raw_data/activity.zip',
                           'activity.csv'), header=T, sep = ',')
# Converting variable date to class (Date)
activity$date <- as.Date(activity$date)
# adding a new variable day to be used in imputting NAs Strategy
activity$day <- format(activity$date, '%a')
write.csv(activity,file='Data/Processed_data/activity.csv')
# Ignoring the missing values
# By using reshape2 package, melt() and dcast() are called to summraize the dataset
library(reshape2)
melted_activity <- melt(activity, id=c('date', 'day', 'interval'))
# Calculate the total number of steps taken per day
steps_per_day <- dcast(melted_activity, date~variable, sum, na.rm=T)
write.csv(steps_per_day,'Data/Processed_data/total_steps_per_day_1.csv')
# the average number of steps taken, averaged across all days
steps_per_interval <- dcast(melted_activity, interval~variable, mean, na.rm=T)
