# Homework_Week_7_SidneyWoodruff

library(tidyverse)
gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")

# Goal is to make the final graphs seen on the website https://gge-ucd.github.io/R-DAVIS/assignments.html


# To get there, let's add some intermediate steps.

# To get the population difference between 2002 and 2007 for each country, it would probably be easiest to have a country in each row and a column for 2002 population and a column for 2007 population.
gapminder %>% 
  group_by(pop, year, country, continent) %>% 
    filter(year >= 2002) %>% 
      pivot_wider(names_from = year, values_from = pop) # results in NAs in the other year's populations...


pop_growth <- gapminder %>% 
  select(pop, year, country, continent) %>% 
   filter(year >= 2002) %>% 
    filter(continent != "Oceania") %>% 
      pivot_wider(names_from = year, values_from = pop) %>% 
       rename(pop_2002 = "2002") %>% 
        rename(pop_2007 = "2007") %>% 
         mutate(pop_diff_02to07 = pop_2007 - pop_2002)
pop_growth
colnames(pop_growth)

# Notice the order of countries within each facet. You’ll have to look up how to order them in this way.
library(cowplot)

# Need to separate out graphs into four graphs by continent
# Trying to reorder them from lowest growth to highest growth, using reorder function within aesthetics

# AFRICA
africa_popgrowth <- pop_growth %>% 
  filter(continent == "Africa") %>% 
    ggplot(mapping = aes(x = reorder(country, pop_diff_02to07), y = pop_diff_02to07)) +
        geom_bar(fill = "darkgreen", stat = "identity") +
          theme(axis.text.x = element_text(angle = 50, hjust = 1)) +
            labs(title = "Africa", x = "Country", y = "Change in Population Between 2002 and 2007")
africa_popgrowth

# AMERICAS
americas_popgrowth <- pop_growth %>% 
  filter(continent == "Americas") %>% 
    ggplot(mapping = aes(x = reorder(country, pop_diff_02to07), y = pop_diff_02to07)) +
      geom_bar(fill = "navy", stat = "identity") +
        theme(axis.text.x = element_text(angle = 50, hjust = 1)) +
         labs(title = "Americas", x = "Country", y = "Change in Population Between 2002 and 2007")
americas_popgrowth

# ASIA
asia_popgrowth <- pop_growth %>% 
  filter(continent == "Asia") %>% 
    ggplot(mapping = aes(x = reorder(country, pop_diff_02to07), y = pop_diff_02to07)) +
      geom_bar(fill = "red3", stat = "identity") +
       theme(axis.text.x = element_text(angle = 50, hjust = 1)) +
        labs(title = "Asia", x = "Country", y = "Change in Population Between 2002 and 2007")
asia_popgrowth

# EUROPE
europe_popgrowth <- pop_growth %>% 
  filter(continent == "Europe") %>% 
    ggplot(mapping = aes(x = reorder(country, pop_diff_02to07), y = pop_diff_02to07)) +
      geom_bar(fill = "purple3", stat = "identity") +
       theme(axis.text.x = element_text(angle = 50, hjust = 1)) +
         labs(title = "Europe", x = "Country", y = "Change in Population Between 2002 and 2007")
europe_popgrowth

# Also look at how the axes are different for each facet. Try looking through ?facet_wrap to see if you can figure this one out.
# The color scale is different from the default- feel free to try out other color scales, just don’t use the defaults!
# The theme here is different from the default in a few ways, again, feel free to play around with other non-default themes.
# The axis labels are rotated! Here’s a hint: angle = 45, hjust = 1. It’s up to you (and Google) to figure out where this code goes!
#  Is there a legend on this plot?

plot_grid(africa_popgrowth, americas_popgrowth, asia_popgrowth, europe_popgrowth, ncol = 2, nrow = 2) +
  labs(x = "Country", y = "Change in Population Between 2002 and 2007")
# Has every single axis label there because we are stitching together all of those graphs, not really generating them together



# To start over and use facet_wrap
ggplot(data = pop_growth, mapping = aes(x = reorder(country, pop_diff_02to07), y = pop_diff_02to07)) +
  geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = 50, hjust = 1)) +
  labs(x = "Country", y = "Change in Population Between 2002 and 2007") +
  facet_wrap(~continent) # Without this facet_wrap line, all of the bar graphs across all continents would be together but putting this facet_wrap line with the ~continent separates them by continent since that variable is consistent across all data
# Now to figure out how to configure each axis relative to its own continent and how to color each
# This works better with the scales line because it allows you to put all of the axis labels together and not crowd the space

countrycolor <- c("Africa" = "darkmagenta","Americas" = "navy", "Asia" = "olivedrab4", "Europe" = "darkorange2")

final <- pop_growth %>% 
  ggplot(mapping = aes(x = reorder(country, pop_diff_02to07), y = pop_diff_02to07)) +
  geom_bar(aes(fill = continent), stat = "identity", show.legend = FALSE) +
  facet_wrap(~continent, scales = "free") +
  theme(axis.text.x = element_text(angle = 50, hjust = 1)) +
  labs(x = "Country", y = "Change in Population Between 2002 and 2007") +
  scale_fill_manual(values = countrycolor)

final

# YEET







