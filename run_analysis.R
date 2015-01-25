
# Function run_analysis
#
#   1 Merges the training and the test sets to create one data set.
#   2 Extracts only the measurements on the mean and standard deviation for each 
#		measurement.
#   3 Uses descriptive activity names to name the activities in the data set
#   4 Appropriately labels the data set with descriptive variable names. 
#   5 From the data set in step 4, creates a second, independent tidy data set with 
#		the average of each variable for each activity and each subject.
#   
#   See readme.txt for details



run_analysis <- function() {

# make fwf template (column widths)
cols <- rep(c(-1,15), 561)

# read features file
features <- read.table("features.txt", sep=" ", header=FALSE)

# find features that are "mean()" or "std()"
f2 <- features[c(grep("mean()", features$V2, fixed = TRUE),
                 grep("std()", features$V2, fixed = TRUE)), ]

# reorder the combined list of features by index
f3 <- f2[order(f2$V1),]

# make a vector
indexes <- f3$V1

# cleanup
rm(f2)
rm(f3)


# read features for mean() and std() only
# Created this to provide better descriptive variable names (column headers)
subfeatures <- read.csv("subfeatures.txt", header=FALSE)

#-----------------------------------------------------------------
    
# read training data
df1 <- read.fwf(
    file="./train/X_train.txt",
    widths=rep(c(-1,15), 561),
    skip=0
)

# read the training subject file
subjects1 <- read.table("./train/subject_train.txt", sep=" ", header=FALSE)

# read the training activity file
activity1 <- read.table("./train/y_train.txt", sep=" ", header=FALSE)

# replace activity numbers (ids) with factor values
activity1$V1[activity1$V1 == 1] <- "WALKING"
activity1$V1[activity1$V1 == 2] <- "WALKING_UPSTAIRS"
activity1$V1[activity1$V1 == 3] <- "WALKING_DOWNSTAIRS"
activity1$V1[activity1$V1 == 4] <- "SITTING"
activity1$V1[activity1$V1 == 5] <- "STANDING"
activity1$V1[activity1$V1 == 6] <- "LAYING"


# set dataframe column names from features
colnames(df1) <- features$V2

# subset the training data frame (just indexes we want, mean and std)
df1x <- df1[,indexes]

# add the subjects vector to the training data frame (new column)
df1x$subject <- subjects1$V1

# add the activity vector to the training data frame (new column)
df1x$activity <- as.factor(activity1$V1)

# cleanup
rm(df1)
rm(subjects1)
rm(activity1)

#-----------------------------------------------------------------
   
# read test data
df2 <- read.fwf(
    file="./test/X_test.txt",
    widths=rep(c(-1,15), 561),
    skip=0
)

# read the test subject file
subjects2 <- read.table("./test/subject_test.txt", sep=" ", header=FALSE)

# read the test activity file
activity2 <- read.table("./test/y_test.txt", sep=" ", header=FALSE)

# replace activity numbers (ids) with factor values
activity2$V1[activity2$V1 == 1] <- "WALKING"
activity2$V1[activity2$V1 == 2] <- "WALKING_UPSTAIRS"
activity2$V1[activity2$V1 == 3] <- "WALKING_DOWNSTAIRS"
activity2$V1[activity2$V1 == 4] <- "SITTING"
activity2$V1[activity2$V1 == 5] <- "STANDING"
activity2$V1[activity2$V1 == 6] <- "LAYING"


# set dataframe column names from features
colnames(df2) <- features$V2

# subset the test data frame (just indexes we want, mean and std)
df2x <- df2[,indexes]

# add the subjects vector to the test data frame (new column)
df2x$subject <- subjects2$V1

# add the activity vector to the test data frame (new column)
df2x$activity <- activity2$V1

# cleanup
rm(df2)
rm(subjects2)
rm(activity2)

#-----------------------------------------------------------------

# combine training and test data frames (tidy data set)
tidy1 <- rbind(df1x, df2x)
colnames(tidy1) <- subfeatures$V1

# cleanup 
rm(df1x)
rm(df2x)

# group_by and summarise for Average across Activity and Subject 
tidy2 <- 
    tidy1 %>%
    group_by(Activity,Subject) %>%
    summarise_each(funs(mean))

# create output files
write.table(tidy1, file = "tidy_data1.txt", sep = " ", row.names = FALSE, col.names = TRUE)
write.table(tidy2, file = "tidy_data2.txt", sep = " ", row.names = FALSE, col.names = TRUE)

}

