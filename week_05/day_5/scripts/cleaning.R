## Load Libraries
library(tidyverse)
library(here)

## Read In Raw Data

games <- CodeClanData::game_sales

## Add Minimum Age Column

games_clean <- games %>% 
  mutate(min_age = case_when(
    rating == "E" ~ 0,
    rating == "E10+" ~ 10,
    rating == "T" ~ 13,
    rating == "M" ~ 17,
  )
)

## Write Clean Data To .csv

write_csv(games_clean, here("app/clean_data/games_clean.csv"))

## Remove Objects from Environment (Clean Data Will Be Read In When the App Is Ran)

rm(games)
rm(games_clean)


