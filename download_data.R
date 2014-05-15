
# vim: set ts=8 sts=4 sw=4 et :
#
# Sun May 11 10:58:59 PDT 2014
# Gregory Margo
#
# Getting and Cleaning Data
# Course Project


# The project data is provided on the Coursera web site and also by
# the UCI Machine Learning Repository.


# Original Dataset, as provided by the project description.
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
dataURL_Coursera <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Original Dataset, from its original souurce
# http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip
dataURL_UCI <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip"


# As both of these dataset locations provides the same dataset, pick one or the other:
dataURL <- dataURL_UCI		# Let's try the UCI one

# Give it a good local name
localName <- "UCI HAR Dataset.zip"

download.file(dataURL, destfile=localName, method="internal", mode="wb")
