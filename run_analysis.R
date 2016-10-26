library(reshape2)

## Set the name of the file  
filename <- "mydata_dataset.zip"
  
    ## Download and unzip the dataset:
    if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
        download.file(fileURL, filename, mode='wb')
      }  
    if (!file.exists("UCI HAR Dataset")) { 
      unzip(filename) 
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
   allData <- rbind(train, test)
   colnames(allData) <- c("subject", "activity", featuresWanted.names)
   
   ## turn activities & subjects into factors
   allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
   allData$subject <- as.factor(allData$subject)
   
   ## get mean of all measuremnts
   allData.melted <- melt(allData, id = c("subject", "activity"))
   allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)
   
   write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE) 
