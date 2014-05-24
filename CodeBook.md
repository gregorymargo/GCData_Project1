## CodeBook for:
## Getting and Cleaning Data Course Project

This file describes the format and generation of the submitted "tidy dataset"
which represents the means of all the means and standard deviation measurements
in the original data.

### Original Data

The original dataset license requires this publication reference:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.<br/>
Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine.<br/>
International Workshop of Ambient Assisted Living (IWAAL 2012).<br/>
Vitoria-Gasteiz, Spain. Dec 2012<br/>

The original dataset is available from these links:

[http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI HAR Dataset.zip](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip)<br/>
[https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI HAR Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI%20HAR%20Dataset.zip)

### Activity Labels

The measurements consist of multiple measurements across 30 subjects and 6 activities.
The activity descriptions (and original activity identifier) are specified through
the "activity_labels.txt" file from the original .zip file, and are:

<pre>
activityId       activityDesc
         1            WALKING
         2   WALKING_UPSTAIRS
         3 WALKING_DOWNSTAIRS
         4            SITTING
         5           STANDING
         6             LAYING
</pre>

### Naming Strategy

The instruction for this class would have one believe that lower-case variable
names are good, which is, of course, foolish.  Mixed case vastly improves
readability.

Also the "recommendations" recommend avoiding periods (".") as a separator
character.  This too is foolish.  Period is just about the only ascii character
that can be used as a separator, since comma and space must be avoided.

Here is a summary of the steps take to "clean" the variable names into more
user friendly (and R friendly) names.  The original variable names
(aka "features") are taken from "features_info.txt" in the original .zip file.

Steps to clean featureDesc names:

- Remove the function-type parentheses "()" entirely.
- Replace dashes with periods.
- Replace commas with periods.
- Replace "angle(" with "angleOf."
- Remove any remaining single parentheses.
  (Observation 556 has unbalanced parentheses, plus the "angle(" substitution
  creates more unbalanced parentheses.)
- Ensure that same number of unique feature names remain as originally.
  (Since there are duplicate feature names in the original, this check is not
  the same as just comparing to the number of features.)

Here is an example of the "before" and "after" variable naming:

<!-- feature_labels[c(1,4,26,66,210,335,555,556,561), c("featureDesc", "featureDescMod")] -->
<pre>
                         featureDesc                       featureDescMod
                   tBodyAcc-mean()-X                      tBodyAcc.mean.X
                    tBodyAcc-std()-X                       tBodyAcc.std.X
              tBodyAcc-arCoeff()-X,1                 tBodyAcc.arCoeff.X.1
           tGravityAcc-arCoeff()-X,1              tGravityAcc.arCoeff.X.1
              tBodyAccMag-arCoeff()1                 tBodyAccMag.arCoeff1
        fBodyAcc-bandsEnergy()-33,40           fBodyAcc.bandsEnergy.33.40
         angle(tBodyAccMean,gravity)         angleOf.tBodyAccMean.gravity
angle(tBodyAccJerkMean),gravityMean) angleOf.tBodyAccJerkMean.gravityMean
                angle(Z,gravityMean)                angleOf.Z.gravityMean
</pre>

### Variable Selection Method

The UCI dataset is composed of movement measurements that were recorded using
the sensors in a smart phone.
Many of these measurements have been summarized by "mean" and "standard deviation" (aka "std").
Many of the other measurements are unrelated or are accounted for in the summaries.
All of the measurements containing "mean()" or "std()" in their names were selected for this study.

The original names of all the variables may be viewed in the "features_info.txt" file
contained in the "UCI HAR Dataset.zip" zip file.

### Results

The measurements are measures of multiple experiments on 30 subjects across 6 different activities.
So for each combination of one subject and one activity, there are many individual mean/std measurements.
This study produces means of each combination's multiple mean/std measurements.
This yields 30 * 6 = 180 rows in the summary statistics table.
The resultant data is printed into a file "means.csv" as a comma-separated-value table.

### Variables

1. "subjectId"                
2. "activityDesc"             
3. "tBodyAcc.mean.X"          
4. "tBodyAcc.mean.Y"          
5. "tBodyAcc.mean.Z"          
6. "tBodyAcc.std.X"           
7. "tBodyAcc.std.Y"           
8. "tBodyAcc.std.Z"           
9. "tGravityAcc.mean.X"       
10. "tGravityAcc.mean.Y"       
11. "tGravityAcc.mean.Z"       
12. "tGravityAcc.std.X"        
13. "tGravityAcc.std.Y"        
14. "tGravityAcc.std.Z"        
15. "tBodyAccJerk.mean.X"      
16. "tBodyAccJerk.mean.Y"      
17. "tBodyAccJerk.mean.Z"      
18. "tBodyAccJerk.std.X"       
19. "tBodyAccJerk.std.Y"       
20. "tBodyAccJerk.std.Z"       
21. "tBodyGyro.mean.X"         
22. "tBodyGyro.mean.Y"         
23. "tBodyGyro.mean.Z"         
24. "tBodyGyro.std.X"          
25. "tBodyGyro.std.Y"          
26. "tBodyGyro.std.Z"          
27. "tBodyGyroJerk.mean.X"     
28. "tBodyGyroJerk.mean.Y"     
29. "tBodyGyroJerk.mean.Z"     
30. "tBodyGyroJerk.std.X"      
31. "tBodyGyroJerk.std.Y"      
32. "tBodyGyroJerk.std.Z"      
33. "tBodyAccMag.mean"         
34. "tBodyAccMag.std"          
35. "tGravityAccMag.mean"      
36. "tGravityAccMag.std"       
37. "tBodyAccJerkMag.mean"     
38. "tBodyAccJerkMag.std"      
39. "tBodyGyroMag.mean"        
40. "tBodyGyroMag.std"         
41. "tBodyGyroJerkMag.mean"    
42. "tBodyGyroJerkMag.std"     
43. "fBodyAcc.mean.X"          
44. "fBodyAcc.mean.Y"          
45. "fBodyAcc.mean.Z"          
46. "fBodyAcc.std.X"           
47. "fBodyAcc.std.Y"           
48. "fBodyAcc.std.Z"           
49. "fBodyAccJerk.mean.X"      
50. "fBodyAccJerk.mean.Y"      
51. "fBodyAccJerk.mean.Z"      
52. "fBodyAccJerk.std.X"       
53. "fBodyAccJerk.std.Y"       
54. "fBodyAccJerk.std.Z"       
55. "fBodyGyro.mean.X"         
56. "fBodyGyro.mean.Y"         
57. "fBodyGyro.mean.Z"         
58. "fBodyGyro.std.X"          
59. "fBodyGyro.std.Y"          
60. "fBodyGyro.std.Z"          
61. "fBodyAccMag.mean"         
62. "fBodyAccMag.std"          
63. "fBodyBodyAccJerkMag.mean" 
64. "fBodyBodyAccJerkMag.std"  
65. "fBodyBodyGyroMag.mean"    
66. "fBodyBodyGyroMag.std"     
67. "fBodyBodyGyroJerkMag.mean"
68. "fBodyBodyGyroJerkMag.std" 

<!-- vim: set ts=8 sts=4 sw=4 et ft=markdown : -->
