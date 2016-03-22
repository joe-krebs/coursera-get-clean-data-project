#
# run_analysis.R
#
# Joe Krebs
# 2016-03-20
#

require(utils)  # Needed for unzip
require(dplyr)  # Needed for summarise

# Change to the working directory (comment out for submission)
# setwd("~/coursera/cleandata/project")

# Download and unzip the dataset
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "dataset.zip")
unzip("dataset.zip")

# Read the list of all feature names, extract the map of desired features 
# (those with "mean()" or "std()"), and pretty up the names
all.features <- tolower(read.delim(file="./UCI HAR Dataset/features.txt", header=FALSE, sep="")[,2])
desired.feature.map <- grep("mean\\(\\)|std\\(\\)", all.features)
all.features <- gsub("()", "", all.features, fixed=TRUE)
all.features <- gsub("-", ".", all.features, fixed=TRUE)

# Read and combine the test and training sets
#   subjects - from subject_train.txt and subject_test.txt 
#   activities - from y_train.txt and y_test.txt
#   features - from X_train.txt and X_test.txt
subjects <- rbind(read.delim(file="./UCI HAR Dataset/train/subject_train.txt", header=FALSE, sep=""),
                  read.delim(file="./UCI HAR Dataset/test/subject_test.txt", header=FALSE, sep=""))
names(subjects) <- "subject"
activities <- rbind(read.delim(file="./UCI HAR Dataset/train/y_train.txt", header=FALSE, sep=""),
                    read.delim(file="./UCI HAR Dataset/test/y_test.txt", header=FALSE, sep=""))
names(activities) <- "activity"

features <- rbind(read.delim(file="./UCI HAR Dataset/train/X_train.txt", header=FALSE, sep=""),
                  read.delim(file="./UCI HAR Dataset/test/X_test.txt", header=FALSE, sep=""))
names(features) <- all.features

# Replace activity numbers with factor variable using descriptive names
activities$activity <- factor(activities$activity, 
                              labels=c("walking", "walking_upstairs", 
                                       "walking_downstairs", "sitting",
                                       "standing", "laying"))

# Trim the features frame to the desired features
features <- features[,desired.feature.map]

# Assemble subjects, activities, and features into final merged data frame
merged.data <- cbind(subjects, activities, features)

# Write the final merged dataset to disk (comment out for submission)
# write.table(merged.data, file="./merged_dataset.txt", row.names=FALSE, quote=FALSE)

