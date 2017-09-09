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
test.survived <- data.frame(survived = rep("None", nrow(test)), test[,])

# swap column 1 and 2 of train to match test.survived. DO NOT CHANGE THE COLUMN NAMEs
for(i in 1:nrow(train)){
  train[i,13] = train[i,1]
  train[i,1] = train[i,2]
  train[i,2] = train[i,13]
}

# change column  names in train to match colmumn names in test.survived
colnames(train) <- c("Survived","PassengerId","Pclass","Name","Sex","Age","SibSp","Parch","Ticket","Fare","Cabin","Embarked	","V13")												

# delete the V13 column of train 
train$V13 = NULL
