
dataurl<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#setwd("E:\\mywork\\courcera\\getting and cleaning data\\proj\\UCI HAR Dataset")

dir()
library(dplyr)
library(reshape2)
library(data.table)
library(tidyr)
library(plyr)
library(data.table)
library(reshape2)

#1.Merges the training and the test sets to create one data set.

## Load:  Test and Training data that includes features measurements(X) and labels_ID (y)
## file : train\X_train.txt
x.training<-   read.table(file.path("train", "X_train.txt") ,stringsAsFactors=FALSE )
## file : train\y_train.txt
y.training<-   read.table(file.path("train","y_train.txt") ,stringsAsFactors=FALSE )

## file : test\X_test.txt
x.test<-   read.table(file.path("test","X_test.txt" ),stringsAsFactors=FALSE )
## file : test\y_test.txt
y.test<-   read.table(file.path("test","y_test.txt") ,stringsAsFactors=FALSE )

## Load features columns names and activities lookup
## file :activity_labels.txt
activity_lookup<- read.table(file.path("activity_labels.txt") ,stringsAsFactors=FALSE )
## file :features.txt
features_names<- read.table(file.path("features.txt") ,stringsAsFactors=FALSE )


##load Subject data for test and train data sets:

dataSubjectTrain <- read.table(file.path( "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path( "test" , "subject_test.txt"),header = FALSE)



## doing merge for the train and test data sets including subject data
#1. bind subject column for each corresponding data set
## Result data set : lable_Y , Subject_ID , features1 ...feature n

training<-cbind( dataSubjectTrain,x.training )
training<- cbind(y.training , training)

test<-cbind( dataSubjectTest,x.test)
test<- cbind(y.test,test)

data <- data.frame(rbind(training , test))
colnames(data)[2]<- "Subject_ID"
colnames(data)[1]<- "lable_Y"


#2.Extracts only the measurements on the mean and standard deviation for each measurement. 

## Find measurements on the mean and standard
ft<- data.table(features_names)

colindx<- which (ft$V2 %like% "mean\\(\\)"| ft$V2 %like% "std\\(\\)" )
mn_sd_features <- features_names[colindx,]

data1 <- data[,c(1,2,(colindx+2))]

#3.Uses descriptive activity names to name the activities in the data set

### result data set :lable_Y , activity  name , Subject_ID ,features ( v1 ... v66)      
colnames(activity_labels)<-c("lable_Y" ,"activity")
data1<- merge (activity_labels,data1 , by="lable_Y" )
###
##4. Appropriately labels the data set with descriptive variable names

features <- make.names(mn_sd_features[,"V2"])
features <- gsub("^t", "time.", features)
features <- gsub("^f", "freq.", features)
#features <- gsub("Acc", "Accelerator", features)
#features <- gsub("Mag", "Magnitude", features)
#features <- gsub("Gyro", "Gyroscope", features)

names( data1)[-c(1,2,3)] <-features 

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
data2<-ddply(data1, .(activity ,Subject_ID), colwise(mean) ,)

head(data2)
data2<- data2[order(data2$activity , data2$Subject_ID),]

library(xtable)

##print(xtable(data2[,1:10] ,type = "html"))

write.table(data2, file = "./activity_ subject_avgs.txt" , row.name=FALSE)

