# UI script
library(shiny)
library(dplyr)
library(leaflet)
shinyUI(navbarPage(
  "Seattle 911 Calls", id = "nav",
  # Tab that displays the map
  tabPanel(
    "Interactive map",
    div(class = "outer"),
    
    titlePanel("Map Settings"),
    
    sidebarPanel(
      textInput("location", label = h3("Navigate to Landmark or Address"), value = "ex: Space Needle")
      ,
      checkboxInput("violent_crimes", label = "Violent Crimes Only", value = TRUE)
    ),
    mainPanel(leafletOutput('calls_map'))
  ),
  # Tab that shows other interactive plots
  tabPanel("Interactive Plots")
))
