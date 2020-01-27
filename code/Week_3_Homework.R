set.seed(15)
hw3 <- runif(50, 4, 50)
hw3 <- replace(hw3, c(4,12,22,27), NA)
hw3

#PROBLEM 1:
#Take you hw3 vector and remove all the NAs then select all the numbers between 14 and 38 inclusive, call this vector prob1.

class(hw3)

#This just removed all of the NAs amd defined the new vector as hw3.1 
hw3.1 <- hw3[complete.cases(hw3)]
hw3.1

#This chose numbers between 14 and 38 and then named that set of numbers as a new vector defined as prob1
prob1 <- hw3.1[hw3.1 >14 & hw3.1 <38]


#PROBLEM 2:
#Multiply each number in the prob1 vector by 3 to create a new vector called times3. Then add 10 to each number in your times3 vector to create a new vector called plus10.

3*prob1
times3 <- 3*prob1

10 + times3
plus10 <- (10 + times3)


#PROBLEM 3:
#Select every other number in your plus10 vector by selecting the first number, not the second, the third, not the fourth, etc. If you’ve worked through these three problems in order, you should now have a vector that is 12 numbers long that looks exactly like this one:

plus10
plus10[seq(1, length(plus10), 2)]
final <- plus10[seq(1, length(plus10), 2)]

#Can also do...
final.2 <- plus10[c(TRUE, FALSE)]
final.2




  