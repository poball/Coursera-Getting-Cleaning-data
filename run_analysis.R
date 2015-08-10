#### cleaning Data Project ######
####################################

#set up work directory
if(!file.exists("./data")){dir.create("./data")}
setwd('C:/Users/lqiu/Documents/coursera/clean_data')
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile="./data/Human_activity.zip")
#unzip data
unzip("./data/Human_activity.zip",exdir="./data")

#1. Merges the training and the test sets to create one data set.
#row combine traning and test dataset
tmp1 <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
tmp2 <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
X <- rbind(tmp1, tmp2) #10299*561

tmp1 <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
tmp2 <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
S <- rbind(tmp1, tmp2) #10299*1

tmp1 <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
tmp2 <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
Y <- rbind(tmp1, tmp2) #10299*1

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
features<-read.table("./data/UCI HAR Dataset/features.txt") #561*2
index<-grep("mean\\(\\)|std\\(\\)", features[, 2])
X <- X[, index]
names(X) <- features[index, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

#3 Uses descriptive activity names to name the activities in the data set
#loading data
activity<-read.table("./data/UCI HAR Dataset/activity_labels.txt")
#change value to descriptive activity names
activity[,2]<-gsub("_","",tolower(as.character(activity[,2])))
#assign names to corresponding var
Y[,1]<-activity[Y[,1],2]
#change col name
names(Y)<-"activities"

#4 Appropriately labels the data set with descriptive variable names. 
#change col name
names(S)<-"subject"
#merge data by col
clean_data<-cbind(S,Y,X)
#unload data to file 
write.table(clean_data,"./data/merged_clean_data.txt")

#5 From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.

#unique subject
unique_sub<-unique(S)[,1]
#number of subjects & activities
num_sub<-length(unique_sub) #30
num_activity<-length(activity[,1]) #6
num_col<-dim(clean_data)[2] #68
result<-clean_data[1:(num_sub*num_activity),]
#create table 
row<-1
for (i in 1:num_sub){
    for (a in 1:num_activity){
      result[row,1]<-unique_sub[i]
      result[row,2]<-activity[a,2]
      temp<-clean_data[clean_data$subject==i & clean_data$activities==activity[a,2],]
      result[row,3:num_col]<-colMeans(temp[,3:num_col])
      row=row+1
    }
}

#unload data
write.table(result,"./data/data_with_means.txt",row.names=FALSE)

