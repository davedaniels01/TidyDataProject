
run_analysis.R


Instructions:

	1. Set the working directory to the folder that contains the Samsung Data.
	2. Copy the Github files "run_analysis.R" and "subfeatures.txt" to the same data 
		working directory. Subfeatures.txt provides more descriptive variable/column 
		names for the mean and standard deviation related columns.
	3. Source the file run_analysis.R
	4. Run function run_analysis().


Function Details:

	1 Merges the training and the test sets to create one data set.
	2 Extracts only the measurements on the mean and standard deviation for each measurement.
	3 Uses descriptive activity names to name the activities in the data set
	4 Appropriately labels the data set with descriptive variable names. 
	5 From the data set in step 4, creates a second, independent tidy data set with the average of each 
	     variable for each activity and each subject.



The steps used by run_analysis.R
	
-----------------------------------------------------------------
FEATURES DATA
-----------------------------------------------------------------
	
Make fwf template (column widths)
	Creates a vector "cols" that defines the column positions for the fixed 
	format files with 561 columns.

Read features file
	Reads the data file features.txt using format "cols", create data 
	frame "features"
	
Find features that are "mean()" or "std()"
	Searches the features data frame to find columns that use "mean()" or "std()". 
	Creates a temp data frame named f2.
	
Re-Order f2 by indexes 
	Reorders the combined data frame (f2) of features by index. Creates temp data 
	frame f3.

Make a indexes vector
	Extracts column V1 from f3 to create an "indexes" vector.

Read "subfeatures.txt"
	Reads new txt file that contains more descriptive column/variable names
	for mean and std columns only.

Cleanup (features)
	Deletes objects that are no longer needed.

-----------------------------------------------------------------
TRAINING DATA
-----------------------------------------------------------------

Reads training data
	Reads the training data in "/train/X_train.txt" to create data frame "df1"

Reads the training subject file
	Reads the file "/train/subject_train.txt" that contains the subjects that 
	correspond to df1 data rows. Create data frame "subjects1".

Reads the training activity file
	Reads the file "/train/y_train.txt" that contains the activity (factor, 1-6) 
	that correspond to df1 data rows. Creates data frame activity1.

Replaces activity numbers (ids) with factor values (text descriptions)
	Replaces id numbers in the data frame activity1 with factor values 
	(text values).

Sets data frame column names 
	Set the column names for df1 from the "features" data frame.

Subsets the training data frame df1
	Extracts the columns from df1 for mean and std. Creates temp data frame df1x. 
	Uses the "indexes" data frame as a filter.

Adds the subjects vector to the training data frame (new column)
	Creates fd1$subject column from the subjects1 dataframe.
	
Add the activity vector to the training data frame (new column)
	Creates fd1$activity column from the activity1 dataframe.

Cleanup 
	Deletes objects that are no longer needed.

-----------------------------------------------------------------
TEST DATA
-----------------------------------------------------------------

Reads test data
	Reads the test data in "/test/X_test.txt" to create data frame "df2"

Reads the test subject file
	Reads the file "/test/subject_test.txt" that contains the subjects that 
	correspond to df2 data rows. Create data frame "subjects2".

Reads the test activity file
	Reads the file "/test/y_test.txt" that contains the activity (factor, 1-6) 
	that correspond to df2 data rows. Creates data frame activity2.

Replaces activity numbers (ids) with factor values (text descriptions)
	Replaces id numbers in the data frame activity2 with factor values 
	(text values).

Sets data frame column names 
	Set the column names for df2 from the "features" data frame.

Subsets the test data frame df2
	Extracts the columns from df2 for mean and std. Creates temp data frame df2x. 
	Uses the "indexes" data frame as a filter.

Adds the subjects vector to the test data frame (new column)
	Creates fd2$subject column from the subjects2 dataframe.
	
Add the activity vector to the test data frame (new column)
	Creates fd2$activity column from the activity2 dataframe.

Cleanup 
	Deletes objects that are no longer needed.

-----------------------------------------------------------------
- ANALYSIS
-----------------------------------------------------------------

Combines training and test data
	Combines training and test data frames to create tidy data frame "tidy1".

Cleanup
	Deletes individual training and test data frames df1x and df2x

Group_by and Summarize 
	Uses a pipeline of functions to Group-by and Summarize tidy1 data frame to 
	create an average across Activity and Subject. Creates data frame "tidy2".
	
Create output files
	Writes data from tidy1 and tidy2 to text files.

-----------------------------------------------------------------
