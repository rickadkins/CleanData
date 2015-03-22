# CleanData

Make sure the files are in the working directory

load in teh X_train.txt and X_Test.txt files
combine into one data.frame called combine.df

Add a column to identify the source for the data.

Read in the train and test subject files.
Add as column to the combine.df data.frame

Read in the activity files.
Convert to names useful to human readers
Add as column to combine.df data.frame

Read in the column names from features file
Add in the source, subjects, activities, and activitiesID to the column names
Assign the column names to the data.frame

Determine the columns desired for the output (...mean() and ...std()).
Append in the new columns indexes

create new data.frame named combine.reduced as subset of combine.df


Generate the desired grouping.
save as a txt file using write.table.

