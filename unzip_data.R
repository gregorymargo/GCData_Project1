
# vim: set ts=8 sts=4 sw=4 et :
#
# Wed May 14 17:01:20 PDT 2014
# Gregory Margo
#
# Getting and Cleaning Data
# Course Project


# The project data is provided on the Coursera web site and also by
# the UCI Machine Learning Repository.

# This program assumes the data has already been download and
# just needs to be unzipped.


localName <- "UCI HAR Dataset.zip"

unzip(localName, exdir=".", setTimes=TRUE)