# Create a new tidy data set with the average of each variable for each activity and each subject
by.groups <- group_by(merged.data, subject, activity)
averaged.data <- summarise(by.groups, 
                           tbodyacc.mean.x=mean(tbodyacc.mean.x, na.rm=TRUE),
                           tbodyacc.mean.y=mean(tbodyacc.mean.y, na.rm=TRUE),
                           tbodyacc.mean.z=mean(tbodyacc.mean.z, na.rm=TRUE),
                           tbodyacc.std.x=mean(tbodyacc.std.x, na.rm=TRUE),
                           tbodyacc.std.y=mean(tbodyacc.std.y, na.rm=TRUE),
                           tbodyacc.std.z=mean(tbodyacc.std.z, na.rm=TRUE),
                           tgravityacc.mean.x=mean(tgravityacc.mean.x, na.rm=TRUE),
                           tgravityacc.mean.y=mean(tgravityacc.mean.y, na.rm=TRUE),
                           tgravityacc.mean.z=mean(tgravityacc.mean.z, na.rm=TRUE),
                           tgravityacc.std.x=mean(tgravityacc.std.x, na.rm=TRUE),
                           tgravityacc.std.y=mean(tgravityacc.std.y, na.rm=TRUE),
                           tgravityacc.std.z=mean(tgravityacc.std.z, na.rm=TRUE),
                           tbodyaccjerk.mean.x=mean(tbodyaccjerk.mean.x, na.rm=TRUE),
                           tbodyaccjerk.mean.y=mean(tbodyaccjerk.mean.y, na.rm=TRUE),
                           tbodyaccjerk.mean.z=mean(tbodyaccjerk.mean.z, na.rm=TRUE),
                           tbodyaccjerk.std.x=mean(tbodyaccjerk.std.x, na.rm=TRUE),
                           tbodyaccjerk.std.y=mean(tbodyaccjerk.std.y, na.rm=TRUE),
                           tbodyaccjerk.std.z=mean(tbodyaccjerk.std.z, na.rm=TRUE),
                           tbodygyro.mean.x=mean(tbodygyro.mean.x, na.rm=TRUE),
                           tbodygyro.mean.y=mean(tbodygyro.mean.y, na.rm=TRUE),
                           tbodygyro.mean.z=mean(tbodygyro.mean.z, na.rm=TRUE),
                           tbodygyro.std.x=mean(tbodygyro.std.x, na.rm=TRUE),
                           tbodygyro.std.y=mean(tbodygyro.std.y, na.rm=TRUE),
                           tbodygyro.std.z=mean(tbodygyro.std.z, na.rm=TRUE),
                           tbodygyrojerk.mean.x=mean(tbodygyrojerk.mean.x, na.rm=TRUE),
                           tbodygyrojerk.mean.y=mean(tbodygyrojerk.mean.y, na.rm=TRUE),
                           tbodygyrojerk.mean.z=mean(tbodygyrojerk.mean.z, na.rm=TRUE),
                           tbodygyrojerk.std.x=mean(tbodygyrojerk.std.x, na.rm=TRUE),
                           tbodygyrojerk.std.y=mean(tbodygyrojerk.std.y, na.rm=TRUE),
                           tbodygyrojerk.std.z=mean(tbodygyrojerk.std.z, na.rm=TRUE),
                           tbodyaccmag.mean=mean(tbodyaccmag.mean, na.rm=TRUE),
                           tbodyaccmag.std=mean(tbodyaccmag.std, na.rm=TRUE),
                           tgravityaccmag.mean=mean(tgravityaccmag.mean, na.rm=TRUE),
                           tgravityaccmag.std=mean(tgravityaccmag.std, na.rm=TRUE),
                           tbodyaccjerkmag.mean=mean(tbodyaccjerkmag.mean, na.rm=TRUE),
                           tbodyaccjerkmag.std=mean(tbodyaccjerkmag.std, na.rm=TRUE),
                           tbodygyromag.mean=mean(tbodygyromag.mean, na.rm=TRUE),
                           tbodygyromag.std=mean(tbodygyromag.std, na.rm=TRUE),
                           tbodygyrojerkmag.mean=mean(tbodygyrojerkmag.mean, na.rm=TRUE),
                           tbodygyrojerkmag.std=mean(tbodygyrojerkmag.std, na.rm=TRUE),
                           fbodyacc.mean.x=mean(fbodyacc.mean.x, na.rm=TRUE),
                           fbodyacc.mean.y=mean(fbodyacc.mean.y, na.rm=TRUE),
                           fbodyacc.mean.z=mean(fbodyacc.mean.z, na.rm=TRUE),
                           fbodyacc.std.x=mean(fbodyacc.std.x, na.rm=TRUE),
                           fbodyacc.std.y=mean(fbodyacc.std.y, na.rm=TRUE),
                           fbodyacc.std.z=mean(fbodyacc.std.z, na.rm=TRUE),
                           fbodyaccjerk.mean.x=mean(fbodyaccjerk.mean.x, na.rm=TRUE),
                           fbodyaccjerk.mean.y=mean(fbodyaccjerk.mean.y, na.rm=TRUE),
                           fbodyaccjerk.mean.z=mean(fbodyaccjerk.mean.z, na.rm=TRUE),
                           fbodyaccjerk.std.x=mean(fbodyaccjerk.std.x, na.rm=TRUE),
                           fbodyaccjerk.std.y=mean(fbodyaccjerk.std.y, na.rm=TRUE),
                           fbodyaccjerk.std.z=mean(fbodyaccjerk.std.z, na.rm=TRUE),
                           fbodygyro.mean.x=mean(fbodygyro.mean.x, na.rm=TRUE),
                           fbodygyro.mean.y=mean(fbodygyro.mean.y, na.rm=TRUE),
                           fbodygyro.mean.z=mean(fbodygyro.mean.z, na.rm=TRUE),
                           fbodygyro.std.x=mean(fbodygyro.std.x, na.rm=TRUE),
                           fbodygyro.std.y=mean(fbodygyro.std.y, na.rm=TRUE),
                           fbodygyro.std.z=mean(fbodygyro.std.z, na.rm=TRUE),
                           fbodyaccmag.mean=mean(fbodyaccmag.mean, na.rm=TRUE),
                           fbodyaccmag.std=mean(fbodyaccmag.std, na.rm=TRUE),
                           fbodybodyaccjerkmag.mean=mean(fbodybodyaccjerkmag.mean, na.rm=TRUE),
                           fbodybodyaccjerkmag.std=mean(fbodybodyaccjerkmag.std, na.rm=TRUE),
                           fbodybodygyromag.mean=mean(fbodybodygyromag.mean, na.rm=TRUE),
                           fbodybodygyromag.std=mean(fbodybodygyromag.std, na.rm=TRUE),
                           fbodybodygyrojerkmag.mean=mean(fbodybodygyrojerkmag.mean, na.rm=TRUE),
                           fbodybodygyrojerkmag.std=mean(fbodybodygyrojerkmag.std, na.rm=TRUE))
 
# Write the averaged data frame to disk as a CSV file
write.table(averaged.data, file="./averaged_dataset.txt", row.names=FALSE, quote=FALSE)
