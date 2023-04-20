library(shiny)
library(tidyverse)
library(bslib)

scottish_exports <- CodeClanData::scottish_exports

sectors <- scottish_exports %>% 
  distinct(sector) %>% 
  pull()

col_scheme <- c("#b58900", "black", "seagreen", "#cb4b16", "steelblue1", "#839496")

ui <- fluidPage(
  theme = bs_theme(bootswatch = "solar"),
  titlePanel(tags$b("Compare Scottish Exports by Sector: 2012-2017")),
  tabsetPanel(
    tabPanel(title = "Data",
             tags$br(),
             fluidRow(
               sidebarLayout(
                 sidebarPanel(
                   checkboxGroupInput(inputId = "sector_input",
                                      label = tags$b("Choose Sector(s):"),
                                      choices = sectors,
                                      selected = sectors
                   ),
                   helpText(tags$i("NB: Please select a minimum of one sector.")),
                   tags$hr(),
                   sliderInput(inputId = "first_year_input",
                               label = tags$b("Start Year:"),
                               min = 2002, 
                               max = 2016, 
                               value = 2002,
                               step = 1,
                               sep = "",
                               width = "100%",
                               ticks = FALSE
                   ),
                   sliderInput(inputId = "last_year_input",
                               label = tags$b("End Year:"),
                               min = 2003, 
                               max = 2017,
                               value = 2017,
                               step = 1,
                               sep = "",
                               width = "100%",
                               ticks = FALSE
                   ),
                 ),
                 mainPanel(
                   
                   plotOutput("sector_plot")
                   
                 ),
               ),
             ),
    ),
    tabPanel(title = "Details",
             tags$br(),
             "Created on 19/04/2023 as part of Codeclan Professional Data Analysis Course."
    ),
  ),
)
server <- function(input, output, session) {
  
  output$sector_plot <- renderPlot({
    
    scottish_exports %>%
      filter(sector %in% input$sector_input) %>%
      filter(year >= input$first_year_input & year <= input$last_year_input) %>% 
      ggplot(aes(x = year, y = exports, colour = sector)) +
      geom_line(size = 2, alpha = 0.5) +
      geom_point(shape = 8) +
      theme_minimal() +
      scale_colour_manual(values = col_scheme) +
      labs(
        x = "\nYear",
        y = "Exports\n",
        colour = "Sector:"
      )
  })
  
  
}

shinyApp(ui, server)