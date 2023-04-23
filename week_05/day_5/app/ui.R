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
                               label = tags$b("Current Year:"),
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
                                label = "Which Rating Would You Like To Use?",
                                choices = rating_options
                               
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
    
    tabPanel(title = "Instructions",
             tags$br(),
             "Created April 2023 as part of the ",
             tags$a(href = "https://www.codeclan.com", "CodeClan"),
             "Professional Data Analysis course."
             
             
    ),
    
    tabPanel(title = "Info",
             tags$br(),
             "Created April 2023 as part of the ",
             tags$a(href = "https://www.codeclan.com", "CodeClan"),
             "Professional Data Analysis course."
             
             
    ),
  ),
)