 
# Project extract and clean data
# Read the test and train data files and Merges the training and the test sets to create one data set.
#--------------------------------------------------------------------------------------------------------
# Set the file paths. Note: Replace the filepath with appropriate file paths in your environment.
 file_path_test <-"C://DataScience//GettingandCleaningData//Project//UCI HAR Dataset//test//X_Test.txt"
 file_path_test_activity <-"C://DataScience//GettingandCleaningData//Project//UCI HAR Dataset//test//y_test.txt"
 file_path_test_subject <-"C://DataScience//GettingandCleaningData//Project//UCI HAR Dataset//test//subject_test.txt"
 file_path_train <-"C://DataScience//GettingandCleaningData//Project//UCI HAR Dataset//train//X_Train.txt"
 file_path_train_activity <-"C://DataScience//GettingandCleaningData//Project//UCI HAR Dataset//train//y_train.txt"
 file_path_train_subject <-"C://DataScience//GettingandCleaningData//Project//UCI HAR Dataset//train//subject_train.txt"

 data_test<-read.table(file_path_test,header=FALSE)
 data_test_act<-read.table(file_path_test_activity,header=FALSE)
 data_test_subt<-read.table(file_path_test_subject,header=FALSE)
 data_test_all<-cbind(data_test,data_test_act,data_test_subt)
 colnames(data_test_act)[1]<-"activity_id"
 colnames(data_test_subt)[1]<-"subject_d"
 data_test_all<-cbind(data_test,data_test_act,data_test_subt)
 colnames(data_test_subt)[1]<-"subject_id"
 colnames(data_test_act)[1]<-"act_id"
 data_test_all<-cbind(data_test,data_test_act,data_test_subt)
 data_train<-read.table(file_path_train,header=FALSE)
 data_train_act<-read.table(file_path_train_activity,header=FALSE)
 data_train_subt<-read.table(file_path_train_subject,header=FALSE)
 colnames(data_train_act)[1]<-"act_id"
 colnames(data_train_subt)[1]<-"subject_id"
 data_train_all<-cbind(data_train,data_train_act,data_train_subt)
 data_all<-rbind(data_train_all,data_test_all)
 

# Add Activity descriptions and extracts the mean and standard deviation column for each measurement
#------------------------------------------------------------------------------------------------------ 
# Note : I am including all the columns has mean and std in the column definitions.

 file_path_feature <-"C://DataScience//GettingandCleaningData//Project//UCI HAR Dataset//features.txt"
data_features<-read.table(file_path_feature,header=FALSE)

file_path_activity_labels <-"C://DataScience//GettingandCleaningData//Project//UCI HAR Dataset//activity_labels.txt"
data_act_labels<-read.table(file_path_activity_labels,header=FALSE)
data_activity_lables<-read.table(file_path_activity_labels,header=FALSE)

colnames(data_activity_lables)[1]<-"act_id"
colnames(data_activity_lables)[2]<-"Activity"
c2<-c1$V2
colnames(data_all)<-c2
c2<-data_features$V2
data_all<-rbind(data_train_all,data_test_all)
colnames(data_all)<-c2
c3<-data_all[,c(562:563)]
c4<-data_all[,c2]
c2<-data_features$V1
c1<-filter(data_features, grepl('std|mean', V2))
x<-c1$V1
data_x<-data_all[,x]
data_y<-cbind(data_x,c3)
colnames(c3)[1]="Activity_Id"
colnames(c3)[2]="Subject_Id"
data_y<-cbind(data_x,c3)
colnames(data_act_labels)[1]="Activity_Id"
colnames(data_act_labels)[2]="Activity"
data_total<- merge(data_y, data_act_labels, by.x = "Activity_Id", by.y = "Activity_Id")


# Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#---------------------------------------------------------------------------------------------------------------------------
 library(reshape2)
 data_total_Melt<-melt(data_total,id=c("Activity_Id","Activity","Subject_Id"),measures.vars=c1$V2)
 data_clean<-data_total_Melt[,c(2:5)]
 
 data_final<-dcast(data_clean, Activity + Subject_Id~variable,mean)


write.table(data_final,file="tidy.txt", row.names = FALSE)

file_path_final <-"tidy.txt"
data_output<-read.table(file_path_final,header=TRUE)
View(data_output)





