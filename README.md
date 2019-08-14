# Getting-and-Cleaning-Data-Course-Project

## Instructions for running the R script.

1) Source the R script
2) Execute getandcleananalysisdata() to get merged dataset with clean variable names

   ds <- getandcleananalysisdata()
   

## Documentation

The following are the files read by the R script.

1. features.txt contains the names of the variables
2. activity_labels.txt contains the labels for the activity codes
3. train/X_train.txt contains the training data
4. train/y_train.txt contains the training data activity codes
5. train/subject_train.txt contains the training subjects
6. test/X_test.txt contains the test data
7. test/y_test.txt contains the test data activity codes
8. test/subject_test.txt contains the test subjects

This R script is made up of 6 functions.

1. getandcleananalysisdata: This function merges the training and test datasets 
into one dataset with clean variables names. Calls other functions to merge the
data sets, extract the required columns, clean the variable names and calculate the
average of each variable for each activity and each subject 

2. gettidydatawithmean: This function creates a new dataset with the average of 
each variable for each activity and each subject

3. mergedatasets: This function assumes the data is extracted into the current 
directory.
    * Reads the features file for variable names
    * Reads the training data, activities & subjects and combines into a data frame
    * Reads the test data, activities & subjects and combines into a data frame
    * Combines the training and test data frames into one
    
4. extractmeanandstd: This function extracts the subject, activity code, mean & standard deviation columns 
from the merged dataset.

5. cleannames: This function cleans the variable names of the extracted dataset

6. downloadandextract: This function downloads the zip file and extracts to the current directory
