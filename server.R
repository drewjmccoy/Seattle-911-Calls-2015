# Server script
source('Scripts/InteractiveMap.R')
source('Scripts/DataWranglingScript.R')
library(dplyr)
library(shiny)
library(leaflet)
data <- read.csv("Data/911Calls.csv")
data <- sort_by_date(data)
shinyServer(function(input, output) {
  output$calls_map <- renderLeaflet({
    build_map(data,input$month_range[1],(input$month_range[2] + 1),input$select_place)})
  })

