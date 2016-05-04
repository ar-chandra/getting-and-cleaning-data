### Introduction

There is a single script called run_analysis.R that does the following steps to the data:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Packages
You will need dplyr package installed

### Input
The data for this project is here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script expects you set your working directory to the folder where you extracted the zip archive file.

### Transformations and Variables

tidydata1 - First we are going to read the test and training set data and merge them into one dataset.

mean.std.col.nums - Next we get only the column of the nature of 'mean' or 'standard deviation' of the recorded variables. This we do by subsetting the column name vector by looking at the words mean or std. We then filter out the tidydata1 with the column numbers we obtained. At the end of this, the tidydata1 will only have values of the nature of mean or standard deviation.

Next, to the same tidydata1 we add a column indicating which activity does each row of data represent. The activities are:
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

Next, in the same tidydata1 we rename the columns with appropriate names that we extracted in step 2. We only have to add the mean/std column names.

The next step is to add experiment 'subject' information for each row of data. There were 30 subjects used in the experiment, and each row represents values obtained from one subject performing one activity.

tidydata2 - Finally, we create a new dataset which will contain only the average of values for each variable per activity and per subject.

### Output

We write out the tidydata2 into a txt file and name it descriptively as tidy_data_step5.txt to be uploaded for evaluation.
