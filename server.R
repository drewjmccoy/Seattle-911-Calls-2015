# Server script
source('Scripts/InteractiveMap.R')
source('Scripts/DataWranglingScript.R')
library(dplyr)
library(shiny)
library(leaflet)
library(ggmap)
data <- read.csv("Data/911Calls.csv")
data <- sort_by_date(data)
shinyServer(function(input, output) {
  output$calls_map <- renderLeaflet({
    build_map(data,input$violent_crimes)
  })
  observe({
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
