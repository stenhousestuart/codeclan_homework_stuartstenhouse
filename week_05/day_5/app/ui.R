# UI

## Input and Output for UI

ui <- fluidPage(
  theme = bs_theme(bootswatch = "vapor"),
  titlePanel("Game Recommendations"),
  tabsetPanel(
    tabPanel(title = "App",
             fluidRow(
               sidebarLayout(
                 sidebarPanel(
                   
                   # Year Input / Slider
                   sliderInput(inputId = "year_input",
                               label = tags$b("Year of Release:"),
                               min = 1996, 
                               max = 2016, 
                               value = 2016,
                               step = 1,
                               sep = "",
                               ticks = FALSE
                   ),
                   
                   # Genre Input / Dropdown
                   selectInput(inputId = "genre_input",
                               label = tags$b("What Is Your Favourite Game Genre?"),
                               choices = genres
                   ),
                   
                   # Console Input / Dropdown
                   selectInput(inputId = "console_input",
                               label = "Which Console Do You Have?",
                               choices = consoles
                               
                   ),
                   
                   # Age Rating Input / Radio Button
                   sliderInput(inputId = "age_input",
                               label = tags$b("Your Age:"),
                               min = 0, 
                               max = 116, 
                               value = 16,
                               step = 1,
                               sep = "",
                               ticks = FALSE
                               
                   ),
                   
                   # Rating Scale Input / Radio Button
                   radioButtons(inputId = "rating_scale_input",
                                label = "Which Ranking Would You Like To Use?",
                                choices = rating_options
                                
                   ),
                   
                   # Do Not Display 'Number of Results Input' if 'Everything"
                   # rating option is selected.
                   conditionalPanel(
                     condition = "input.rating_scale_input != 'everything'",
                     
                     # Number of Results Input / Radio Button
                     radioButtons(inputId = "number_input",
                                  label = "View:",
                                  choices = number_options
                                  
                     ),
                   ),
                   
                   # Submit / Update Button
                   actionButton(inputId = "submit_input",
                                label = "Submit / Update"),
                   
                 ),
                 
                 mainPanel(
                   # Plot Output 
                   
                   plotOutput("suggestion_plot")
                   
                 ),
               ),
             ),
    ), 
    
    tabPanel(title = "Instructions / Details",
             tags$br(),
             p("The purpose of this app and the chosen visualisations are to 
               help people receive personalised game recommendations, from the 
               'game_sales' data set."),
             
             tags$hr(),
             
             p(tags$b("Game Criteria:"),
               "Users can set the following game criteria:",
               tags$ol(
                 tags$li("Year of Release"), 
                 tags$li("Game Genre"), 
                 tags$li("Platform/Console"),
                 tags$li("Age")),
               
               p("Based on the Entertainment Software Rating Board rating for 
               the game, only games appropriate for users specified age will be 
               returned."),
               
               tags$ol(
                 tags$li("Users with an age under 10 will receive E rated games only."), 
                 tags$li(" Users with an aged 10 or over but under the age of 13 will receive 
            E rated AND E10+ rated games only."), 
            tags$li("Users with an age of 13 or over but under the age of 17 will 
            receive E rated, E10+ rated AND T rated games only."),
            tags$li("  Users with an age of 17 or over will receive all games from 
            the dataset.")),
            
            p(tags$em("Note that only games with E, E10+, T and M ratings are included.")),
            
            tags$hr(),
            
            p(tags$b("Ranking / Visualisation Criteria:")),
              p("Users can personalise which ranking system they'd like to use, 
                based on what matters most them. This will determine the nature
                of the visualisation returned"),
              
              tags$ol(
                tags$li("Critic Ratings: A bar plot of games, based on their criteria and 
            ranked on Critic Ratings."), 
            tags$li("User Ratings: A bar plot of games, based on their criteria and 
            ranked on User Ratings."), 
            tags$li("Sales: A bar plot of games, based on their criteria and ranked 
            on sales figures."),
            tags$li("Everything: A scatter plot of games, plotted on Critic Ratings 
            and User Ratings, with Sales reflected in plot opacity.")),
            
            p(tags$b("Number of Results Returned:")),
            "If a user selects a ranking option other than 'Everything' they can choose 
    for a maximum of 3 or 5 results to be returned. These will be the top 3 or 
    5 games based on their chosen ranking system. If a user selects 'Everything' 
    as the ranking option, this does not apply and all eligible games will be 
    returned and plotted."
    
        ),
      ),
    ),
  )