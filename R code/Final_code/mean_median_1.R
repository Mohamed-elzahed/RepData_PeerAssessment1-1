source('R code/Final_code/read_process.R')


# Calculate the mean and median of the total number of steps taken per day
# ignoring the missing values

steps_per_day_mean <- mean(steps_per_day$steps, na.rm = T)
steps_per_day_median <- median(steps_per_day$steps, na.rm = T)

average_steps_day <- cbind(mean=steps_per_day_mean,
                           median=steps_per_day_median)
row.names(average_steps_day) <- 'Steps_per_day'
write.csv(average_steps_day, 'Data/Processed_data/average_steps_per_day_1.csv')
