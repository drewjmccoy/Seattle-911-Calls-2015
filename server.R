# Server script
# Import necessary scripts and packages
source('scripts/graph_scripts.r')
source('scripts/data_wrangling_scripts.r')
source('scripts/data_wrangling.r')
source('scripts/crime_types.r')
library(dplyr)
library(shiny)
library(leaflet)
library(ggmap)
library(plotly)
# Read in Data Set
data <- read.csv("data/911Calls.csv")

shinyServer(function(input, output) {
  # Call's map function to render map in Shiny App
  output$calls_map <- renderLeaflet({
    build_map(data,input$violent_crimes)
  })
  # Call's crime_type function to render plot
  output$crime_type_plot <- renderPlotly({
    specific_data(data,input$crime_type) 
  })
  output$general_breakdown1 <- renderPlotly({
    call_breakdown(data,1)
  })
  output$general_breakdown2 <- renderPlotly({
    call_breakdown(data,2)
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

