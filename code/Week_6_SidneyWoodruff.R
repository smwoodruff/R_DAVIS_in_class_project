#Week 6 of R-Davis

#Starting with ggplot

library(tidyverse)
surveys_complete <- read_csv("data/raw_data/portal_data_joined.csv") %>% 
  filter(complete.cases(.))

#the period is the code telling the function to look here
#we just filtered out the rows that had an NA anywhere in its row

surveys_complete

#ggplot

#ggplot likes pivot_longer, structuring your data right is important for ggplot
#we want every row as a single observation that's why it's important to have the table longggg
#ggplot(data = DATA, mapping = aes(MAPPINGS)) + geom_function()

#take it one step at a time
ggplot(data = surveys_complete)

#let's do coordinates system like x and y plot
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length))

#last step is to add the geom_function, which is telling R how we want to express that data relationship
#after mapping and you press +, press enter to get into a new line and you can add as much as you want because you have the base down
#geom_ and press tab and you can see all of the potential geom functions you can use
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) + 
  geom_point()


#assigning part of a plot to an object

surveys_plot <- ggplot(data = surveys_complete,
                       mapping = aes(x = weight,
                                     y = hindfoot_length))
surveys_plot

#now that we have the base, we can add onto it without having to type all of the base every time
surveys_plot + geom_point()

ggplot() + 
  geom_point(data = surveys_complete,
             mapping = aes(x = weight,
                           y = hindfoot_length))
#anything inside ggplot is universal
#on the flip side, you can specify what data you want to be presented in that way



#modify a specific geom by itself
ggplot(data = surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1)
#for every point, change its alpha value to 0.1
#each point was given that same density value but this shows how dense/common some occurences are



#Let's do some color
ggplot(data = surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, color = "plum4")
#To find colors, just google ggplot colors and get the code for the color you want

#Let's say you want each species to be colored different
ggplot(data = surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.1, aes(color = species_id))

#this would be a good graph for comparing turtle weight and growth by site ID and you could also circle which ones are in wildfire areas or not, or also different levels of bullfrog presence



#can also include color within the ggplot call
ggplot(data = surveys_complete,
       mapping = aes(x = weight, y = hindfoot_length, color = species_id)) + 
  geom_point(alpha = 0.1)


#CHALLENGE
#Use what you just learned to create a scatter plot of weight and species_id with weight on the Y-axis, and species_id on the X-axis. Have the colors be coded by plot_type. Is this a good way to show this type of data? What might be a better graph?


#let's make a boxplot of weight on x-axis and spexies on the x axis

surveys_complete %>% 
  ggplot(mapping = aes(x = species_id,
                       y = weight)) +
  geom_boxplot() +
  geom_jitter(alpha = 0.3, color = "tomato")

#you can put the box plot in front of the points

surveys_complete %>% 
  ggplot(mapping = aes(x = species_id,
                       y = weight)) +
  geom_jitter(alpha = 0.3, color = "tomato") +
  geom_boxplot() 
#that's why order is important, think of it as painting on a canvas and order would be important to how you want the data to be viewed

#Challenges
#  Boxplots are useful summaries, but hide the shape of the distribution. For example, if the distribution is bimodal, we would not see it in a boxplot. An alternative to the boxplot is the violin plot, where the shape (of the density of points) is drawn.
#  Replace the box plot with a violin plot; see geom_violin().
#  In many types of data, it is important to consider the scale of the observations. For example, it may be worth changing the scale of the axis to better distribute the observations in the space of the plot. Changing the scale of the axes is done similarly to adding/modifying other components (i.e., by incrementally adding commands). Try making these modifications:
#  Represent weight on the log10 scale; see scale_y_log10().
#  Make a new plot to explore the distrubtion of hindfoot_length just for species NL and PF. Overlay a jitter plot of the hindfoot lengths of each species by a boxplot. Then, color the datapoints according to the plot from which the sample was taken.
#  Hint: Check the class for plot_id. Consider changing the class of plot_id from integer to factor. Why does this change how R makes the graph?


surveys_complete %>% 
  ggplot(mapping = aes(x = species_id,y = weight)) +
  geom_jitter(alpha = 0.3, color = "darkolivegreen") +
  geom_violin() +
  scale_y_log10()

#make a plot with just NL and PF, distributions of hindfoot_length

surveys_complete %>% 
  filter(species_id == "NL" | species_id == "PF") %>% 
  ggplot(mapping = aes(x = species_id, y = hindfoot_length)) +
  geom_jitter(aes(color = plot_id))
#R thinks that the numbers of the plot ids are some sort of gradient when they actually are individual and not related

surveys_complete %>% 
  filter(species_id == "NL" | species_id == "PF") %>% 
  ggplot(mapping = aes(x = species_id, y = hindfoot_length)) +
  geom_jitter(alpha = 0.5, aes(color = as.factor(plot_id))) +
  geom_boxplot(fill = NA)
  












