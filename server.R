# Server script
# Import necessary scripts and packages
source('Scripts/InteractiveMap.R')
source('Scripts/DataWranglingScript.R')
source('Scripts/Crime_Types.R')
library(shiny)
library(plotly)
library(dplyr)
library(leaflet)
library(ggmap)
# Read in Data Set
data <- read.csv("Data/911Calls.csv")

shinyServer(function(input, output) {
  # Call's map function to render map in Shiny App
  output$calls_map <- renderLeaflet({
    build_map(data,input$violent_crimes)
  })
  # Call's crime_type function to render plot
  output$crime_type_plot <- renderPlotly({
    specific_data(data,input$crime_type) 
  })
  output$general_breakdown <- renderPlotly({
    call_breakdown(data)
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
