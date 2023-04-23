# Global

## Packages Needed for App
library(tidyverse)
library(bslib)
library(plotly)

## Functions Needed for App

## Clean Data for App
games_clean <- CodeClanData::game_sales %>% 
  mutate(min_age = case_when(
    rating == "E" ~ 0,
    rating == "E10+" ~ 10,
    rating == "T" ~ 13,
    rating == "M" ~ 17,
  )
)

## Variables for App

years <- games_clean %>% 
  distinct(year_of_release) %>% 
  pull()

genres <- games_clean %>% 
  distinct(genre) %>% 
  pull()

consoles <- games_clean %>% 
  distinct(platform) %>% 
  pull()

col_scheme <- c("#ea39b8", "#6610f2", "#32fbe2", "#f1b633", "#e44c55", "#1ba2f6",
                         "#3cf281", "#170229")

rating_options <- c("Critics Rating" = "critic_score",
                    "Users Rating" = "user_score",
                    "Sales" = "sales")