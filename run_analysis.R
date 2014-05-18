
#------------------------------------------------------------------------------
# vim: set ts=8 sts=4 sw=4 et :
#
# Sun May 11 10:40:02 PDT 2014
# Gregory Margo
#
# Getting and Cleaning Data
# Course Project

#------------------------------------------------------------------------------
# Goals for run_analysis.R:
#
# Create one R script called run_analysis.R that does the following.
#
# 1. Merges the training and the test sets to create one data set.
#
# 2. Extracts only the measurements on the mean and standard deviation for each
#    measurement.
#
# 3. Uses descriptive activity names to name the activities in the data set
#
# 4. Appropriately labels the data set with descriptive activity names.
#
# 5. Creates a second, independent tidy data set with the average of each
#    variable for each activity and each subject.

#------------------------------------------------------------------------------
# Presume that the dataset has already been downloaded
# and unzipped into a directory named "UCI HAR Dataset".
#
# If the dataset is not downloaded or not unzipped, see
# the "download_data.R" and "unzip_data.R" programs.

dataDir <- "UCI HAR Dataset"


#------------------------------------------------------------------------------
# 1. Merges the training and the test sets to create one data set.
#------------------------------------------------------------------------------

#-------------------- GLOBAL data -----------------------------
# Each activity has an id
activity_labels <- read.table(
    paste0(dataDir, "/activity_labels.txt"),
    header = FALSE,
    colClasses = c("integer", "character"),
    col.names = c("activityId", "activityDesc"))

#-------------------- TEST data -----------------------------
# Each subject has an id
subject_test <- read.csv(
    paste0(dataDir, "/test/subject_test.txt"),
    header = FALSE,
    colClasses = c("integer"),
    col.names = c("subjectId"))

# y_test is an integer representing the activity (1-6)
y_test <- read.csv(
    paste0(dataDir, "/test/y_test.txt"),
    header = FALSE,
    colClasses = c("integer"),
    col.names = c("activityId"))

# X_test is the bulk measurement data.
X_test <- read.table(
    paste0(dataDir, "/test/X_test.txt"),
    header = FALSE,
    colClasses = c("numeric"))

# Merge y_test and "activity_labels" so both the id and string are present
activity_test <- merge(y_test, activity_labels, by=c("activityId"))

# Build the dataset vector for the test data:
dataset_test <- cbind(subject_test, activity_test, X_test)

#-------------------- TRAIN data -----------------------------
# Repeat the same steps as above but for the training data.

# Each subject has an id
subject_train <- read.csv(
    paste0(dataDir, "/train/subject_train.txt"),
    header = FALSE,
    colClasses = c("integer"),
    col.names = c("subjectId"))

# y_train is an integer representing the activity (1-6)
y_train <- read.csv(
    paste0(dataDir, "/train/y_train.txt"),
    header = FALSE,
    colClasses = c("integer"),
    col.names = c("activityId"))

# X_train is the bulk measurement data.
X_train <- read.table(
    paste0(dataDir, "/train/X_train.txt"),
    header = FALSE,
    colClasses = c("numeric"))

# Merge y_train and "activity_labels" so both the id and string are present
activity_train <- merge(y_train, activity_labels, by=c("activityId"))

# Build the dataset vector for the train data:
dataset_train <- cbind(subject_train, activity_train, X_train)

#-------------------- COMBINED data -----------------------------
# Concatenate the test and training data
dataset <- rbind(dataset_test, dataset_train)

# Sort to gather all related data together.  Not really needed.
dataset <- dataset[ order(dataset$subjectId, dataset$activityId, dataset$V1, dataset$V2), ]
