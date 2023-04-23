# Global

## Packages Needed for App
library(tidyverse)
library(bslib)
library(plotly)
library(here)

## Read In Clean Data for App

games_clean <- read_csv(here("app/clean_data/games_clean.csv"))

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

rating_options <- c("Critics Rating" = "critic_score",
                    "Users Rating" = "user_score",
                    "Sales" = "sales")

number_options <- c("Top 3" = 3,
                    "Top 5" = 5)