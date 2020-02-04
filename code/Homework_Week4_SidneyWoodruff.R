survey <- read.csv("data/raw_data/portal_data_joined.csv")

#Problem 1
colnames(survey)
#We want species_id, weight, and plot_type and only the first 60 rows
survey[1:60, c(6, 9, 13)]
surveys_base <- survey[1:60, c(6, 9, 13)]

str(surveys_base)
#We want species_id and plot_type as characters

surveys_base$species_id <- as.character(surveys_base$species_id)
surveys_base$plot_type <- as.character(surveys_base$plot_type)

#Now we want to remove all rows with weights that are NAs
surveys_base <- surveys_base[complete.cases(surveys_base), ]

#Challenge
#Weights greater than 150g

surveys_base[which(surveys_base[ , 2] >150), ]
challenge_base <- surveys_base[which(surveys_base[ , 2] >150), ]


#Problem 2 with TidyVerse
library(tidyverse)

surveys2 <- read_csv("data/raw_data/portal_data_joined.csv")

#We want species_id, hindfoot_length, and the year columns.
str(surveys2)

surveys_tidy <- surveys2 %>% 
  select(species_id, hindfoot_length, year) %>% 
    filter(!is.na(hindfoot_length))

#Selecting the last 100 rows
surveys_tidy[c(31339:31438), ]
surveys_tidy <- surveys_tidy[c(31339:31438), ]


#We want another data frame with only species RM from the year 1997
surveys_tidy %>% 
  filter(species_id == "RM") %>% 
    filter(year == 1997)
challenge_tidy <- surveys_tidy %>% 
  filter(species_id == "RM") %>% 
    filter(year == 1997)
