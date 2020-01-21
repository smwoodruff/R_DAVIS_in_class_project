#Sidney Woodruff
1+100
3 + 5 * 2
#r uses the order of operations
#use parentheses to force order of operations
#scientific notation is also used

2 / 10000

1e9 * 8

#function in R

sin(3.14)

log(3)

exp(0.5)

#nested functions, interpretted from the inside out

sqrt(exp(4))

#Comparisons in R
#R can do logical comparisons

1 == 1
1 == 3

#In R, "not" is !

1 != 2

#objects and assignments in R
#objects are like variables

x <- 1/4

#now you have x stored as an object so you can run functions on it

log(x)

x <- 99

#you can reassign the objects with the objects as well
x <- x + 1

#you can make new objects and name them anything
y <- x * 10

this_is_my_object <- 90
#No spaces allowed in object names. Some people use periods or dashes or capitalizations. Be descriptive though so you don't forget what you used
#Even if names are long, it's helpful to have full descriptions because R will used 'predictive' entries of your objects, called tab completion

#arguments and functions
log(3, 10)
log(x = 3, base = 10) #this line of code is the same as the one before
log(base = 10, x = 3) #this is the workaround if the numbers aren't in the right order

#Once you open the function, you can hit tab and choose the required pieces of the function and see your available objects

log(aword)

