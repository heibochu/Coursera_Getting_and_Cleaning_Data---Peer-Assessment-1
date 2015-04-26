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

Measurements found within the x data are in units of triaxial angular velocity and triaxial acceleration.

### Step 1 - Merges the training and the test sets to create one data set.
===========
The data is can be divided into three parts
* subject data: ID of person who performed an activity, ranged 1 to 30
* y data: ID of activity performed by subject
* x data: measurement data of subject performing activity, from an accelerometer using the Samsung Galaxy S smartphone.  Measurements found within the x data are in units of triaxial angular velocity and triaxial acceleration.

Each set of data is further subdivided into `training` and `test` components.  

In this step, `run_analysis.R` combines the test and training subdivisions into single, whole data sets using `rbind()`.

### Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
===========
The measurement data within the x data set contain many different kinds of measurements, each column representing an unnamed variable.

Using a data set called `features`, `run_analysis.R` names all columns and takes the subset of measures for `mean` and `standard deviation (std)`.

### Step 3 - Uses descriptive activity names to name the activities in the data set.
===========
The activities in the y data set are uniquely identified by ID.

`run_analysis.R` uses data from a data set called `activities` and mutates each ID into a descriptor describing the activity using `dplyr's` `inner_join()`.

### Step 4 - Appropriately labels the data set with descriptive variable names. 
===========
At this point, the x data, y data, and subject data sets are combined into one whole tidy data set using `cbind()`.  Each column is given a descriptor describing the variables they represent.

### Step 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
===========
The tidy data set that was created in Step 4 is then summarized using the `summarise_each` function from the `dplyr` package.  Each measure is averaged and grouped by 'subject' and 'activity'.
