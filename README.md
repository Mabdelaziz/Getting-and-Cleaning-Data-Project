# Getting & Cleaning Data Project
Github repo as work required for Getting and Cleaning Data course Project -Peer Assessment

**The goal is to prepare tidy data that can be used for later analysis.**

Files List : 

  - Run_analysis.R : r - code script for reading and preparing data set.

  - Activity_ subject_avgs.txt :  Tidy data set with the average of each variable for each activity and each subject.

  - CodeBook.md : headers for result data set 


[Data for the project could be downloaded here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

R script called run_analysis.R that does the following:

1.  Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names. 
5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


##Processing :

1.	Prepare the working environment, ensure data existence , and  load required libraries 
2.	Load measurements and results Data sets into R.
  -	Training Data set ( features measurements (X) file , and label (Y)).
  -	Test Data Set   ( features measurements (X) file , and label (Y)).
  -  Subject Data sets for test and training data sets.
3.	Load Meta data sets, including features names, activities lookup.
4.	Performs merge for the train and test data sets including subject data.
5.	Get measurements on the mean and standard deviation.
6.	Uses descriptive activity names to name the activities in the data set.
7.	Performs  averages groups aggregation for measurements on activity and Subject.
8.  Prints the result data set out to a text file..


