Week_3_SidneyWoodruff

#Going over the assignment, adding image to the ReadMe markdown file, use ![]()
#The square brackets is for "alt-text" which is a nice way for you to caption the image without having to open it
#The parentheses is the pathway that you will use to get the image, within your repository


#Vectors Lecture
x <- 5
#This would assign a vector with one line
#You can also assign vectors with multiple entries and lines
#Example

c(50, 60, 65, 82)
#This is kind of like a table but with one column
#Then we can name that
weight_g <- c(50, 60, 65, 82)
#Now this shows up in the environments tab
#Notice it has "num" in front because it's numerical

#We can also do characters
animals <- c("mouse", "rat", "dog")

#class tells us the data type in a vector
class(weight_g)
class(animals)

# str for structure
str(weight_g)
str(animals)

#We can also modify vectors with the c() function, as in adding lines to the vector

weight_g <- c(weight_g, 90)
weight_g <- c(30, weight_g)


#Class
#Semi colon between numbers uses all whole number integers between the two numbers

x <- (1:10)
class(x)

#Quiz

num_char <- c(1, 2, 3, "a")
class(num_char)
char_num <- c(1, 2, 3, "a")

#What is happening is coersion. R is making the two different classes in the combine into one class

num_logical <- c(1, 2, 3, TRUE)
class(num_logical)
#This just read TRUE like 1 because it's using the common computer language or 0 for false and 1 for true

char_logical <- c("a", "b", "c", TRUE)
class(char_logical)
char_logical

#Any character in the vector will turn everything into vectors
tricky <- c(1, 2, 3, "4")
class(tricky)
#Still reading as a character because the 4 was in "4" which makes it a character

#Challenge 2
combined_logical <- c(num_logical, char_logical)
combined_logical

#Because of the two steps, it was changed from TRUE to 1 in the original num_logical was changed from TRUE to 1. Then combining that with char_logical, there was only one "TRUE" at the end.
#Coersion works by saying the pickiest thing is true
#Check the type
class(combined_logical)


#Subsetting vectors
animals <- c("mouse", "rat", "dog", "cat")
animals[2]
#You can give vectors of index values you want
animals[c(3,2)]
animals[c(3, 2, 4, 1, 2, 1)]
#The index values correspond to the finite resource. It's literally asking, "What's the third entry? What's the first entry? What's the third one again?"
#Indices start at 1
animals[0]


#Conditional subsetting
weight_g <- c(21, 34, 39, 54, 55)
weight_g[c(TRUE, FALSE, TRUE, TRUE, FALSE)]

weight_g > 50
#Following logical values with doing things inside and outside
weight_g[weight_g > 50]

#Multiple operations at once
#The symbol | is used as or
weight_g[weight_g <30 | weight_g > 50]

weight_g[weight_g >= 30 & weight_g == 21]
#This doesn't work with our vector. No values in weight_g that can be greater than or equal to 30 and also equal to 22


animals
animals[animals == "cat" | animals == "rat"]

#Percent in percent function
#"Are these values found in the vector
animals %in% c("mouse", "rat")

animals[animals %in% c("mouse", "rat")]

#Challenge

"four" > "five"
four > five
"four"
"five"
"four" == "five"
"z" > "a"
"a" > "z"
#This works because R orders things alphabetically. 



#Vector Math
x <- 1:10
x + 3
x * 10


y <- 100:109
x + y
#What happens if you try to add two vectors that are not the same length
x
z <- 1:2
x + z
#Vector recycling
#For addition, R needs two vectors that are the same length. If they aren't the same length, then R recycles the shortest vector and uses it again until the longer vector is completely used


z <- 1:3
x + z
#Gave us a warning, not an error
a <- x + z
#It does a partial recycling then because the two vectors were not multiples of the shorter object
#That's why we check the structure of things
str(x)
str(z)

length(x)
length(z)


#Recycling with conditional subsetting
x[c(TRUE, FALSE)]

x[c(TRUE, FALSE, FALSE)]

#Working with Missing Data
#In R, missing data are represented as NAs

heights <- c(2, 4, 4, NA, 6)
mean(heights)
max(heights)
#Won't work because there is something else in the vector that is not a number

#na.rm = NA Remove
mean(heights, na.rm = TRUE)
max(heights, na.rm = TRUE)
class(heights)
#the class is numeric, it's not a character because it's not in quotations

#is.na = Is it a NA?
is.na(heights)
#This gives you a logical output

#! = is not

!is.na(heights)
#This reads as "Is it NOT an NA?"
heights[!is.na(heights)]
heights[is.na(heights)]


#complete.cases
#This is extracting all of the elements that are complete cases (are not NAs)
heights[complete.cases(heights)]



#Challenge
heights2 <- c(63, 69, 60, 65, NA, 68, 61, 70, 61, 59, 64, 69, 63, 63, NA, 72, 65, 64, 70, 63, 65)

median(heights2, na.rm = TRUE)
#Can also do it 

heights2 <- heights2[complete.cases(heights2)]
heights2

length(heights2[heights2 > 67])
heights2[heights2 > 67]


#Factors
sex <- factor(c("male", "female", "female", "male"))
class(sex)
typeof(sex)
levels(sex)
nlevels(sex)
#Order is alphabetical
#Might want to specify the order, for example high medium low in a graph but R would put it as high low medium

#Specify the order of the levels
sex <- factor(sex, levels = c("male", "female"))
sex


#To coerce factors to be vectors
sex_ch <- as.character(sex)
