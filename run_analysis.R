

###################Step 0  getting appropriate package and data############################# 

library(dplyr)
library(plyr)

URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"  ##path to download the zip file
namefile <- "UCI HAR Dataset"

## Download dataset after checking it is not allready existing:
if (!file.exists("getdata_projectfiles_UCI HAR Dataset")){ 
  download.file(URL, "getdata_projectfiles_UCI HAR Dataset")
}  
if (!file.exists(namefile)) { 
  unzip("getdata_projectfiles_UCI HAR Dataset")    ##unzip if not existing
}



###################Step 1  getting data and combining them #############################

##getting the feature list
Features_List <- read.table(paste(namefile,"\\features.txt", sep=""))  ##Getting the feature name (means, std, and so on)


## for training
datatraining <- read.table(paste(namefile,"\\train\\X_train.txt",sep="")) ##extracting the value of the data
traininglabel <- read.table(paste(namefile,"\\train\\y_train.txt",sep=""))   ##label from 1 to 6
subjectidentifier <- read.table(paste(namefile,"\\train\\subject_train.txt",sep="")) ## identifier of the subject who performed the activity from 1 to 30
totaltrain <- cbind(traininglabel,subjectidentifier, datatraining)

colnames(totaltrain) <- c("Label", "SubjectID",as.character(Features_List$V2)) ##Good labeling of the columns



##for test
datatest <- read.table(paste(namefile,"\\test\\X_test.txt",sep=""))  ##extracting the value of the data
testlabel <- read.table(paste(namefile,"\\test\\y_test.txt",sep=""))   ##label from 1 to 6
testsubjectidentifier <- read.table(paste(namefile,"\\test\\subject_test.txt",sep="")) ## identifier of the subject who performed the activity from 1 to 30
totaltest <- cbind(testlabel,testsubjectidentifier, datatest)
colnames(totaltest) <- c("Label", "SubjectID",as.character(Features_List$V2)) ##Good labeling of the columns


###################Step 2  getting the mapping label-activity and the mapping Features for mean and std#############################


Label_Activity <- read.table(paste(namefile,"\\activity_labels.txt",sep = "" )) ##getting the appropriate name for the activities
colnames(Label_Activity) <- c("Label","Activity")     ##Appropriate names to our variables/columns
##filtering from the orignal feature list all the feature concerning meand and std, some of them are written 
##with capital letter upfront therefore we specified capital/not capital letter: 
NewFeaturesList <- filter(Features_List, grepl("[Mm]ean|[Ss]td",Features_List$V2))


###################Step 3 combining previous step in order to get on final tidy set with good despcriptive names#############################


Finalstidyset <- rbind(totaltest,totaltrain) ##getting all data together
Finalstidyset2 <- Finalstidyset[,c("Label","SubjectID",as.vector(NewFeaturesList[,2]))] ## filtering from our data frame only the data for mean and std
TidySet <- Finalstidyset2 %>%
  merge(Label_Activity,"Label")%>% ##merge to get the descriptive activity name instead of the label
  select("Activity","SubjectID", as.vector(NewFeaturesList[,2]))  ##properly reordercolumn and removed the unnecessary label column


###################Step 4 creating independant tidy data set with mean per activity and subject#############################


TidySetMean <- TidySet %>%
group_by(Activity,SubjectID) %>%  ##grouping by acitivity and ID
  summarise_all(funs(mean))  ##getting the mean over the previous grouping in order to final get the mean for each variable by Subject and activity


write.table(TidySetMean, "tidy.txt", row.names = FALSE, quote = FALSE)

