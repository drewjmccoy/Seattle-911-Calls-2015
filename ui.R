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
      selectInput(
        "select_place", label = h3("Popular Locations"),
        choices = list(
          "Seattle" = "Seattle", "The Ave" = "the ave", "Space Needle" = "space needle", "China Town" = "china town"
        ),
        selected = "Seattle"
      ),
      checkboxInput("violent_crimes", label = "Violent Crimes Only", value = TRUE)
    ),
    mainPanel(leafletOutput('calls_map'))
  ),
  # Tab that shows other interactive plots
  tabPanel("Interactive Plots")
))
