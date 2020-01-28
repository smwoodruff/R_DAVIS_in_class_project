#Week 4 of R-Davis

#Factors are used to represent categorical data.
#Factors of data

sex <- as.factor(c("male", "female", "male", "male"))
sex
#We can see that there are two levels in the sex vector and female is listed first because it's in alphabetical order

class(sex)
typeof(sex)
#Predefined, can't go back in and add levels

#Reordering factor
#Not important with this vector, but if it were "low", "medium", "high", then we might want to reorder them

sex <- factor(sex, levels = c("male", "female"))
sex

#Converting factors to characters
as.character(sex)
#Before there were no quotation marks around the values, but now when we run sex, there are quotations around the values, showing that they're not characters
as.character(sex)

year_fct <- as.factor(c(1990, 1983, 1977, 1998, 1990))

as.numeric(year_fct)
#Doesn't really work because it's assigning each year as a number and putting them into the earliest order

#To convert them into actual numeric numbers, we have to add an extra step
as.numeric(as.character(year_fct))

#In we wanted to change it in the environment
year_fct <- as.numeric(as.character(year_fct))


#Renaming factors and levels within factors
levels(sex)
#Let's say your advisor said all of the values have to be capitalized

#We have to bring out one value in the vector
levels(sex)[1]

#Then write it how you want it to be 
levels(sex)[1] <- "MALE"


#Challenge
#Rename the levels of sex to “F” and “M”
#Now order the levels so that “F” is first and “M” is second
#Hint: you’ll have to do this in 2 steps

levels(sex)[1] <- "M"
levels(sex)[2] <- "F"
levels(sex)

sex <- factor(sex, levels = c("F", "M"))
levels(sex)






#Starting with Data
#Get into the habit of saving the raw data as a .csv file

surveys <- read.csv("data/raw_data/portal_data_joined.csv")
#Now the data will be in the Environments tab under Data
#You can click "surveys" and it'll generate a table you can view

class(surveys)
#"data.frame" - every column is the same length

nrow(surveys)
#This tells us how many rows there are
head(surveys)
#This will tell you the first ten rows

colnames(surveys)
#Name of all of the columns

summary(surveys)
#This will give you a nice summary about every different column
#SUPER helpful



#Challenge
#Based on the output of str(surveys), can you answer the following questions? * What is the class of the object surveys? * How many rows and how many columns are in this object? * How are our character data represented in this data frame? * How many species have been recorded during these surveys?
str(surveys)


#What is the class - data.frame
#How many rows and columns - rows = 34786, columns = 13
#How are our character data represented in this data frame - as factors, not characters
#How many species have been recorded - 48


#To do species_id as characters
surveys$species_id <- as.character(surveys$species_id)

str(surveys)

#Pulling out unique indentifiers in a column
unique(surveys$species_id)
unique(surveys$species)
#The $ is for pulling out single columns in a data frame - only works for columns




#Indexing and subsetting dataframes
#We use brackets for this, but because data.frames are two things (columns and rows), our brackets need both column and rows
#[row, column] -  always in that order

surveys[1, 1]
#Row 1, column  1

surveys[1, 6]


#Entire third column
surveys[  , 3]
#if there is a blank space, R thinks we want everything in that row


#How about first 3 elements of the 7th column
surveys[c(1, 2, 3), 7]
#Can also do 
surveys[1:3, 7]
surveys[c(1, 3, 5), 7]

#All columns rows 1-6
surveys[6, ] #this is just the 6th row
surveys[1:6, ]


#Exclude the first column
surveys[ , -1]

surveys[-c(7:34786), ]
surveys[-c(5:34786), ]


#You can also call the columns by their name
surveys["species_id"]
surveys[1:6, "species_id"]


#CHALLENGE
#Create a data.frame (surveys_200) containing only the data in row 200 of the surveys dataset.
#Notice how nrow() gave you the number of rows in a data.frame?
  #Use that number to pull out just that last row in the data frame.
#Compare that with what you see as the last row using tail() to make sure it’s meeting expectations.
#Pull out that last row using nrow() instead of the row number.
#Create a new data frame (surveys_last) from that last row.
#Use nrow() to extract the row that is in the middle of the data frame. Store the content of this row in an object named surveys_middle.
#Combine nrow() with the - notation above to reproduce the behavior of head(surveys), keeping just the first through 6th rows of the surveys dataset.

surveys_200 <- surveys[200, ]

nrow(surveys)
surveys[34786, ]
tail(surveys) #Opposite of head and gives you the last 6 rows
n_rows <- nrow(surveys)
surveys[n_rows, ]
#Get the row that is exactly in the middle of the data frame
surveys[n_rows/2, ]

surveys_head <- surveys[-c(7:n_rows), ]



#TIDYVERSE HUZZAH
install.packages("tidyverse")
#install.packages("tidyverse")

#You do have to load the package within the script
#How to load a package
library(tidyverse)


#Before in Base R, we used read.csv
#In tidyverse
surveys <- read_csv("data/raw_data/portal_data_joined.csv")
#The columns are coming in as characters
#col_double is another way tidyverse looks at the data - integer numbers
surveys
class(surveys)

#The factors are now characters

#dplyr is an awesome package
#Comes with tidyverse and is useful when subsetting vectors

#Select and filter

#Select is for columns, and filter is for rows

#Let's say we only need certain columns
surveys_new <- select(surveys, plot_id, species_id, weight)

#We want all of the plot_ids that are 3
filter(surveys, plot_id == 3)
survey_plot3 <- filter(surveys, plot_id == 3)


#Let's talk about pipes

#I want all weights greater than 5 and only the columns species_id, sex, and weight
#Using intermediate steps
surveys2 <- filter(surveys, weight > 5)
surveys_sml <- select(surveys2, species_id, sex, weight)


#Pipes are useful if you wanted to do many things at once so you don't have to do all of those intermediate steps

#a pipe looks like this %>%
#on a mac, a shortcut is command + shift + m
#hit enter after piping so it reads easier
#also don't need to tell R what data frame we want to filter from because it's pulling from the original frame at the beginning of the function
surveys_sml2 <- surveys %>% 
  filter(weight > 5) %>% 
    select(species_id, sex, weight)







