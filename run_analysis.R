# Week 3 - Getting and Cleaning Data project

# use dplyr package for data merging
library(dplyr)

# get current directory. Assume that data and figure folders are subdirectories of current directory.
dir.curr <- getwd()
dir.data <- './data'
dir.datasource <- file.path(dir.data, 'UCI HAR Dataset')

# unzipped contents of zip file, assumed to be in data folder
datafile <- file.path(dir.datasource)

# searches for existence of rds data file in data subdirectory.  if none is found, will download zip from URL
if (!file.exists(datafile)) {
  # create data and figure folders, ignore errors if they already exist
  dir.create(dir.data, showWarnings = FALSE)
  
  fileURL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
  zipfile <- file.path(dir.data, basename(fileURL))
  
  # download zip file to data folder and unzip text file in data folder
  download.file(fileURL, destfile = zipfile)
  unzip(zipfile, exdir = dir.data)
  
}


### Step 1 - Merges the training and the test sets to create one data set ###

# compile test data for x, y, and subject
test.x <- read.table(file.path(dir.datasource, 'test/X_test.txt'))
test.y <- read.table(file.path(dir.datasource, 'test/y_test.txt'))
test.subject <- read.table(file.path(dir.datasource, 'test/subject_test.txt'))

# compile train data for x, y, and subject
train.x <- read.table(file.path(dir.datasource, 'train/X_train.txt'))
train.y <- read.table(file.path(dir.datasource, 'train/y_train.txt'))
train.subject <- read.table(file.path(dir.datasource, 'train/subject_train.txt'))

# combine data for test and train data sets
data.x <- rbind(test.x, train.x)
data.y <- rbind(test.y, train.y)
data.subject <- rbind(test.subject, train.subject)

# clean up unneeded objects
rm(test.x, test.y, test.subject, train.x, train.y, train.subject)

### Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement ###

# read features data table
data.feat <- read.table(file.path(dir.datasource, 'features.txt'))
feat.names <- as.character(data.feat[, 2])

# true/false vector getting only values with std() or mean()
feat.meanstd <- grepl('mean[12()]|std[12()]', feat.names)

# name the columns in the x data set and subset it using the logical vector that looked for std() and mean()
names(data.x) <- feat.names
data.xformatted <- data.x[, feat.meanstd]

# clean up unneeded objects
rm(feat.meanstd, feat.names, data.feat)

### Step 3 - Uses descriptive activity names to name the activities in the data set ###

# read activity table
data.activity <- read.table(file.path(dir.datasource, "activity_labels.txt"))
names(data.y) <- c('activity_ID')
names(data.activity) <- c('activity_ID', 'activity')

# merge y data with activity names
data.yformatted <- inner_join(data.y, data.activity, by = 'activity_ID')

# use only activity column
data.yformatted <- subset(data.yformatted, select = c(activity))

# clean up unneeded objects
rm(data.activity)


### Step 4 - Appropriately label the data set with descriptive variable names ###

# name subject column name
names(data.subject) <- "subject"

# combine data into one data set
data.full <- cbind(data.subject, data.yformatted, data.xformatted)

### Step 5 - Create a second, independent tidy data set with the average of each variable 
###           for each activity and each subject

# find average of every variable, grouping by activity and subject
data.avg <- data.full %>% group_by(subject, activity) %>% summarise_each(funs(mean))

# write final data set to a text file
write.table(data.avg, "data_avg.txt", row.name=FALSE)
