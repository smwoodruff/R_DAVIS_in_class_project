# Week 8 in R-DAVIS

library(tidyverse)

species.dot <- read.csv("data/raw_data/species.csv")
species.dot
str(species.dot)
# It read them all in as factors
# Any character data was read in as a factor


species_underscore <- read_csv("data/raw_data/species.csv")
species_underscore


surveys.dot2 <- read.csv("data/raw_data/species.csv", stringsAsFactors = FALSE)
str(surveys.dot2)
# Now they are all formatted as characters


# Advanced challenge
# Suppose you get a .csv file from a colleague in Europe. Because they use , (comma) as a decimal separator, they use ; (semi-colons) to separate fields.
# - How can you read it into R? Feel free to use the web and/or R’s helpfiles.

read.csv("data/raw_data/species.csv", sep = ";", dec = ",")
read.csv2("data/raw_data/species.csv")




read_csv("data/raw_data/wide_eg.csv")
# What is common is that people will put infomation in the cells above the table saying what the columns mean or represent. When you read the table in though, it includes those cells when really the table we want starts at the third line
read_csv("data/raw_data/wide_eg.csv", skip = 2) # Telling R to skip two lines

read_csv("https://mikoontz.github.io/data-carpentry-week/data/wide_eg.csv", skip = 2) # You can also put in a URL directly if you don't want to download the data yourself to your computer


# Exporting a csv file

write_csv(x = species.dot, # The data you want to export
          path = "data/cleaned_data/species_dot_written.csv") # Where you want to put it with the name of its file when you export it)


# .rda and .rds files
# rda can store multiple objects in it (ex, 3 data frames, a model output, and everything)
save(species.dot, species_underscore, # The two data frames we want
     file = "data/cleaned_data/species_dataframes.rda") # Have to give it the file path name and what you name it as


load(file = "data/cleaned_data/species_dataframes.rda") # Load them in, names and all. Bring them into my environment. Not assigning them but they will be read in and assigned because the rda file had objects in it

# The only functions for rda are save() and load()

# .rds only has one object in it and it won't assign it like a csv file won't assign it for you
# The only functions you'll use with them is saveRDS and readRDS

saveRDS(species_underscore, file = "data/cleaned_data/species_underscore.rds")

readRDS(file = "data/cleaned_data/species_underscore.rds") # Reads it but doesn't assign it
new_species_underscore <- readRDS(file = "data/cleaned_data/species_underscore.rds") # Now you've assigned it as an object




# How to save plots
surveys <- read_csv("data/raw_data/portal_data_joined.csv")

surveys %>% 
  ggplot(aes(x = year, y = hindfoot_length, color = genus)) +
  geom_jitter()

ggsave(filename = "figures/surveys_hindfoot_year_species.jpg", # What you're saving it as
       width = 6, # Defaults to inches
       height = 6)
# It automatically saves the "default" figure which would be your most recent. If you wanted to go back and save another, after the height line, we would do plot = and then say the name of the object
# Can fix things and rerun it and then it will save over that same spot
# Can also do png file extension or tiff or jpeg or jpg or lots of things
# Can look in the ?ggsave help file


# Some cool packages
   # readxl::
   # googlesheets4::     installed the package in the console - install.packages("googlesheets4")
   # foreign::    



# Datetimes in R

# Date is a data format that R recognizes
# Three basic times classes in R:
  # 1. Date: just for dates (2/25/2020)
  # 2. Datetime: POSIXct best for dates with time, calendar time
  # 3. POSIXlt, local time


#lubridate takes a bunch of messy data and puts it into this datetime format

# PRO TIP!
# When you enter your data into Excel, enter it in separate columns for year, month, day, and time (maybe even hours and minutes)


sample_dates1 <- c("2018-02-01", "2018-3-21", "2020-02-25", "2019-04-04")
# R read them in as characters because of the symbols in it even though there are numbers

sample_dates1 <- as.Date(sample_dates1)
# The only reason that worked really nicely is because of the format we entered it in
# YYYY MM DD

# Now with data in NOT that format
sample_dates_2 <- c("02-25-2020", "04-04-1988", "10-05-2019", "06-01-2020") # With month first
sample_dates_2 <- as.Date(sample_dates_2)
# You get an error

sample_dates_2 <- as.Date(sample_dates_2, format = "%m-%d-%Y") # This is us telling R how the dates are formatted
# Look up the cheat sheet for strip time functions


july <- c("July 04, 2019", "July 08, 2019", "July 17, 2019")
july <- as.Date(july, format = "%b %d, %Y")
july
# The uppercase and lowercase b for month worked both so not sure



time <- c("2016-07-24 22:55:01", "2013-04-12 18:50:11")
# Nice format, YYYY MM DD, HH:MM:SS
# This is what R is looking for when looking at date and time data

time <- as.POSIXct(time)
time

# The time zone is added for immediately whatever time zone you're in
# If you collected the data in another time zone, then the as.POSIXct has a function tz in it
time <- c("2016-07-24 22:55:01", "2013-04-12 18:50:11")
time <- as.POSIXct(time, tz = "GMT")
time










