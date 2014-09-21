---
title: "Read Me for Course Project"
author: "Peng Cheng Zhang"
date: "September 21, 2014"
output: pdf_document
---

The purpose of the course project was to
1.  Merges the training and the test sets to create one data set.
2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
3.  Uses descriptive activity names to name the activities in the data set
4.  Appropriately labels the data set with descriptive variable names. 
5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The Script does not perform the first 4 steps in that exact order. I found it easier to perform certain steps first.
The files must be downloaded and unzipped outside of R.
First, the script reads the features text file and renames them so it's more readable, which will be used later as variable names.
Next, the script reads in the Test and Training data, apply the new features list to Xtest or Xtrain data frame as their column names (descriptive variable names).
The scripts binds the subject, activity, and the variables of both Test and Train into 2 data frames first, and then combines them with rbind to form one big data frame.

The activity is then converted from numbers to characters using the activity labels.txt file as a guide.

This completes the first 4 required steps.

Using the select command, the script selects only column variables with names that contains "Mean" and "StandardDeviation".
This creates a new data frame, which is chained together to group and summarize.
The script groups together subject and activity using "group by", and summarize the mean of all variables according to the groups using "summarise each" function.
The column names remained the same, but note in this final form, all the values of the variables (except subject and activity) are the mean from multiple measurements. 

Finally, using write.table, the tidy data is saved as a txt file.

Since the purpose of the tidy data is unclear, I think it's fair that the X, Y, Z component of certain measured data are left as their own variables, since some measured variables do not have X,Y, Z components and it would create a lot of NA values.
