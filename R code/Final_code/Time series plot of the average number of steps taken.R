source('R code/Final_code/read_process.R')
# Make a time series plot  of the 5-minute interval (x-axis) 
# and the average number of steps taken, averaged across all days (y-axis)
plot(steps_per_interval$steps, type='l', xlab='Interval', ylab='Steps per 5-minute interval',
     sub='Figure 2   Line Plot', 
     main='Line plot of the 5-minute interval vs average number of steps taken,
     averaged across all days', font.sub=2)

dev.copy(png, 'Figures/Final_figures/Figure 2.png')
dev.off()