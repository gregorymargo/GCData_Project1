## Getting and Cleaning Data Course Project

This repository represents the course project for the **Getting and Cleaning Data** class
given by **Johns Hopkins** through the **Coursera** platform.

### When, Where, Why, Who?

This work was performed for the third session of the **Getting and Cleaning Data** class,
[https://class.coursera.org/getdata-003](https://class.coursera.org/getdata-003),
which began May 05 2014.
This work was completed on or before the due date of May 25 2014.
All of the work within is original code and text by Gregory Margo.

### What Are All These Files?

There are several files included here.
Some are required files for this project, while others are optional but helpful.

Project files:

- CodeBook.md - A description of all data manipulations performed.
- download_data.R - An R script to download data from the original source.
- ProjectDescription.txt - The project description, copied from the official assignment page.
- README.md - A description of this repository and all the files within it.
- run_analysis.R - An R script to analyze the input data and produce the tidy output data.
- unzip_data.R - An R script to unzip the downloaded data.

### Content Of Dataset

The resultant dataset, saved as a file named "means.csv" contains mean values of
all combinations of subject and activity.
See CodeBook.md for full details.

### How To Run The Script

The R script is named 'run_analysis.R'.
One could run the script from within R using 'source("run_analysis.R")',
or one could run the script from the command line using 'Rscript run_analysis.R'.

### What The Script Does

The script reads, isolates, and summarizes the smart phone data to produce "means.csv".

