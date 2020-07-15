source('R code/Final_code/imputing_ missing_values.R')
# Panel plot comparing the average number of steps taken per 5-minute interval across weekdays and weekends
library(lattice)
xyplot(steps~interval|dayType, data=casted_complete, type="l",  layout = c(1,2),
       main=" Panel plot", 
       ylab="Average Number of Steps", xlab="Interval",
       sub='Fig 4  Average Steps per Interval Based on Type of Day ', 
       col.sub='blue', font.sub=2)
dev.copy(png,'Figures/Final_figures/Fig 4.png')
dev.off()