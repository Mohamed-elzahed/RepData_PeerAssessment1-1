source('R code/Final_code/imputing_ missing_values.R')
# Histogram of the total number of steps taken each day
# after missing values are imputed
hist(steps_per_day_2$steps, col='grey', xlab = 'Steps', main='Histogram',
     sub='Figure 3    Histogram of total number of steps taken per day'
     , font.sub=2)
dev.copy(png, 'Figures/Final_figures/Figure 3.png')
dev.off()
