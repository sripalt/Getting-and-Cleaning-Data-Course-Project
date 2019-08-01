# This function merges the training and test datasets into one dataset
# with clean variables names 

getandcleananalysisdata <- function() {
    downloadandextract()
    finaldf <- mergedatasets() %>% extractmeanandstd() %>% cleannames()
    finaldf
}

# This function creates a new tidy dataset from the merged dataset
# with the average of each variable for each activity and each subject

gettidydatawithmean <- function(dataset) {
    dataset1 <- aggregate(dataset[,names(dataset) != "subject"], list(subject=dataset$subject), mean)
    dataset1 <- gather(dataset1, "variablename", "mean", -subject)
    dataset1
}

# This function downloads the zip file and extracts to the current directory

downloadandextract <- function() {
    temp <- tempfile()
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
    unzip (temp, exdir = "./")
}


# This function assumes the data is extracted into the current directory.
# 1) Reads the features file for variable names
# 2) Reads the training data & subjects and combines into a data frame
# 3) Reads the test data & subjects and combines into a data frame
# 4) Combines the training and test data frames into one

mergedatasets <- function() {
    features <- read.table("UCI HAR Dataset/features.txt")
    vnames <- features$V2

    train_data <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = vnames)
    train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))
    train_final <- cbind(train_subject, train_data)
    
    test_data <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = vnames)
    test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))
    test_final <- cbind(test_subject, test_data)
    
    combined <- rbind(train_final, test_final)
    combined
}

# This function extracts the subject, mean & standard deviation columns
# from the merged dataset

extractmeanandstd <- function(dataset) {
    extracted <- dataset[, grepl("mean|std|subject", names(dataset))]
    extracted
}

# This function cleans the variable names of the extracted dataset.

cleannames <- function(dataset) {
    dataset1 <- dataset
    colnames(dataset1) <- gsub("\\.", "", tolower(names(dataset1)))
    dataset1
}
