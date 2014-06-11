#### Loading and preprocessing the data

# i. Source libraries, functions, etc.
  library(ggplot2)

# 1. Load the data (i.e. `read.csv()`)

  ## Unzip activity file.
  zipFilename <- "activity.zip"
  zipPath <- file.path(zipFilename)
  activityFile <- unzip(zipPath)
  
  ## Read in data file, retain 'NA' values
  activityRaw <- read.csv(activityFile)
  
# 2. Process/transform the data (if necessary) into a format suitable for your analysis
  
  ## Create dataset without 'NA' values.
  activityRemoveNA <- na.omit(activityRaw)
  
  ## Transform data into table of total number of steps per day.
  activityDay <- aggregate(activityRemoveNA$steps,by=list(activityRemoveNA$date),sum)
  colnames(activityDay) <- c('date','totalSteps')
  activityDay$date <- as.Date(activityDay$date)
  
  
#### What is mean total number of steps taken per day?
  
# 1. Make a histogram of the total number of steps taken each day
  png(filename="totalSteps.png", width=480, height=480)
  hist(activityDay$totalSteps, main = "Steps Per Day",col="red",xlab="Steps", ylab="Frequency",breaks=10)
  dev.off()
  
# 2. Calculate and report the **mean** and **median** total number of steps taken per day
  meanSteps <- mean(activityDay$totalSteps)
  print(paste("Mean total number of steps per day: ",meanSteps))
  medianSteps <- median(activityDay$totalSteps)
  print(paste("Median total number of steps per day: ",medianSteps))
  
  
#### What is the average daily activity pattern?
  
# 1. Make a time series plot (i.e. `type = "l"`) of the 5-minute interval (x-axis) and the average number of steps taken, averaged across all days (y-axis)
  
  ## Transform data into table of average number of steps per interval
  activityInterval <- aggregate(activityRemoveNA$steps, by=list(activityRemoveNA$interval),mean)
  colnames(activityInterval) <- c('interval','averageSteps')
  
  ## Plot time series graph of average number of steps taken per interval across all days.
  g <- ggplot(activityInterval, aes(interval, averageSteps))
  g + geom_line(aes( y = averageSteps ), colour="#368BC1",size = 1) + xlab("Interval") + ylab("Average Steps") + ggtitle("Average Number of Steps Per Interval")
  ggsave(filename="meanSteps.png", width=4.80, height=4.80, dpi = 100)
  
# 2. Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?
  maxMeanInterval <- activityInterval[max(activityInterval$averageSteps),]
  print(paste("Interval",maxMeanInterval$interval,"has the most average steps with",maxMeanInterval$averageSteps,sep=" "))

  
#### Imputing missing values

# Note that there are a number of days/intervals where there are missing
# values (coded as `NA`). The presence of missing days may introduce
# bias into some calculations or summaries of the data.
  
# 1. Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with `NA`s)
  missings <- is.na(activityRaw)
  sumMissings <- sum(missings)
  print(paste("There are",sumMissings,"rows with missing observations.", sep=" "))
 
# 2. Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. 
#    For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc.
  
  
# 3. Create a new dataset that is equal to the original dataset but with the missing data filled in.
   
# 4. Make a histogram of the total number of steps taken each day and Calculate and report the **mean** and **median** total 
#    number of steps taken per day. Do these values differ from the estimates from the first part of the assignment? 
#    What is the impact of imputing missing data on the estimates of the total daily number of steps?


#### Are there differences in activity patterns between weekdays and weekends?
  
#   For this part the `weekdays()` function may be of some help here. Use
#   the dataset with the filled-in missing values for this part.
   
#   1. Create a new factor variable in the dataset with two levels -- "weekday" and "weekend" indicating whether a given date is a weekday or weekend day.
   
#   2. Make a panel plot containing a time series plot (i.e. `type = "l"`) of the 5-minute interval (x-axis) and the average number of steps taken, 
#      averaged across all weekday days or weekend days (y-axis). The plot should look something like the following, which was creating using **simulated data**:
  
  