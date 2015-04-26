Coursera - Getting and Cleaning Data
Week 3 Peer Assessments

Introduction
===========

The purpose of this study is to transform raw data into a tidy data set, using the concepts and principles introduced within the online Coursera course `Getting and Cleaning Data`.

The raw data was compiled by a study performed by UCI, the full details of this study can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The actual compiled data is available within a zip file, available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).


The R script `run_analysis.R` (with the R package `dplyr`) takes the data  and transforms it based on the below steps:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The R script assumes that the file can be run, as is, within a working directory.  No renaming of files should be done by the user.

As the data sets do not have parent - foreign keys linking them together, the raw data is assumed to be ordered correctly as is (ie., x data, y data, and subject data are all matched correctly in their raw form).

Measurements found within the x data is in units of triaxial angular velocity.

### Step 1 - Merges the training and the test sets to create one data set.
===========
* `test.x`, `test.y`, `test.subject`: dataframes representing test data of the study
* `train.x`, `train.y`, `train.subject`: dataframes representing training data of the study
* `data.x`, `data.y`, `data.subject`: dataframes which combine the test and training data sets into one

### Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
===========
* `data.feat`: dataframe which represents the measurement descriptor for the 561 measurements in the x data set.
* `data.xformatted`: the x data set `data.x`, with named columns, subsetted strictly to mean and std data.

### Step 3 - Uses descriptive activity names to name the activities in the data set.
===========
* `data.activity`: dataframe which represents the 6 activities that were performed within the y data set.
* `data.yformatted`: the y data set `data.y`, with named columns, the activity ID's mutated to actual descriptors.

### Step 4 - Appropriately labels the data set with descriptive variable names. 
===========
* `data.full`: dataframe which represents a tidy data set combining `data.xformatted`, `data.yformatted`, and`data.subject`

### Step 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
===========
* `data.avg`: dataframe which summarizes `data.full` by getting the average mean of all measurement variables, grouped by subject and activity.
