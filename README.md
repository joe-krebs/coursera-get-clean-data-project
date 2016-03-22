README.md
Coursera Getting and Cleaning Data Project
By:     Joseph Krebs
Date:   2016-03-22 (Please pardon the lateness)

The script run_analysis.R is a fully self contained execution script that takes no parameters and performs the following steps:
1. Downloads the UCI HAR zip file
2. Unzips the UCI HAR zip file to the current directory
3. Reads the list of feature (column) names
4. Develops the list of mean and std features
5. Pretties the feature names by removing parentheses, dashes, and inserting periods judiciously
6. Reads and combines the training and test data sets
7. Combines subject and activity columns with the test feature data in a single table
8. Converts activity integer variable with factor variable using descriptivie activity labels
9. Trims the feature columns to only the mean and std variables
10. Creates a new tidy dataset of averages by activity and subject
11. Writes the new averaged dataset to disk