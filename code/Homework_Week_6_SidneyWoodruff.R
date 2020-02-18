# Week_6_Homework_SidneyWoodruff

library(tidyverse)
gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")

# Problem 1.
# First calculates mean life expectancy on each continent. Then create a plot that shows how life expectancy has changed over time in each continent. Try to do this all in one step using pipes! (aka, try not to create intermediate dataframes)

Prob1 <- gapminder %>% 
  group_by(continent, year) %>% 
    summarize(avg_lifeExp = mean(lifeExp)) %>% 
      ggplot(mapping = aes(x = year, y = avg_lifeExp, color = continent)) +
          geom_line(aes(x = year, y = avg_lifeExp, color = continent)) +
            geom_point()

# Problem 2.
# Look at the following code and answer the following questions. What do you think the scale_x_log10() line of code is achieving? What about the geom_smooth() line of code?

#Code that was given
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

#Removing the scale_x_log10 function, it shows the true distribution of the points and they're all condensed to lower numbers, but there are a few dots spreading far right on the x-axis making everything condense on the left side
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

#Removing the geom_smooth does not add a regression line. What's the geom_smooth function does as well is show the variation in the data along the regression line. The wider the gray area around the line, the more variation there is in the Y axis data associated with that X axis data trend
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  theme_bw()

# Challenge! Modify the above code to size the points in proportion to the population of the country. Hint: Are you translating data to a visual feature of the plot?

challenge <- ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, color = continent, size = pop)) +
  geom_point(data = gapminder, alpha = 0.5) +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  scale_x_log10()

# Problem 3
# Create a boxplot that shows the life expectency for Brazil, China, El Salvador, Niger, and the United States, with the data points in the backgroud using geom_jitter. Label the X and Y axis with “Country” and “Life Expectancy” and title the plot “Life Expectancy of Five Countries”.

gapminder_boxplot <- gapminder %>% 
  filter(country %in% c("Brazil", "China", "El Salvador", "Niger", "United States")) %>% 
  ggplot(mapping = aes(x = country, y = lifeExp)) +
  geom_jitter(alpha = 0.8, aes(color = as.factor(country))) +
  geom_boxplot() +
  ggtitle("Life Expectancy of Five Countries") +
  labs(x = "Country", y = "Life Expectancy") +
  guides(color=guide_legend(title="Country"))

gapminder_boxplot
