# Description
The script `run_analysis.R` takes accelerometer and gyroscope data from 30 volunteers performing six activities (walking, walking upstairs, walking downstairs sitting, standing, laying) wearing a smartphone on the waist and culls only the average and standard deviation of each measurment. The final output is a tidy data table with the average of both measurements (average and standard devation) for each activity and subject.

### Required packages
Requires the plyr package

### Data Source
Detailed info can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Project data can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Variables read in from source data     
* `x.test` a 2947 x 561 data table of data from test subjects from X_test.txt
* `y.test` a 2947 x 1 data table of test activity codes from y_test.txt
* `x.train` a 7352 x 561 data table of data from train subjects from X_train.txt
* `y.train` a 7352 x 1 data table of training activity codes from y_test.txt
* `subject.test` a 2947 x 1 data table of test subject codes from subject_test.txt
* `subject.train` a 7352 x 1 data table of training subject codes from subject_train.txt 
* `features` a 561 x 2 data table that classifies each measurement column in x.test and x.train from features.txt
* `activities` a 6 x 2 data table that from activity_labels.txt that describes what each activity code means 

### Generated variables
* `test.data` test data measurments with their activity code generated from binding test data with test activity codes
* `train.data` training data measurments with their activity code generated from binding training data with training activity codes
* `data` contains both training and test data generated from binding test and training data 
* `meancols` list of columns containing "mean"
* `stdcols` list of columns containing "std"
* `cols` list of columns containing mean or std
* `trim.data` data frame containing only mean or std data from both test and training subjects
* `final.data` data frame with average of each variable for each activity and subject


### Data transformations
1. Read in all data as in the above "variables read in" section
2. Merge data (contained in .test and .train files) with the appropriate subject label
      + In addition add a column containing "test" or "train" to distinguish training from test data later on when the tables are merged
3. **Requirement 4:** label data with descriptive variable names from the features data table
4. **Requirement 1:** use rbind to merge rows contained in test.data and train.data a skinny table where test and training data are distinguished by the "variable" column 
5. **Requirement 2:** use grep to identify any mean column (including meanFreq) or std column to etract only the mean and standard deviation information. 
6. **Requirement 3:** uses merge to create a column called activity with the descriptive activity category using merge
7. **Requirement 5:** uses ddply to create an independent data set with average of each variable for each activity and each subject using ddply

### The final table
The final table reports averaged data recorded for a subject doing a specific activity. Depending on the column the report is either the average of the mean values for that measuerment (columns containing in mean()), the average of the standard deviation for that measurment (columns containing std()), or the average of the mean frequency (columns containing meanFreq).



