# Server script
setwd("/Users/colecansler/Desktop/498F/Seattle-911-Calls-2015")
source('Scripts/InteractiveMap.R')
source('Scripts/DataWranglingScript.R')
library(dplyr)
library(shiny)
library(leaflet)

shinyServer(function(input, output) {
  reactive({
    data <- read.csv("Data/911Calls.csv")
    data <- sort_by_date(data)
  })
  output$calls_map <- renderLeaflet({
    build_map(data,input$slider_range[1],(input$slider_range[2] + 1))})

  })

