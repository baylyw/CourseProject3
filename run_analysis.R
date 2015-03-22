# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data 
# set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by 
# your peers on a series of yes/no questions related to the project. You will be required to submit: 
# 1) a tidy data set as described below, 2) a link to a Github repository with your script for 
# performing the analysis, and 3) a code book that describes the variables, the data, and any 
# transformations or work that you performed to clean up the data called CodeBook.md. You should also 
# include a README.md in the repo with your scripts. This repo explains how all of the scripts work 
# and how they are connected. 

# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each
# variable for each activity and each subject.

setwd("~/Desktop/Rcourse/Course3/Project")
x.test <- read.table(file = "UCI HAR Dataset/test/X_test.txt")
y.test <- read.table(file = "UCI HAR Dataset/test/Y_test.txt")
subject.test <- read.table(file = "UCI HAR Dataset/test/subject_test.txt")

x.train <- read.table(file = "UCI HAR Dataset/train//X_train.txt")
y.train <- read.table(file = "UCI HAR Dataset/train//y_train.txt")
subject.train <- read.table(file = "UCI HAR Dataset/train//subject_train.txt")

features <- read.table(file = "UCI HAR Dataset//features.txt")
activities <- read.table(file = "UCI HAR Dataset//activity_labels.txt")

colnames(y.test) <- "act.code"
colnames(y.train) <- "act.code"
colnames(subject.test) <- "subject"
colnames(subject.train) <- "subject"

# Merges data (contained in .test and .train files) with the appropriate subject label. In addition
# adds a column containing "test" or "train" to distinguish training from test data later on when
# the tables are merged

test.data <- cbind(y.test, subject.test, "test", x.test)
train.data <- cbind(y.train, subject.train, "train", x.train)

# Requirement 4: Labels data with descriptive variable names from the features data table, also 
# labels the feature column containing either test or train with the name variable

colnames(test.data)[c(4:ncol(test.data))] <- as.character(features$V2)
colnames(test.data)[3] <- "variable"
colnames(train.data)[c(4:ncol(train.data))] <- as.character(features$V2)
colnames(train.data)[3] <- "variable"

# Requirement 1: Merges test and training data sets using Rbind to create a skinny table where 
# test and training data are distinguished by the "varaible" column

data <- rbind(train.data, test.data) 

# Requirement 2: extract only the mean and standard deviation information. Uses grep to identify
# any mean column including meanFreq columns or std column

meancols <- grep("mean", colnames(data))
stdcols <- grep("std", colnames(data))
cols <- c(1:3,meancols, stdcols)
cols <- cols[order(cols)]
trim.data <- data[,cols] 

# Requirement 3: uses descriptive activity names. Creates a column called activity with the 
# descriptive activity category using merge

trim.data <- merge(trim.data, activities, by.x = "act.code", by.y = "V1")
colnames(trim.data)[ncol(trim.data)] <- "activity"

# Requirement 5: creates an independent data set with average of each variable for each activity
# and each subject using ddply

library(plyr)
library(reshape2)
final.data <-ddply(trim.data[,c(2,4:ncol(trim.data))], c("subject","activity"), colwise(mean))

write.table(final.data,"BWfinalDataTable.txt", row.name=F)
