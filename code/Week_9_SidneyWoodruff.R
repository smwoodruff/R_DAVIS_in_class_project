# Week 9 of R-DAVIS

# Working with date times in R using 'lubridate' package

# Let's download the NYC_2015_solinst.csv together from the R-DAVIS website

# load packages

library (tidyverse)
library(lubridate)

nfy1 <- read_csv("data/raw_data/2015_NFY_solinst.csv", skip = 12)

# Remember, R likes YYYY MM DD
sample_dates <- c("07-15-2019", "12-24-2018", "03-07-2013", "04-04-2019")
# Because it wasn't in that format, R read it as characters

sample_dates <- as.Date(sample_dates, format = "%m-%d-%Y")

dt <- c("07-15-2019 14:32", "12-24-2018 12:40:01")

dt <- as.POSIXct(dt, format = "%m-%d-%Y %H:%M:%S")
# It worked but because the first date and time didn't have seconds, it put NA for that entry.

dt <- c("07-15-2019 14:32:09", "12-24-2018 12:40:01")
# Have to also specify time zone since it came up as different zones because of daylight savings
dt <- as.POSIXct(dt, format = "%m-%d-%Y %H:%M:%S", tz = "GMT")
dt


# Lubridate!
sample_dates <- c("07-15-2019", "12-24-2018", "03-07-2013", "04-04-2019")
# To reuse this value, it's as character data

dates_lub <- mdy(sample_dates)
dates_lub
# Any kind of funky format, lubridate will fix it

sample_dates2 <- c("5A06A17 14:22", "8A17A13 06:33")
sample_dates2
sample_dates2_lub <- mdy_hm(sample_dates2, tz = "GMT")
sample_dates2_lub


head(nfy1)
# To force tidyverse to read this data in as the way we want it to be read
nfy1 <- read_csv("data/raw_data/2015_NFY_solinst.csv", skip = 12)
head(nfy1)
# Now we can see that the date and time have been entered as characters.
# We might want to specify it because your formatting in the raw data may not be the same format that R wants it as. It would then generate the tables and make the date column class as <date> and the time column as <time>. Which sounds good but the format isn't perfect for us. If we bring them in as characters, we can then specify the way we want R to read the stuff and data isn't loss.

nfy1 <- read_csv("data/raw_data/2015_NFY_solinst.csv", skip = 12, col_types = "ccidd")
head(nfy1)



# The paste function brings two things together and we have to specify how they are separated
nfy1$Datetime <- paste(nfy1$Date, nfy1$Time, sep = " ")
head(nfy1)
# Now there's a column named Datetime with the date and time stuff together separated by a space and it's a character class

# Before we mess with the column, we'll work in a second column so we don't overwrite our new column
nfy1$Datetime2 <- ymd_hms(nfy1$Datetime, tz = "GMT")
head(nfy1)


# We can see what time zones our Datetime column is in
tz(nfy1$Datetime)
tz(nfy1$Datetime2)






# Working with a new dataset
# Download the Mauna Loa Observatory dataset
load("data/raw_data/mauna_loa_met_2001_minute.rda")
summary(mloa_2001)
names(mloa_2001)

# Let's put all of those date and time columns together using the paste function
# paste0 just doesn't put a space inbetween stuff
mloa_2001$Datetime <- paste0(mloa_2001$year, "-", mloa_2001$month, "-", mloa_2001$day, " ", mloa_2001$hour24, ":", mloa_2001$min)
summary(mloa_2001)
# It's still as character

# Tell R this is a datetime column
mloa_2001$Datetime <- ymd_hm(mloa_2001$Datetime, tz = "HST")
tz(mloa_2001$Datetime)





# Using RMarkdown
# Allows you to create a wide array of documents (pdf, slides, html, docx, etc) from a plain text file that has code in it
# It's already built into RStudio


# The top part is the "metadata" known as the yaml, don't mess the format and try not to mess with it at all



















