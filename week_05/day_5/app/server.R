# Server

## Server Logic

server <- function(input, output, session) {
  
  suggestion_plot <- eventReactive(eventExpr = input$submit_input,
                                   valueExpr = {
                                     
                                     games_plot <- games_clean %>%
                                       filter(year_of_release == input$year_input,
                                              genre == input$genre_input,
                                              platform == input$console_input,
                                              min_age <= input$age_input)
                                     
                                     if (input$rating_scale_input == "everything") {
                                       
                                       ggplot(games_plot, aes(x = user_score,
                                                              y = critic_score,
                                                              alpha = sales,
                                                              label = name)) +
                                         geom_point(colour = "#6610f2", size = 5) +
                                         geom_label(nudge_y = 1) +
                                         theme_minimal() +
                                         labs(
                                           x = "User Rating",
                                           y = "Critic Rating",
                                           alpha = "Sales:") +
                                         theme(
                                           axis.text = element_text(size = 12),
                                           axis.title.x = element_text(colour = "grey"),
                                           axis.title.y = element_text(colour = "grey"),
                                           panel.grid = element_line(colour = "grey90", linetype = "dashed")
                                         )
                                       
                                       
                                     }
                                     
                                     else {
                                       
                                        games_plot %>%
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
                                       
                                     }
                                     
                                   })
  
  output$suggestion_plot <- renderPlot({
    
    results_count_check <- games_clean %>%
      filter(year_of_release == input$year_input,
             genre == input$genre_input,
             platform == input$console_input,
             min_age <= input$age_input)

    validate(
      need(nrow(results_count_check) > 0, "Unfortunately No Games Match Your Current Criteria")
    )
      suggestion_plot()  
  })
}
