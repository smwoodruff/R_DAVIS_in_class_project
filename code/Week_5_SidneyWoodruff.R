#Week 5 of R-DAVIS

#Mutate function

surveys <- read_csv("data/raw_data/portal_data_joined.csv")

#Making  new columns based off of columns already in your data frame
#For new columns, the column names need to be without spaces and they can't start with numbers

surveys_mut <- surveys %>% 
  mutate(weight_kg  = weight/1000)

#Let's say we need the weight for some reason we needed the new weight column to also be mutated - they need to be in the right order, aka a new column can't be built off of a column that hasn't been made yet
surveys_mut <- surveys %>% 
  mutate(weight_kg  = weight/1000, weight_kg2 = weight_kg*2)


#This will now filter out the NAs first and then make a new column with dividing the original weight
surveys_mut2 <- surveys %>% 
  filter(!is.na(weight)) %>% 
    filter(species_id != "NL") %>% 
      mutate(weight_kg = weight / 1000)


#This is a way of checking what is all in that column
unique(surveys_mut2$species_id)


#Challenge
#Create a new data frame from the surveys data that meets the following criteria: contains only the species_id column and a new column called hindfoot_half containing values that are half the hindfoot_length values. In this hindfoot_half column, there are no NAs and all values are less than 30. Name this data frame surveys_hindfoot_half.


surveys_hindfoot_half <- surveys %>% 
  mutate(hindfoot_half = hindfoot_length / 2) %>% 
    filter(!is.na(hindfoot_half)) %>% 
      filter(hindfoot_half < 30) %>% 
        select(species_id, hindfoot_half)
      

#Split, apply, combine
#Using two different functions, group_by, and summarize

#Without the na.rm section, R can't calculate the means because there are NAs in there
surveys_group <- surveys %>% 
  group_by(sex) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE))


surveys %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE), min_weight = min(weight, na.rm = TRUE))


#What's the difference between summarize and mutate?
sum_surveys <- surveys %>% 
  group_by(sex, species_id) %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE)) #makes a data frame that is just 92 observations and 3 variables


mut_surveys <- surveys %>% 
  group_by(sex, species_id) %>% 
  mutate(mean_weight = mean(weight, na.rm = TRUE))  #this adds a whole new column onto our surveys data frame



#you can summarize on multiple things
surveys %>% 
  filter(!is.na(weight)) %>% 
    group_by(sex, species_id) %>% 
      summarize(min_weight = min(weight), 
                max_weight = max(weight))
ungroup() #didn't run but can ungroup stuff?
    
#joins
tail <- read_csv("data/raw_data/tail_length.csv")
tail

#The thing that you're joining on, you want to make sure they're the same thing
summary(surveys$record_id)
summary(tail$record_id)
#The values match themselves

#Basic structure of a join
#join_function(first_data, second_data, by = column_to_join_by)
#The columns need to be named the exact thing, even going with capitlizations and everything, they need to be the exact same

surveys_joined <- left_join(surveys, tail, by = "record_id")

NL_data <- surveys %>% 
  filter(species_id == "NL")
NL_data


NL_data_tail <- left_join(NL_data, tail, by = "record_id")

#joining by multiple columns
#you need a unique identifier between things

#join_function(first_data, second_data, by = c("year", "month", "day")


#pivoting with tidyr

surveys_mz <- surveys %>% 
  filter(!is.na(weight)) %>% 
    group_by(genus, plot_id) %>% 
      summarize(mean_weight = mean(weight))
surveys_mz

#goal here is to have a column for every genus - making it wide

unique(surveys_mz$genus)
n_distinct(surveys_mz$genus)
n_distinct(surveys_mz$plot_id)
#We should end up with 24 rows, one for each plot Id and then 11  columns - 1 for the plot id name and the rest are the genus

wide_survey <- surveys_mz  %>% 
  pivot_wider(names_from = "genus", values_from = "mean_weight")


#pivot_longer
#pivoting from wide to a longer format
wide_survey

long_survey <- wide_survey %>% 
  pivot_longer(cols = -plot_id, names_to = "genus", values_to = "mean_weight")
surveys_mz
#These two are different (even though they are essentially the same thing) because when we made the surveys_mz wide, it filled in NAs










