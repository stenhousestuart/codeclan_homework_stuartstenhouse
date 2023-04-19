library(shiny)
library(tidyverse)
library(bslib)

scottish_exports <- CodeClanData::scottish_exports

sectors <- scottish_exports %>% 
  distinct(sector) %>% 
  pull()

col_scheme <- c("#b58900", "black", "seagreen", "#cb4b16", "#2aa198", "#839496")

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
                           label = tags$b("Which Sectors Would You Like To View?"),
                           choices = sectors
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
           )
),
)

server <- function(input, output, session) {
  
  output$sector_plot <- renderPlot({
    
    scottish_exports %>%
      filter(sector %in% input$sector_input) %>%
      ggplot(aes(x = year, y = exports, colour = sector)) +
      geom_line(size = 2, alpha = 0.3) +
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