
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
# Global data management.
#------------------------------------------------------------------------------
print("Reading Global data")

# Each activity has an id
activity_labels <- read.table(
    file.path(dataDir, "activity_labels.txt"),
    header = FALSE,
    colClasses = c("integer", "character"),
    col.names = c("activityId", "activityDesc"))

# Each feature has an id
feature_labels <- read.table(
    file.path(dataDir, "features.txt"),
    header = FALSE,
    colClasses = c("integer", "character"),
    col.names = c("featureId", "featureDesc"))

#------------------------------------------------------------------------------
# Create user friendly feature labels.

# Steps to clean featureDesc names:
#  - Remove the function-type parentheses "()" entirely.
#  - Replace dashes with periods.
#  - Replace commas with periods.
#  - Replace "angle(" with "angleOf."
#  - Remove any remaining single parentheses.
#    (Observation 556 has unbalanced parentheses, plus the "angle(" substitution
#    creates more unbalanced parentheses.)
#  - Ensure that same number of unique feature names remain as originally.
#    (Since there are duplicate feature names in the original, this check is not
#    the same as just comparing to the number of features.)
#
# The "before" and "after" (aka "featureDesc" and "featureDescMod") are depicted
# below on a set selected to (hopefully) represent all possible name types.
#
# > feature_labels[c(1,4,26,66,210,335,555,556,561), ]
#     featureId                          featureDesc                       featureDescMod
# 1           1                    tBodyAcc-mean()-X                      tBodyAcc.mean.X
# 4           4                     tBodyAcc-std()-X                       tBodyAcc.std.X
# 26         26               tBodyAcc-arCoeff()-X,1                 tBodyAcc.arCoeff.X.1
# 66         66            tGravityAcc-arCoeff()-X,1              tGravityAcc.arCoeff.X.1
# 210       210               tBodyAccMag-arCoeff()1                 tBodyAccMag.arCoeff1
# 335       335         fBodyAcc-bandsEnergy()-33,40           fBodyAcc.bandsEnergy.33.40
# 555       555          angle(tBodyAccMean,gravity)         angleOf.tBodyAccMean.gravity
# 556       556 angle(tBodyAccJerkMean),gravityMean) angleOf.tBodyAccJerkMean.gravityMean
# 561       561                 angle(Z,gravityMean)                angleOf.Z.gravityMean

desc <- feature_labels$featureDesc

unique_count <- length(unique(desc))
desc <- gsub("()", "", desc, fixed=TRUE)
desc <- gsub("-", ".", desc, fixed=TRUE)
desc <- gsub(",", ".", desc, fixed=TRUE)
desc <- gsub("angle(", "angleOf.", desc, fixed=TRUE)
desc <- gsub(")", "", desc, fixed=TRUE)
desc <- gsub("(", "", desc, fixed=TRUE)
stopifnot(unique_count == length(unique(desc)))

feature_labels$featureDescMod <- desc
rm(desc, unique_count)


#------------------------------------------------------------------------------
# 2. Extracts only the measurements on the mean and standard deviation for each
#    measurement.
#------------------------------------------------------------------------------
# According to the data dictionary ("features_info.txt"), the mean and
# standard deviation are represented by features with:
#   mean(): Mean value
#   std(): Standard deviation
f_mean_cols <- grep("mean()", feature_labels$featureDesc, fixed = TRUE)
f_std_cols  <- grep("std()",  feature_labels$featureDesc, fixed = TRUE)
f_cols <- sort(append(f_mean_cols, f_std_cols))
f_cols_names <- sub("^", "V", f_cols)       # default name is 'Vn+' with read.table
rm(f_mean_cols, f_std_cols)
# "f_cols" is the list of feature numbers that interest us.
# "f_cols_names" is the list of feature names that interest us.


#-------------------- TEST data -----------------------------
print("Reading Test data")

# Each observation is associated with a subject id.
subject_test <- read.table(
    file.path(dataDir, "test", "subject_test.txt"),
    header = FALSE,
    colClasses = c("integer"),
    col.names = c("subjectId"))

# Each observation is associated with an activity id.
y_test <- read.table(
    file.path(dataDir, "test", "y_test.txt"),
    header = FALSE,
    colClasses = c("integer"),
    col.names = c("activityId"))

# Each observation has 561 measurement variables (aka "features").
X_test <- read.table(
    file.path(dataDir, "test", "X_test.txt"),
    header = FALSE,
    colClasses = c("numeric"))

# Isolate only those columns that interest us.
X_test <- X_test[, f_cols_names]

# Build the dataset for the test data:
dataset_test <- cbind(subject_test, y_test, X_test)


#-------------------- TRAIN data -----------------------------
# Repeat the same steps as above but for the training data.
print("Reading Train data")

# Each observation is associated with a subject id.
subject_train <- read.table(
    file.path(dataDir, "train", "subject_train.txt"),
    header = FALSE,
    colClasses = c("integer"),
    col.names = c("subjectId"))

# Each observation is associated with an activity id.
y_train <- read.table(
    file.path(dataDir, "train", "y_train.txt"),
    header = FALSE,
    colClasses = c("integer"),
    col.names = c("activityId"))

# Each observation has 561 measurement variables (aka "features").
X_train <- read.table(
    file.path(dataDir, "train", "X_train.txt"),
    header = FALSE,
    colClasses = c("numeric"))

# Isolate only those columns that interest us.
X_train <- X_train[, f_cols_names]

# Build the dataset for the train data:
dataset_train <- cbind(subject_train, y_train, X_train)


#-------------------- COMBINED data -----------------------------
print("Combining Test+Train data")
# Concatenate the test and training data
dataset <- rbind(dataset_test, dataset_train)

# Sort to gather all related data together.  Not really needed.
dataset <- dataset[order(dataset$subjectId, dataset$activityId), ]

# Reset row names automatic sequence for prettiness after sort.
row.names(dataset) <- NULL

# Assign new column names, replacing "Vn+" with the featureDescMod string.
names(dataset) <- append(c("subjectId", "activityId"), feature_labels[f_cols, "featureDescMod"])


# "dataset" is now a "tidy data" representation of the test+train data of the columns we want.
# It does not contain the activity descriptions yet.


#------------------------------------------------------------------------------
# 5. Creates a second, independent tidy data set with the average of each
#    variable for each activity and each subject.
#------------------------------------------------------------------------------
print("Generating Means by subject+activity")

y <- aggregate(dataset, by=list(dataset$subjectId, dataset$activityId), FUN=mean, simplify=FALSE)
z <- aggregate(dataset, by=list(dataset$activityId, dataset$subjectId), FUN=mean, simplify=FALSE)

# Merge y_test and "activity_labels" so both the id and string are present
#activity_test <- merge(y_test, activity_labels, by=c("activityId"))
# Merge y_train and "activity_labels" so both the id and string are present
#activity_train <- merge(y_train, activity_labels, by=c("activityId"))
#names(dataset) <- append(c("subjectId", "activityId", "activityDesc"), feature_labels[f_cols, "featureDescMod"])
