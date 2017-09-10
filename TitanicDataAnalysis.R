# Load raw data
train <- read.csv("train.csv", header = TRUE)
test <- read.csv("test.csv", header = TRUE)

# Add a survived variable to the test set to allow for combining data sets
# 1) add variable called survived in test
# rep = function from r that allows us to replicates the value "None" for nrow(test) times
# nrow(test) = 418
# repeat None 418 times assigned to survived variable in test
# test[,] = take all rows and columns from test
# test[1,5] = spits the data that is in row = 1 and column = 5

# take entire test table and combine it with 418 strings of none and return it
# as a new dataframe and assign it to test.survived
test.Survived <- data.frame(Survived = rep("None", nrow(test)), test[,])

# swap column 1 and 2 of train to match test.survived. DO NOT CHANGE THE COLUMN NAMEs
for(i in 1:nrow(train)){
  train[i,13] = train[i,1]
  train[i,1] = train[i,2]
  train[i,2] = train[i,13]
}

# change column  names in train to match colmumn names in test.survived
colnames(train) <- c("Survived","PassengerId","Pclass","Name","Sex","Age","SibSp","Parch","Ticket","Fare","Cabin","Embarked","V13")												

# delete the V13 column of train 
train$V13 = NULL

# Check if names of the columns of the two data table are same
identical(names(train[12]), names(test.Survived[12]))

# combine test.Survived dataset and train data sets
# data.combined = append test.Survived to train data
data.combined <- rbind(train, test.Survived)

# About R data types
# compactly display the structure of an aribitary R object
# describes the data type of data.combined
str(data.combined)

# Change pclass variale data type to factor from integer
data.combined$Pclass <- as.factor(data.combined$Pclass)
# change survived variable data type to factor from character
data.combined$Survived <- as.factor(data.combined$Survived)

#====================================
#
# Exploratory Modeling
#
#====================================
library(randomForest)

# Train a Random Forest with the default parameters using pclass and title
# grab first 891 data sets with only 2 column pclass and title
rf.train.2 <- data.combined[1:891, c("pclass", "title")]
# dedicated label variable
rf.label <- as.factor(train$Survived)
