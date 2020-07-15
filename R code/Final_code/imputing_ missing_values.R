source('R code/Final_code/read_process.R')

# Imputing missing values

#  Substitute the missing steps with the average 5-minute interval 
# based on the day of the week
cleaned_data <-activity[!is.na(activity$steps),]
melted_cleaned_data <- melt(cleaned_data, id=c('date', 'interval', 'day'))
avgTable <- dcast(melted_cleaned_data, day+interval~variable, mean)
NAs <- activity[is.na(activity$steps),]
merged <- merge(NAs , avgTable, by=c('day', 'interval'))[,-3]
names(merged)[4] <- 'steps'
imputted_activity <- rbind(merged, cleaned_data)
write.csv(imputted_activity, 'Data/Processed_data/imputted_activity.csv')
# the total number of steps taken each day
melted_imputted_activity <- melt(imputted_activity,
                                 id=c('day', 'date', 'interval'))
steps_per_day_2 <- dcast(melted_imputted_activity,
                         date~variable, sum)
write.csv(steps_per_day_2,'Data/Processed_data/total_steps_per_day_2.csv')
hist(steps_per_day_2$steps, col='grey', xlab = 'Steps', main='Histogram',
     sub='Figure 3    Histogram of total number of steps taken per day'
     , font.sub=2)
dev.copy(png, 'Figures/Final_figures/Figure 3.png')
dev.off()
# the average number of steps taken per 5-minute interval across weekdays and weekends
imputted_activity$dayType <- ifelse(imputted_activity$day %in% c('Sat', 'Sun'),
                                    'Weekend', 'Weekday')

melted_complete <- melt(imputted_activity, id=c('date', 'interval', 'day','dayType'))
casted_complete <- dcast(melted_complete,dayType+interval~variable, mean)
