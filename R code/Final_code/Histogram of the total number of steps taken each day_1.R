source('R code/Final_code/read_process.R')
# Creating a directory Figures/Final_figures
if(!file.exists('Figures')){
        dir.create('Figures')
        dir.create('Figures/Final_figures/')
}
# Make a histogram of the total number of steps taken each day
hist(steps_per_day$steps, main = 'Histogram', font.main=2,
     xlab='Steps', sub='Figure 1  Histogram of total number of steps taken per day', font.sub=2)
if(!file.exists('Figures')){
        dir.create('Figures')
        dir.create('Figures/Final_figures/')
}
# Saving the graph as png file
dev.copy(png,'Figures/Final_figures/Figure 1.png')
dev.off()