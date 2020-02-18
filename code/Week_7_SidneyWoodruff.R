# Week 7 in R-Davis

# Lesson for Week 7
# load survey data in

surveys_complete <- read_csv("data/raw_data/portal_data_joined.csv") %>% 
  filter(complete.cases(.)) #period means all columns

# We want to count the number of species seen in each year by species
yearly_counts <- surveys_complete %>% 
  count(year, species_id) # what its doing in the background is grouping before, doing the count, and then ungrouping
# it also created a new column with counts as n

# Now we want to plot this data
ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() # this connected all of the points though

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line(aes(color = species_id)) # each species gets its own color
# a little hard to read

ggplot(data = yearly_counts, mapping = aes(x = year, y = n, group = species_id)) +
  geom_line() # same graph but all species are the same color

ggplot(data = yearly_counts, mapping = aes(x = year, y = n, linetype = species_id)) +
  geom_line() # this differentiates the species_id by different line types and they're all the same color


# Faceting
ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
    facet_wrap(~ species_id)
# gives you individual graphs by species_id using the same axes
# looks pretty cool and does it all without having to make each graph individually and stitch them together



# Challenge 1
# Let’s make one final change to our facet wrapped plot of our yearly count data. What if we wanted to split the counts of species up by sex where the lines for each sex are different colors? Make sure you have a nice theme on your graph too!
# Hint Make a new dataframe using the count function we learned earlier!

yearly_counts <- surveys_complete %>% 
  count(year, species_id, sex)

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  facet_wrap(~ species_id) +
  geom_line(aes(color = sex)) # you could also put this in the ggplot line so it will be followed through to everything. Currently, the color by sex within geom_line will only look at sex by color within that line


# Themes
# A nice way to change the way your plot looks all at once

ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  facet_wrap(~ species_id) +
  geom_line(aes(color = sex)) +
  theme_bw()



# Next part of lecture

# Intro to publishing plots with cowplot
# Installed cowplot package directly into console
library(cowplot)

# diamonds is just a data set already loaded into R Studio that allows you to just mess around with some data. There's another called mtcars and another called iris
# that's why we won't see diamonds in the environment unless we load it into there
plot.diamonds <- diamonds %>% 
  ggplot(aes(x = clarity, fill = cut)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 70, vjust = 0.5))

plot.cars <- mtcars %>% 
  ggplot(aes(x = wt, y = mpg, color = cyl)) + 
  geom_point(size = 2) +
  theme_minimal() # putting color = cyl makes it all continous

plot.cars <- mtcars %>% 
  ggplot(aes(x = wt, y = mpg, color = factor(cyl))) + # wrapping cyl in factor will make them discrete categories
    geom_point(size = 2) +
      theme_minimal()

plot.cars2 <- mpg %>% 
  ggplot(aes(x = cty, y = hwy, color = factor(manufacturer))) +
  geom_point()

# now using cowplot to stitch them together

plot_grid(plot.cars, plot.diamonds, plot.cars2, labels = c("A", "B", "C"), ncol = 2, nrow = 2)


# plotly for interactive plots
# installed plotly package below in console
library(plotly)

plot.cars %>% 
  ggplotly()
# this makes the points interactive and when you hover your mouse over a point, it shows its data


ggplot(mtcars, mapping = aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm")
# this made a regression line of some example data



