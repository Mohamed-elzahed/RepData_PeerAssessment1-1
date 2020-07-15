# Processed Data

## The files in the Processed Data directory are:  

- ***activity.csv***: after downlaoding the dataset [ Activity monitoring data](https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip), by calling *write.csv* function. The variables included in this dataset are:  

  - **steps**: Number of steps taking in a 5-minute interval (missing values are coded as NA)  
  - **date**: The date on which the measurement was taken in YYYY-MM-DD format
  - **interval**: Identifier for the 5-minute interval in which measurement was taken
  - **day**: The week day on which the measuremnt was taken. it will be helpful for imputing tne NAs strategy.
  
- ***average_steps_per_day_1.csv and average_steps_per_day_2.csv***: The mean and median of total number of steps taken per day for both ignoring and imputting NAs.  
- ***imputted_activity.csv***: The activity dataset after imputting the missing values.  
- ***imputted_activity_dayType***: The activity dataset after adding day type indicating whether a given date is a weekday or weekend day.  
- ***Max_interval_across_averaged_days.csv***: showing which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps.
- ***total_steps_per_day1.csv and total_steps_per_day_2***:  The total number of steps taken per day for both ignoring and imputting the missing values.