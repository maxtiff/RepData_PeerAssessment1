## Loading and preprocessing the data
 
# 1. Load the data (i.e. `read.csv()`)

  ## Unzip activity file.
  zipFilename <- "activity.zip"
  zipPath <- file.path(zipFilename)
  activityFile <- unzip(zipPath)
  
  ## Read in data file
  activityData <- read.csv(activityFile)
  

# 2. Process/transform the data (if necessary) into a format suitable for your analysis