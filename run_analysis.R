# Getting and Cleaning Data Course Project
# Goal is to read test and training datasets, merge and add headers
# Data is collected per subject per activity, so we also need to 
# use descriptive names for the activities.
# At the end, create a new dataset summarised by subject and activity (mean of each variable)

library(reshape2)

# It appears the files are fixed width, with either a space or a negative sign as the first character
# We could specify column lengths, however, if we don't specify a separator 
# read.table will treat space as a separator and treat double spaces as just one separator

# Read in the test dataset (3 files, subject, activity and measurements)
sub <- read.table("test/subject_test.txt", sep="", header=F)

act <- read.table("test/y_test.txt", sep="", header=F)

d <- read.table("test/X_test.txt", sep="", header=F)

# Merge the test datasets into one
test <- cbind(sub, act, d)

# Read in the test dataset (3 files, subject, activity and measurements)
# Use the same variables as before as we no longer need them
sub <- read.table("train/subject_train.txt", sep="", header=F)

act <- read.table("train/y_train.txt", sep="", header=F)

d <- read.table("train/X_train.txt", sep="", header=F)

# Merge the train datasets into one
train <- cbind(sub, act, d)

# Merge the test and training datasets
data <- rbind(test, train)

# Next read in the names of the measurements so we can add them to our data
f <- read.table("features.txt", sep=" ", header=F)
# Add subject and activity as these are not contained in the 
cols <- c("Subject", "Activity", as.character(f$V2))

names(data) <- cols

# Work out the columns of interest, only the mean and standard deviation columns
# Note that there are some columns containing the work mean that are not mean
# columns, such as meanFreq and angle(X,gravityMean), hence including "(" in the grep

length(grep("mean[(]|std[(]", tolower(cols), value = T))
# 33 mean measurements, 33 Standard Deviation measurements - 66 in total, as expected

# Restrict dataset to subject, activity and mean/std measurements
data <- data[(c(1,2,grep("mean[(]|std[(]", tolower(cols))))]

# Read in the activity labels and name the columns
act_lab <- read.table("activity_labels.txt", sep="", header=F)
names(act_lab) <- c("ID","Activity")

# Use sapply with a custom function to translate activity numbers into labels
data$Activity <- sapply(data$Activity, function(x) as.character(act_lab[x,]$Activity))

# Rename the columns to be a bit more R friendly, replace "-" with "."
# and remove "()" from the end
names(data) <- gsub("()","",gsub("-",".", names(data)), fixed=T)

# Next we want to summarise the data down to one row per subject per activity
# and take the mean of each measure. In keeping with the concepts of tidy data
# each measure should remain in its own column.
# Use reshape2's methods to 'melt' the dataset down to a four column structure
# Then use cast to bring it back to the original structure, calculating the mean
summ <- melt(data, id=c("Subject", "Activity"))
summ <- dcast(summ, Subject+Activity~variable, mean)

# Write the dataset out to file
write.table(summ, file="summarised_data.txt", row.names = FALSE)

