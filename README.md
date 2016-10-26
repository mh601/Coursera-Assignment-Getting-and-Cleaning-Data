# Coursera-Assignment-Getting-and-Cleaning-Data
Assignment for Getting and Cleaning Data for Coursera Data Scientist Specialization 

An R script called run_analysis.R is created for this project to merge data sets and make them tidy.
The steps are -

1. Download the file from the url provided and unzip it.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Retrieve activity labels and features.
4. Load the activity and feature info.
5. Load the train and test datasets with mean and std dev columns.
6. Combine the  the activity and subject data for for test with test data.
7. Combine the  the activity and subject data for for train with train data.
8. Merges the two datasets
9. Converts the `activity` and `subject` columns into factors
10. Creates a tidy dataset that consists of the average (mean) value of each
   variable for each subject and activity pair.
The end result is shown in the file `tidy.txt`.
