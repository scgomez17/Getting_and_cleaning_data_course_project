---
title: "Code Book"
author: "Saul Gomez"
date: "28 de diciembre de 2021"
output: html_document
---


## Getting and Cleaning Data Course Project

The `run_analysis.R` script performs the pre-processing and the 5 preparation steps to obtain a tidy dataset of the data collected from the accelerometers from the Samsung Galaxy S smartphone.

1. The dataset is downloaded and extracted in the folder called `UCI HAR Dataset`

2. Each data is assigned to corresponding variables

-`features` <- `features.txt`
Raw signal from the accelerometer and gyroscope

-`activities` <- `activity_labels.txt`
List of activities performed

-`subject_test` <- `subject_test.txt`
Test data of volunteer test subjects

-`x_test` <- `X_test.txt`
Recorded signal of test data

-`y_test` <- `y_test.txt`
Test data labels

-`subject_train` <- `subject_train.txt`
Train data of volunteer train subjects

-`x_train` <- `X_train.txt`
Recorded signals of train data

-`y_train` <- `y_train.txt`
Train data labels

3. Training and test sets were merged to create one dataset

-`features_data` (10299 obs. of 561 vars) <- `x_train` combined (`rbind`) with `x_test`

-`activitt_data` (10299 obs. of 1 var) <- `y_train` combined (`rbind`) with `y_test`

-`subject_data` (10299 obs. of 1 var) <- `subject_train` combined (`rbind`) with `subject_test`

-`tidy_dataset` (10299 obs. of 563 vars) <- `subject_data`, `activity_data` and `features_data` are combined (`cbind`)

4. Only the measurements on the mean and standard deviation for each measurement are extracted

-`tidy_dataset` (10299 obs. of 88 vars) is updated by selecting only the measurments on the mean and standard deviation of columns `subject` and `activity`

5. Descriptive activity names are used to name the activities in the dataset

-Numbers in `activity` column are replaced with the corresponding activity label

6. Appropriately labels the dataset with descriptive variable names

-All start with character `t` is replaced by `Time`

-All start with character `f` is replaced by `Frequency`

-`Acc` is replaced by `Accelerometer`

-`Gyro` is replaced by `Gyroscope`

-`BodyBody` is replaced by `Body`

-`Mag` is replaced by `Magnitude`

7. An independent tidy dataset is created with the average of each variable for each activity and subject

-`mean_td` (180 obs. of 88 vars) is created grouping by subject and activity and averaging each variable of `tidy_dataset`


