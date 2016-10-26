# Coursera-Assignment-Getting-and-Cleaning-Data
Assignment for Getting and Cleaning Data for Coursera Data Scientist Specialization 

An R script called run_analysis.R is created for this project to merge data sets and make them tidy.
The steps are -

1. Download the file from the url provided and unzip it.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Retrieve activity labels from activity_labels.txt
4. Retrieve features from features.txt.
5. Load the activity data from Y_train.txt and Y_test.txt.
6. Load the features data from X_train.txt and X_test.txt.
7. Load the train and test datasets with mean and std dev columns.
8. Combine the  the activity and subject data for for test with test data.
9. Combine the  the activity and subject data for for train with train data.
10. Merges the two datasets
11. Converts the `activity` and `subject` columns into factors
12. Creates a tidy dataset that consists of the average (mean) value of each
   variable for each subject and activity pair.
13. The file containing the merged and tidy data is tidy.txt.
