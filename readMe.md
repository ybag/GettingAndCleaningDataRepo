## Getting and Cleaning Data

Bagotsky Yury

This repo contains the course project for the Getting & Cleaning data course.

### Overview
This project  demonstrates  the collection and cleaning of a data set to create a subsequent tidy data set that can be used for subsequent
analysis. A full description of the data used in this project can be found at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## tidy_data.txt fulfills *Tidy Data* requirements

1. Each variable your measure should be in one column:
  * No single column in the tidy_data.txt file contains more than one variable.  See Long Format rationale.
2. Each different observation of that variable should be in a different row.
  * For purposes of the tidy_data.txt, each observation is considered for each subject, activity, and feature.
    Thus, having each row uniquely identified by the subject, activity and feature.
3. There should be one table for each "kind" of variable
  * This tidy data is only one table, as we're capturing the mean by subject, activity and feature
4. If you have multiple tables, they should include a column in the table that allows them to be linked
  * Not applicable, since there is only 1 table


### Modifications to This Script
On line 2 of run_analysis.R, you will set the path of the working directory to relect the location of the source files

### Project Summary
The following is a summary description of the project

You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Objective:
To produce a tidy data set from the dataset

> You should create one R script called run_analysis.R that does the following:
>
> 1. Merges the training and the test sets to create one data set.
>
> 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
>
> 3. Uses descriptive activity names to name the activities in the data set
>
> 4. Appropriately labels the data set with descriptive variable names. 
>
> 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

### Additional Information
You can find additional information about the variables, data and transformations in the CodeBook.MD file.
