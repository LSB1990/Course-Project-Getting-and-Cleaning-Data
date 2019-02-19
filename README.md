# Course-Project-Getting-and-Cleaning-Data
## Introduction
This is the repository for the project made in the context of Getting and cleaning data module from the data scientist specialization from cousera.

## Instruction from coursera (direcly copied from the website):
"The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. " 

## Content of the Github

In this repository, you will find: 
*This readme file explaining the content of the project and how the script works
*Code book file describing ther different variable
*The final output in txt format directly obtain from the code
*The R-script that give the final output in txt format 

## R-script description

I structured the script in 5 main step: 

* Step 0: common step in all my code which consist on loading the good package (here dplyr and plyr) and the good data (here the data described above)

* Step 1: Getting the different data and create dataframe according to the structure describe above. This is the basic building block that we want to clean, combine and tidying later on. I also take care on this step to properly name all the column. This dataframe are Feature_list (with all the different features -- column names), totaltrain (which is all the data for training part) and totaltest (which is all the data for the test part)

* step2: Extracting the good mapping table. I basicaly make two "mapping" table. First one is Label_activity to associate the number of the activity with the name of it (Waling, laying, ...). The second one is a subset of Feature_list that consist on all the feature that concern mean and std. I notice that in the different features names some of them add capital letter for mean (e.g. "angle(Y,gravityMean)" ) therefore when I subset it I made it specific that mean and std may have capital letter as well as small cap. 

* step3: Combining all the different table described aboved in one call FinalTidySet. Then substract from it the features we are interested in. And finaly map the activiy-label with the activity-name to only have a descriptive value for the activity and not a number. 

* step4: Creating the independant tidy data set. I called it TidySetMean. I made the mean by activiy and by subject Id in that order as prescribed and finally write down the final output txt file with the write.table() comment.


