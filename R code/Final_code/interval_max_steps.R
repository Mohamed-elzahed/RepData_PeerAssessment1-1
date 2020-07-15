source('R code/Final_code/read_process.R')

#Which 5-minute interval, on average across all the days in the dataset,
#contains the maximum number of steps?
max_interval_ind <- which.max(steps_per_interval$steps)
max_interval <- steps_per_interval$interval[max_interval_ind]

maxTable <- cbind(max_interval_ind,max_interval)
colnames(maxTable) <- c('index', 'Max_interval')
rownames(maxTable) <- c('Max interval across averaged days')
write.csv(maxTable,'Data/Processed_data/Max interval across averaged days.csv')
