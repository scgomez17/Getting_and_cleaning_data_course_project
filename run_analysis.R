library(dplyr)
## Data extraction
# Data is downloaded and extracted into folder UCI HAR Dataset
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dest <- "C:/Users/usuario/OneDrive - Universidad de los Andes/Documentos/R_Programming/data_project.zip"
download.file(url, destfile = dest)
newdir <- "C:/Users/usuario/OneDrive - Universidad de los Andes/Documentos/R_Programming/Data_Project"
datap <- unzip(dest, exdir = newdir)
## Data assignment
# Each is assigned to corresponding variables
setwd("C:/Users/usuario/OneDrive - Universidad de los Andes/Documentos/R_Programming/Data_Project")
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity")
## One-Dataset Creation
# Training and test sets are merged to create one dataset
subject_data <- rbind(subject_train, subject_test)
activity_data <- rbind(y_train, y_test)
features_data <- rbind(x_train, x_test)
tidy_dataset <- cbind(subject_data, activity_data, features_data)
## Mean and Standard deviation
# Only the measurements on the mean and standard deviation for each measurement are extracted
tidy_dataset <- tidy_dataset %>% select(subject, activity, contains("mean"), contains("std"))
## Descriptive activity names
# Descriptive activity names are used to name the activities in the dataset
tidy_dataset$activity <- activities[tidy_dataset$activity, 2]
## Appropriate lableling
# Appropriately labels the dataset with descriptive variable names
names(tidy_dataset)<-gsub("^t", "Time", names(tidy_dataset))
names(tidy_dataset)<-gsub("^f", "Frequency", names(tidy_dataset))
names(tidy_dataset)<-gsub("Acc", "Accelerometer", names(tidy_dataset))
names(tidy_dataset)<-gsub("BodyBody", "Body", names(tidy_dataset))
names(tidy_dataset)<-gsub("Mag", "Magnitude", names(tidy_dataset))
names(tidy_dataset)<-gsub("Gyro", "Gyroscope", names(tidy_dataset))
## Final tidy dataset
# An independent tidy dataset is created with the average of each variable for each activity and subject
mean_td <- tidy_dataset %>% group_by(subject, activity) %>% summarize_all(mean)
write.table(mean_td, file = "tidy_dataset.txt",row.name=FALSE)
