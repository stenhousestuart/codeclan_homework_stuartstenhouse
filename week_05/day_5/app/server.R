# Server

## Server Logic

server <- function(input, output, session) {

  suggestion_plot <- eventReactive(eventExpr = input$submit_input,
                                   valueExpr = {
                                     
                                     games_clean %>% 
                                       filter(year_of_release == input$year_input,
                                              genre == input$genre_input,
                                              platform == input$console_input,
                                              min_age <= input$age_input) %>%
                                       ggplot() +
                                       geom_col(aes(x = reorder(name, input$rating_scale_input),
                                                    y = input$rating_scale_input,
                                                    fill = name)) +
                                       theme_minimal() +
                                       scale_fill_manual(values = col_scheme) +
                                       coord_flip() +
                                       labs(
                                         x = "\n Sales",
                                         y = "Game Title \n")
                                   
                                     })
  
  output$suggestion_plot <- renderPlot({
    suggestion_plot()
    
  })
}



