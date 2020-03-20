# Week 10 in R-DAVIS
# Last week!


# If you're having to redo code and copy and paste sections a bunch, it's almost better to just write a function.
# Reduces the amount of code you have to type in or paste in
# More error prone

# Intro to writing functions
my_sum  <- function(a, b){
  the_sum <- a + b
  return(the_sum)
}

my_sum(a = 5, b = 10)
# The object of my_sum is  self contained within this function
# Notice this function is in the environment too
# Anything you define in the body of the function is contained in the function environment, not the global environment

# Everything that exists in that little word must be defined if you want to continue using it and will only stay in that little world.

# For example
a <- 20
b <- 30
my_sum()
# Doesn't work because you need to give them as arguments.
# The a and b are in the global environment

my_sum(10, 35)
# This works though without having to define them because it just assumes it's in order




my_sum2 <- function(a = 2, b = 5){
  the_sum <- a + b
  return(the_sum)
}

my_sum2()
my_sum2(12)
# In this one, 12 will take on the value as a and b will still be the same so it comes back as 17

# Also
my_sum2(b = 25) # This will give you 27 because it will still assume a is the same as 2 but change the b to 25 since you defined it

# Same again with when you define them
my_sum2(4, 1) # Gives you 5 because you defined them




# Functions to convert temperatures

F_to_K <- function(temp){
  K <- ((temp - 32) * (5/9)) + 273.15
  return(K)
}

# Let's check freezing point
F_to_K(32)

# Boiling point?
F_to_K(212)



# Challenge
K_to_C <- function(temp){
  C <- (temp - 273.15)
  return(C)
}

# Check freezing point
K_to_C(273.15)


# sourcing()-ing functions
# You can have a script that contains a bunch of functions
# Source takes a filepath
source("code/functions.R")
# This then brings in all of the code from that script, which contains our functions, and runs that code, thereby making those functions visible in the environment.



# Challenge
# Write a new function that takes two arguments, the gapminder data.frame and the name of a country, and plots the change in the country’s population over time. That is, the return value from the function should be a ggplot object. - It is often easier to modify existing code than to start from scratch. Feel free to start with the calcGDP function code.
library(cowplot)
library(tidyverse)
gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")


# Making a functions that returns a line plot of pop over time for a single country

d <- gapminder

d %>% 
  filter(country == "Afghanistan") %>% 
  ggplot(aes(x = year, y = pop)) +
  geom_line()

plot_pop_growth <- function(data, plot_country){
  plot <- data %>% 
    filter(country == plot_country) %>% 
    ggplot(aes(x = year, y = pop)) +
    geom_line()
  
  return(plot)
}

plot_pop_growth(data =  d, plot_country = "Mexico")
plot_pop_growth(data =  d, plot_country = "Canada")



# Intro to iteration

# Lots of base functions are already vectorized

x <- 1:10
log(x)


# If you're doing something a lot and simple, it's a lot easier to see if there is a base function that does it already so you don't need to reinvent the wheel


# For loops
for(i in 1:10){
  print(i)
}
# Prints differently than if we were to do just 1:10


# Multiple lines of code in one loop

for(i in 1:10){
  print(i)
  print(i^2)
}


# Using i as an index to subset
# Can use anything in that i spot, as along as it's consistent through the function
for(i in 1:10){
  print(letters[i])
  print(mtcars$mpg[i])
}
# First it'll give us A and then then first mpg value

# Sometimes we want to store the results of the function in the vector
# The most efficient way is to pre-allocate the size of the vector into an empty vector and then fill it in

# We want to use the mtcars data to generate stuff, so this will create an empty vector filled with NAs that is the length of mtcars
results <- rep(NA, nrow(mtcars))

for(i in seq_along(results)){
  results[i] <- mtcars$wt[i] * 1000
} #For loops run in the big global universe
# It will modify in the existing vectors

results

# Example
countries <- unique(gapminder$country)[1:10]

for (i in seq_along(countries)){
  p <- plot_pop_growth(data = d, plot_country = countries[i]) + ggtitle(countries[i])
  print(p)
  ggsave(plot = p, filename = paste0("images/gg_example_", countries[i], ".jpg"))
}



# Conditional statements
# Sometimes you want to run some code, but only if a certain condition is met

for(i in 1:10){
  if(i < 5){
    print(paste(i, "is less than 5"))
  } else {
    print(paste(i, "is greater than five"))
  }
}



# case_when is a nested conditional

mtcars %>% 
  mutate(car_size = case_when(
    wt > 3.5 ~ "big",
    wt > 2.5 ~ "medium",
    TRUE ~ "small"
  ))

# They evaluate in order


mtcars %>% 
  mutate(car_size = case_when(
    wt > 3.5 | cyl == 8 ~ "big",
    wt > 2.5 ~ "medium",
    TRUE ~ "small"
  ))
# More cars called big now because our conditions are the weight is over 3.5 or the cylinder is 8






