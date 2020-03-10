# Week 9 Homework
# Working with Datetime

# Let’s plot some of the Mauna Loa data we downloaded last class. First, remove the NAs (here designated with -99.9 and -999.9) in rel_humid, temp_C_2m, and windSpeed_m_s. Next, use dplyr to calculate the mean monthly temperature using the temp_C_2m column and the datetime column. (*HINT: Look at the lubridate function called month()). Finally, make a ggplot of the mean monthly temperature.

library (tidyverse)
library(dplyr)

load("data/raw_data/mauna_loa_met_2001_minute.rda")

summary(mloa_2001)
nrow(mloa_2001)



mloa_2001_new <- mloa_2001[mloa_2001$rel_humid != "-99.9", ] 
mloa_2001_new <- mloa_2001_new[mloa_2001_new$rel_humid != "-99", ]
mloa_2001_new <- mloa_2001_new[mloa_2001_new$rel_humid != "-999.9", ]
mloa_2001_new <- mloa_2001_new[mloa_2001_new$temp_C_2m != "-99.9", ]
mloa_2001_new <- mloa_2001_new[mloa_2001_new$temp_C_2m != "-999.9", ]
mloa_2001_new <- mloa_2001_new[mloa_2001_new$windSpeed_m_s != "-99.9", ]
mloa_2001_new <- mloa_2001_new[mloa_2001_new$windSpeed_m_s != "-999.9", ]


summary(mloa_2001_new)
nrow(mloa_2001_new)

# Easier typing
mloa <- mloa_2001_new

# Making Datetime column with all the right specifications
mloa$Datetime <- ymd_hm(paste0(mloa$year, "-", mloa$month, "-", mloa$day, " ", mloa$hour24, ":", mloa$min), tz = "HST")

summary(mloa)


# This doesn't work because it just calculates mean temp across all months but we need to group them first
mloa_exp <- mloa %>% 
  summarize(mean_month_2m = mean(temp_C_2m))

mloa_exp

mloa_new <- mloa %>% 
  group_by(month) %>% 
  summarize(mean_month_2m = mean(temp_C_2m))

summary(mloa_new)

# Now to graph it all
mloa_new %>% 
  ggplot(mapping = aes(x = month, y = mean_month_2m)) +
    geom_point(color = "darkgreen") +
      labs(x = "Month", y = "Average Monthly Temperature (Celsius)") +
        ylim(0, 10) +
         scale_x_continuous(breaks=seq(1:12))
