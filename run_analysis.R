## Getting and Cleaning Data Course Project
## Loads dplyr library which will be used later
library(dplyr)

## Reads in features table
features<-read.table("./features.txt")

## substitute unclear words to make the variables more understandable
## Using Cap letters for better readability
features<-gsub("\\()","",features$V2)
features<-gsub("-","", features)
features<-sub("bodybody","body",features)
features<-sub("tBody","TimeBody",features)
features<-sub("tGravity","TimeGravity", features)
features<-sub("fBody","FrequencyBody", features)
features<-sub("fGravity","FrequencyGravity", features)
features<-sub("Acc","Acceleration",features)
features<-sub("Mag","Magnitude",features)
features<-sub("sma","SignalMagnitudeArea", features)
features<-sub("mad","MedianAbsoluteDeviation", features)
features<-sub("iqr","InterquartileRange",features)
features<-sub("arCoeff","AutorregressionCoefficientWithBurgOrderOf4",features)
features<-sub("Jerk","Jerk",features)
features<-sub("\\(","of",features)
features<-sub("\\)","",features)
features<-sub("max","Max",features)
features<-sub("mean","Mean",features)
features<-sub("std","StandardDeviation",features)
features<-sub("min","Minimum",features)
features<-sub("entropy","Entropy",features)
features<-sub("correlation","Correlation",features)
features<-sub("skewness","Skewness",features)
features<-sub("bands","Bands",features)
features<-sub("kurtosis","Kurtosis",features)
features<-sub("angle","Angle",features)
features<-sub("of","Of",features)
features<-sub(",",""features)

## Reads the test files from test subfolder
Xtest<-read.table("./test/X_test.txt")
Stest<-read.table("./test/subject_test.txt")
Ytest<-read.table("./test/y_test.txt")

## Assign new feature names to the columns of respective X test data
names(Xtest)<-features

## bind the subject, activity and data into one data frame
Test<-cbind(Stest,Ytest,Xtest)

## Reads the training data
Xtrain<-read.table("./train/X_train.txt")
Strain<-read.table("./train/subject_train.txt")
Ytrain<-read.table("./train/y_train.txt")

## Assign new feature names to the columns of respective X train data
names(Xtrain)<-features

## bind the subject, activity and data into one data frame
Train<-cbind(Strain, Ytrain, Xtrain)

## Combine Test and Training data into one data frame
Combined<-rbind(Test,Train)

## Edit the column name of the combined data to reflect subject and activity
colnames(Combined)[1]<-"Subject"
colnames(Combined)[2]<-"Activity"

## Using dplyr and assign into new table data frame used by dplyr functions
Comb<-tbl_df(Combined)

## Replaces activity with names of activity for easier reading
Comb$Activity[Comb$Activity=="1"]<-"Walking_Flat"
Comb$Activity[Comb$Activity=="2"]<-"Walking_Upstairs"
Comb$Activity[Comb$Activity=="3"]<-"Walking_Downstairs"
Comb$Activity[Comb$Activity=="4"]<-"Sitting"
Comb$Activity[Comb$Activity=="5"]<-"Standing"
Comb$Activity[Comb$Activity=="6"]<-"Laying"

## Select only variables with Mean and StandardDeviation in its name
CombSel<-select(Comb,Subject, Activity, contains("Mean"),contains("StandardDeviation"))

## Group the above data frame by Subject and Activity, then summarize the mean
## from the rest of the column variables within each grouping and stored as FT
FT <-
    CombSel %>% 
    group_by(Subject, Activity) %>%
    summarise_each(funs(mean))

## Write FT into table
write.table(FT,file="Tidy_UCI_Har_Data.txt",row.names=FALSE)
