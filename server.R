# Server script
# Import necessary scripts and packages
library(dplyr)
library(shiny)
library(leaflet)
library(ggmap)
library(plotly)
source('scripts/graph_scripts.r')
source('scripts/data_wrangling_scripts.r')
source('scripts/data_wrangling.r')

shinyServer(function(input, output) {
  # Call's map function to render map in Shiny App
  output$calls_map <- renderLeaflet({
    build_map(data, input$violent_crimes)
  })
  
  # Call's crime_type function to render plot
  output$crime_type_plot <- renderPlotly({
    specific_breakdown_graph(specific_breakdown_graph_data,input$crime_type) 
  })
  
  # Call's call_breakdown function to render plot
  output$general_breakdown1 <- renderPlotly({
    call_breakdown_graph(call_breakdown_graph_data, 1)
  })
  
  # Call's  call_breakdown funciton to render plot
  output$general_breakdown2 <- renderPlotly({
    call_breakdown_graph(call_breakdown_graph_data, 1)
  }) 
  
  # Call's month_graph function to render plot
  output$time_plot <- renderPlotly({
    graph_to_display(input$graph_choice)
  })
  
  # Observe function that updates what part of the map is viewed
  observe({
    input$violent_crimes
    latitude <- lat_and_lng(input$location)[2]
    longitude <- lat_and_lng(input$location)[1]
    zoom_level <- 17
    if (is.na(latitude) | is.na(longitude)) {
      latitude <- 47.606209
      longitude <- -122.332071
      zoom_level <- 10
    }
    leafletProxy("calls_map") %>%
      setView(lng = longitude, lat = latitude, zoom = zoom_level)
  })
  
})

