library(dplyr)

# 1. Merging the training and the test sets to create one data set.
training.data <- read.table("train/X_train.txt")
test.data <- read.table("test/X_test.txt")
tidydata1 <- rbind(training.data, test.data)
rm(training.data)
rm(test.data)

# 2. Extract only the measurements on the mean and standard deviation for each
# measurement.

feature.variables <- read.table("features.txt")
mean.std.col.nums <- grep("mean|std",feature.variables$V2)
tidydata1 <- tidydata1[ ,mean.std.col.nums]


# 3. Use descriptive activity names to name the activities in the data set
training.activities <- read.table("train/Y_train.txt")
testing.activities <- read.table("test/Y_test.txt")
training.test.activities <- rbind(training.activities, testing.activities)
rm(training.activities)
rm(testing.activities)
names(training.test.activities) <- "activity.id"
activity.labels <- read.table("activity_labels.txt")
names(activity.labels) <- c("activity.id", "activity")
activity.columns <- inner_join(training.test.activities, activity.labels)
rm(training.test.activities)
rm(activity.labels)
tidydata1 <- cbind(tidydata1, activity.columns$activity)
rm(activity.columns)


# 4. Appropriately label the data set with descriptive variable names.
# feature.variables <- read.table("features.txt")
names(tidydata1) <- feature.variables$V2[mean.std.col.nums]
colnames(tidydata1)[80] <- c("activity")
rm(feature.variables)

# 5. From the data set in step 4, create a second, independent tidy data set with
# the average of each variable for each activity and each subject.

training.subjects <- read.table("train/subject_train.txt")
testing.subjects <- read.table("test/subject_test.txt")
training.test.subjects <- rbind(training.subjects, testing.subjects)
rm(training.subjects)
rm(testing.subjects)
names(training.test.subjects) <- "subject"
# add subject column
tidydata1 <- cbind(tidydata1, training.test.subjects)
rm(training.test.subjects)

# tidydata1[1312:1320, ]$subject
# tidydata1[1312:1320, ]$activity
# tidydata1[1312:1319,75:81]


tidydata2 <- aggregate(tidydata1,
                   list(activity1 = tidydata1$activity, subject1 = tidydata1$subject), mean)

tidydata2 <- tidydata2[ , !(names(tidydata2) %in% c("subject", "activity"))]

colnames(tidydata2)[which(names(tidydata2) == "subject1")] <- "subject"
colnames(tidydata2)[which(names(tidydata2) == "activity1")] <- "activity"

write.table(tidydata2, file="tidy_data_step5.txt", sep = " ", eol = "\n", row.names = FALSE)
