source('R code/Final_code/imputing_ missing_values.R')


# Calculate the mean and median of the total number of steps taken per day
# imputing the missing values

steps_per_day_mean_2 <- mean(steps_per_day_2$steps)
steps_per_day_median_2 <- median(steps_per_day_2$steps)

average_steps_day_2 <- cbind(mean=steps_per_day_mean_2,
                           median=steps_per_day_median_2)
row.names(average_steps_day) <- 'Steps_per_day'
write.csv(average_steps_day, 'Data/Processed_data/average_steps_per_day_2.csv')
