# This function merges the training and test datasets into one dataset
# with clean variables names 

getandcleananalysisdata <- function() {
    downloadandextract()
    finaldf <- mergedatasets() %>% extractmeanandstd() %>% cleannames() %>% 
        getfinaldatawithmean()
    finaldf
}

# This function creates a new tidy dataset from the merged dataset
# with the average of each variable for each activity and each subject

getfinaldatawithmean <- function(dataset) {
    finaldataset <- dataset %>% group_by(subject, activity) %>% summarise_all(mean)
    finaldataset
}

# This function downloads the zip file and extracts to the current directory

downloadandextract <- function() {
    temp <- tempfile()
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
    unzip (temp, exdir = "./")
}


# This function assumes the data is extracted into the current directory.

# 1) Reads the features file for variable names
# 2) Reads the activity lables file for the same
# 3) Reads the training data, activities & subjects and combines into a data frame
# 4) Reads the test data, activities & subjects and combines into a data frame
# 5) Combines the training and test data frames into one

mergedatasets <- function() {
    features <- read.table("UCI HAR Dataset/features.txt")
    vnames <- features$V2

    activity_lables <- read.table("UCI HAR Dataset/activity_labels.txt")

    train_x_data <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = vnames)
    train_y_data <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = c("code"))
    train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))
    train_final <- cbind(train_subject, train_y_data, train_x_data)
    
    test_x_data <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = vnames)
    test_y_data <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = c("code"))
    test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))
    test_final <- cbind(test_subject, test_y_data, test_x_data)
    
    combined <- rbind(train_final, test_final)
    combined$code <- activity_lables[combined$code, 2]
    combined
}

# This function extracts the subject, activity code, mean & standard deviation columns
# from the merged dataset

extractmeanandstd <- function(dataset) {
    extracted <- dataset[, grepl("mean|std|subject|code", names(dataset))]
    extracted
}

# This function cleans the variable names of the extracted dataset.

cleannames <- function(dataset) {
    colnames(dataset) <- gsub("\\.", "", tolower(names(dataset)))
    colnames(dataset)[2] <- "activity"
    dataset
}
