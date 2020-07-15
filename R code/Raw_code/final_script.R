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
write.csv(steps_per_day,'Data/Processed_data/total_steps_per_day1.csv')
# Make a histogram of the total number of steps taken each day
hist(steps_per_day$steps, main = 'Histogram', font.main=2,
     xlab='Steps', sub='Figure 1  Histogram of total number of steps taken per day', font.sub=2)
    
# Saving the graph as png file
dev.copy(png,'Figures/Final_figures/figure_1.png')
dev.off()
# Calculate the mean and median of the total number of steps taken per day
steps_per_day_mean <- mean(steps_per_day$steps, na.rm = T)
steps_per_day_median <- median(steps_per_day$steps, na.rm = T)

# Make a time series plot  of the 5-minute interval (x-axis) 
# and the average number of steps taken, averaged across all days (y-axis)
steps_per_interval <- dcast(melted_activity, interval~variable, mean, na.rm=T)
plot(steps_per_interval$steps, type='l', xlab='Interval', ylab='Steps per 5-minute interval',
    sub='Figure 2   Line Plot', 
   main='Line plot of the 5-minute interval vs average number of steps taken,
     averaged across all days', font.sub=2)

dev.copy(png, 'Figures/Final_figures/Figure 2.png')
dev.off()
#Which 5-minute interval, on average across all the days in the dataset,
#contains the maximum number of steps?
max_interval_ind <- which.max(steps_per_interval$steps)
max_interval <- steps_per_interval[max_interval_ind]

# Imputing missing values
# he total number of missing values in the dataset
NA_rows <- nrow(activity[is.na(activity$steps),])
#  Substitute the missing steps with the average 5-minute interval 
# based on the day of the week
cleand_data <-activity[!is.na(activity$steps),]
avgTable <- dcast(cleand_data, day+interval~variable, mean)
NAs <- activity[is.na(activity$steps),]
merged <- merge(NAs , avgTable, by=c('day', 'interval'))[,-3]
names(merged)[4] <- 'steps'
imputted_activity <- rbind(merged, cleand_data)
write.csv(imputted_activity, 'Data/Processed_data/imputted_activity.csv')
# Make a histogram of the total number of steps taken each day
melted_imputted_activity <- melt(imputted_activity,
                                 id=c('day', 'date', 'interval'))
steps_per_day_2 <- dcast(melted_imputted_activity,
                         date~variable, sum)
hist(steps_per_day_2$steps, col='grey', xlab = 'Steps', main='Histogram',
     sub='Figure 3    Histogram of total number of steps taken per day'
     , font.sub=2)
dev.copy(png, 'Figures/Final_figures/Figure 3.png')
dev.off()
# Calculate and report the mean and median of the total number of steps taken per day
steps_per_day_mean_2 <- mean(steps_per_day_2$steps)
steps_per_day_median_2 <- median(steps_per_day_2$steps)
# Create a new factor variable in the dataset with two levels – 
# “weekday” and “weekend” indicating whether a given date is a weekday or weekend day.
imputted_activity$dayType <- ifelse(imputted_activity$day %in% c('Sat', 'Sun'),
                                    'Weekend', 'Weekday')
write.csv(imputted_activity, 'Data/Processed_data/imputted_activity_dayType.csv')

# Make a panel plot containing a time series plot of the 5-minute interval (x-axis) and the average number of steps taken,
# averaged across all weekday days or weekend days (y-axis)
library(lattice)
melted_complete <- melt(imputted_activity, id=c('date', 'interval', 'day','dayType'))
casted_complete <- dcast(melted_complete,dayType+interval~variable, mean)
xyplot(steps~interval|dayType, data=casted_complete, type="l",  layout = c(1,2),
       main=" Panel plot", 
       ylab="Average Number of Steps", xlab="Interval",
       sub='Fig 4  Average Steps per Interval Based on Type of Day ', 
       col.sub='blue', font.sub=2)
dev.copy(png,'Figures/Final_figures/Fig 4.png')
dev.off()
