
## Set the name of the file  
myfile <- "mydata_dataset.zip"

## Download and unzip the dataset:
if (!file.exists(myfile)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, myfile, mode='wb')
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(myfile) 
}

## Read in the activity labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])

## Read in the features
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

## Extract information data on mean and standard deviation only and clean up names
featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
featuresWanted.names <- features[featuresWanted,2]
featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)

## Load the dataset for train with only mean and std dev columns, activity and subject
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresWanted]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

## Load the dataset for test with only mean and std dev columns, activity and subject
test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresWanted]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

## merge datasets and add labels
mrgData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", featuresWanted.names)

## turn activities & subjects into factors
mrgData$activity <- factor(mrgData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
mrgData$subject <- as.factor(mrgData$subject)


## Melt the data by subject and activity identifier and then  reshape it to
##  a data frame. Package reshape2 must be loaded for this 
mrgData.melted <- melt(mrgData, id = c("subject", "activity"))
mrgData.mean <- dcast(mrgData.melted, subject + activity ~ variable, mean)

write.table(mrgData.mean, "tidy.txt", row.names = FALSE, quote = FALSE) 
