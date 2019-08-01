# Getting-and-Cleaning-Data-Course-Project

Instructions to run the R script.

1) Source the R script
2) Execute getandcleananalysisdata() to get merged dataset with clean variable names

   ds <- getandcleananalysisdata()
   
3) Execute the gettidydatawithmean() to get the tidy data set with mean of the variable names for each subject. Pass the data set received from the above function

   tds <- gettidydatawithmean(ds)
