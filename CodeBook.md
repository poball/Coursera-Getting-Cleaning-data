Course Project CodeBook
=================================================

Original Data Source: 
-----------------------------------------
  Data Source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  
  Data Description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


Description R script (run_analysis.R)
------------------------------------------
* Merge following dataset:
  1. X: train/X_train.txt and test/X_test.txt: result of 10299*561 data frame
  2. S: train/subject_train.txt and test/subject_test.txt: result of 10299*1 data frame
  3. Y: train/y_train.txt and test/y_test.txt: result of 10299*1 data frame
  
* Extracts only the measurements on the mean and standard deviation for each measurement from 'features.txt'. Craete 10299*66 data frame with 66 out of 561 attributes are measurements on the mean and standard deviation. All measurements is in the range (-1, 1).

* Apply descriptive activity names in data(activity_labels.txt) to the activities in the dataset.
  1. Covert activity names to lowercase

* The script also appropriately labels the data set with descriptive names: 
  1. Apply header("subject") to data Y.
  2. Merge all 3 datasets(X, Y, S) by columns, result a 10299*68 data frame.
  3. Save result as merged_clean_data.txt in current work directory.

* Creates a 2nd, independent tidy data set with the average of each measurement for each activity and each subject. 
  1. Result saved as data_with_means.txt a current work directory, a 180*68 data frame 
  2. Description of "data_with_means.txt" 
      1. column 1: subject IDs, 
      2. column 2: activity names
      3. column 3 to 86: the averages for each of the 66 attributes
      4. Dimension of the data: 180*68
