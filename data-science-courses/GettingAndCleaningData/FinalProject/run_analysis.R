#######################################################################################
#Dependencies
#######################################################################################
library(RCurl)
library(data.table)
library(dplyr)

#######################################################################################
#--Part 0.1 Getting data from url
#######################################################################################

#Create and set working directory
if(!file.exists("./run_analysis")){dir.create("./run_analysis")}
setwd("./run_analysis")

#Download and unzip file
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
f <- file.path(getwd(), "run_alaysis.zip")
download.file(url, f,  method="curl")
zipF<- file.path(getwd(), "run_anlysis.zip")
unzip(zipF)

#######################################################################################
#--Part 0.2 Reading training and test data
#######################################################################################

#Read training data
subject_train <- read.table("./run_analysis/UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./run_analysis/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./run_analysis/UCI HAR Dataset/train/y_train.txt")

#Read test data
subject_test <- read.table("./run_analysis/UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./run_analysis/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./run_analysis/UCI HAR Dataset/test/y_test.txt")

#Read features, ignoring text labels as factors
features <- read.table("./run_analysis/UCI HAR Dataset/features.txt", as.is = TRUE)

#Read activity labels
activities <- read.table("./run_analysis/UCI HAR Dataset/activity_labels.txt")
colnames(activities) <- c("activityId", "activityLabel")

#######################################################################################
#--Part 1 Merging training and test data
#######################################################################################
#Merging train and test data
merge <- rbind(
  cbind(subject_train, x_train, y_train),
  cbind(subject_test, x_test, y_test)
)

#Assigning column names
colnames(merge) <- c("subject", features[, 2], "activity")

#######################################################################################
#--Part 2 Extracting mean and standard deviation from merge
#######################################################################################

#Determine columns to keep based on column name.
keepColumns <- grepl("subject|activity|mean|std", colnames(merge))

#Keep data in those columns only.
merge <- merge[, keepColumns]

#######################################################################################
#--Part 3 Giving descriptive activity name
#######################################################################################

merge$activity <- factor(merge$activity, 
                                 levels = activities[, 1], labels = activities[, 2])

#######################################################################################
#--Part 4 Labeling with descriptive variables
#######################################################################################

#Get column names
ActivityCols <- colnames(merge)

#Remove special characters
ActivityCols <- gsub("[\\(\\)-]", "", ActivityCols)

#Expand abbreviations and clean up names
ActivityCols <- gsub("^f", "frequencyDomain", ActivityCols)
ActivityCols <- gsub("^t", "timeDomain", ActivityCols)
ActivityCols <- gsub("Acc", "Accelerometer", ActivityCols)
ActivityCols <- gsub("Gyro", "Gyroscope", ActivityCols)
ActivityCols <- gsub("Mag", "Magnitude", ActivityCols)
ActivityCols <- gsub("Freq", "Frequency", ActivityCols)
ActivityCols <- gsub("mean", "Mean", ActivityCols)
ActivityCols <- gsub("std", "StandardDeviation", ActivityCols)

#Correct typo
ActivityCols <- gsub("BodyBody", "Body", ActivityCols)

#Use new labels as column names
colnames(merge) <- ActivityCols

#######################################################################################
# Step 5 - Creating final tidy data
#######################################################################################

#Group by subject and activity and summarise by mean
ActivityMeans <- merge %>% 
  group_by(subject, activity) %>%
  summarise_all(mean)

#Output to file "tidy_data.txt"
write.table(ActivityMeans, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)

#Confirmation of tidyness
tidy <- read.table("./tidy_data.txt")
View(tidy)

#######################################################################################
#End
#######################################################################################
