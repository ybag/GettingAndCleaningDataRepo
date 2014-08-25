rm(list=ls())
setwd('.');
features     = read.table('UCI HAR Dataset/features.txt',header=FALSE); #importing features.txt
activity_type= read.table('UCI HAR Dataset/activity_labels.txt',header=FALSE ); #importing activity_labels.txt
colnames(activity_type)  = c('activity_id','activity_type');  # Assigin column names to the data imported above

# Merging training and test sets into single data set."
subject_train = read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE) # reading subject_train.txt
x_train = read.table("UCI HAR Dataset/train/X_train.txt",header=FALSE)  # reading X_train.txt
y_train = read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE) # reading y_train.txt 

colnames(activity_type)  = c('activity_id','activity_type');
colnames(subject_train)  = "subject_id";
colnames(x_train)        = features[,2]; 
colnames(y_train)        = "activity_id";

# merging subject_train and y_train and x_train
train = cbind(y_train,subject_train,x_train);

subject_test = read.table("UCI HAR Dataset/test/subject_test.txt") # reading subject_test.txt 
x_test = read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)     # read testing data  
y_test = read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE)  # reading  activity testing data

colnames(subject_test) = "subject_id";
colnames(x_test)       = features[,2]; 
colnames(y_test)       = "activity_id";

# merge subject_test and y_test and X_test
test <- cbind(subject_test, y_test, x_test) 
 
data <- rbind(train, test) # merging together train and test

# Getting vector of the column names from the data to select the mean and std columns
columnNames  = colnames(data); 

# 2. Extract only the measurements on the mean and standard deviation for each measurement. 

# flagsVector  to select only ID, mean, std columns 
flagsVector  = (grepl("activity..",columnNames) | grepl("subject..",columnNames) | grepl("-mean..",columnNames) & !grepl("-meanFreq..",columnNames) & !grepl("mean..-",columnNames) | grepl("-std..",columnNames) & !grepl("-std()..-",columnNames  ));

# Filtering needed columns using  flagsVector
data = data[flagsVector==TRUE];

# 3.Changing  activity names in the data set

data = merge(data,activity_type,by='activity_id',all.x=TRUE); # Merging data set with the acitivity_type 
columnNames  = colnames(data);   # new column names 

# 4. Appropriately label the data set with descriptive activity names. 

# Cleaning up variable names
for (i in 1:length(columnNames)) 
{
  columnNames[i] = gsub("\\()","",columnNames[i])
  columnNames[i] = gsub("-std$","StdDev",columnNames[i])
  columnNames[i] = gsub("-mean","Mean",columnNames[i])
  columnNames[i] = gsub("^(t)","time",columnNames[i])
  columnNames[i] = gsub("^(f)","freq",columnNames[i])
  columnNames[i] = gsub("([Gg]ravity)","Gravity",columnNames[i])
  columnNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",columnNames[i])
  columnNames[i] = gsub("[Gg]yro","Gyro",columnNames[i])
  columnNames[i] = gsub("AccMag","AccMagnitude",columnNames[i])
  columnNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",columnNames[i])
  columnNames[i] = gsub("JerkMag","JerkMagnitude",columnNames[i])
  columnNames[i] = gsub("GyroMag","GyroMagnitude",columnNames[i])

};

# Reassigning the new descriptive column names to the data set
colnames(data) = columnNames;

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Create a new table, data_without_activity_type without the activity_typecolumn
data_without_activity_type  = data[,names(data) != 'activity_type'];

# Summarizing the data_without_activity_type table to include the mean of each variable 
tidyData    = aggregate(data_without_activity_type[,names(data_without_activity_type) != c('activity_id','subject_id')],by=list(activity_id=data_without_activity_type$activity_id,subject_id = data_without_activity_type$subject_id),mean);

# Merging the tidyData with activity_type for acitvity names
tidyData    = merge(tidyData,activity_type,by='activity_id',all.x=TRUE);

# Export the tidyData 
write.table(tidyData, './result.txt',row.names=TRUE,sep='\t');

