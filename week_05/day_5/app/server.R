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
                                       slice_max(.data[[input$rating_scale_input]], 
                                                 n = as.numeric(input$number_input)) %>% 
                                       ggplot() +
                                       geom_col(aes(x = reorder(name, .data[[input$rating_scale_input]]),
                                                    y = .data[[input$rating_scale_input]]),
                                                fill = "#ea39b8",
                                                colour = "#6610f2",
                                                alpha = 0.5) +
                                       theme_minimal() +
                                       labs(
                                         x = "Game Title",
                                         y = "Sales / Critic Rating / User Rating") +
                                       theme(
                                         axis.text = element_text(size = 12),
                                         axis.title.x = element_text(colour = "grey"),
                                         axis.title.y = element_text(colour = "grey"),
                                         panel.grid = element_line(colour = "grey90", linetype = "dashed")
                                       ) +
                                       coord_flip()
                                   
                                     })
  
  output$suggestion_plot <- renderPlot({
    suggestion_plot()
    
  })
}



