# Loading and preprocessing the data
activity <- read.table(unz('Data/Raw_data/activity.zip', 'activity.csv'),
                       header=T, sep = ',')
activity$date <- as.Date(activity$date)
str(activity)

# What is mean total number of steps taken per day?
# 1.Calculate the total number of steps taken per day
library(reshape2)
melted_activity <- melt(activity, id=c('date', 'interval'))
steps_per_day <- dcast(melted_activity,
                       date~variable, sum, na.rm=T)
hist(steps_per_day$steps, sub='figure 1 ',xlab = 'Steps', 
     main=' The total number of steps taken per day',col.sub ='blue')
dev.copy(png, 'Figures/Exploratory_figures/figure 1.png')
dev.off()
steps_per_day_mean <- mean(steps_per_day$steps, na.rm = T)
steps_per_day_median<- median(steps_per_day$steps, na.rm = T)

# What is the average daily activity pattern?
#a time series plot ( of the 5-minute interval (x-axis) and the average number of steps taken,
#averaged across all days (y-axis)
steps_per_interval <- dcast(melted_activity,interval~variable,sum,na.rm=T)
with(steps_per_interval
           , plot(interval, steps, type='l',
     main='A time series plot of the 5-minute interval (x-axis) and \n the average number of steps taken
', sub='figure 2', col.sub='blue'))
dev.copy(png, 'Figures/Exploratory_figures/figure 2.png')
dev.off()
max_interval_ind <- which.max(steps_per_interval$steps)
max_interval <- steps_per_interval$interval[max_interval_ind]

x <- dcast(melted_activity, date+interval~variable, sum, na.rm=T)
y <- dcast(melted_activity, interval~variable, sum, na.rm=T)
hist(x$steps)
plot(y$steps, type = 'l')

xx <- function(x,y,z){
        dcast(x, y~z, sum, na.rm=T)   
}
xx(melted_activity, (melted_activity$date+melted_activity$interval), melted_activity$variable)
with(melted_activity, xx(date,variable))




















