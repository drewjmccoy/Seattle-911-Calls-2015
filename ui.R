# UI script
library(shiny)
library(dplyr)
library(leaflet)
shinyUI(navbarPage(
  "Seattle 911 Calls", id = "nav",
  # Tab that houses the Interactive Map along with sidebar interactivity
  tabPanel(
    "Interactive map",
    div(class = "outer"),
    
  
    
    sidebarPanel(h1("Map Settings"),
      textInput("location", label = h5("Navigate to Landmark or Address"), value = "ex: Space Needle")
      ,
      checkboxInput("violent_crimes", label = "Violent Crimes Only", value = TRUE)
    ),
    # Render map in main panel
    mainPanel(leafletOutput('calls_map'))
  ),
  # Tab that shows other interactive plots
  tabPanel("Interactive Plots")
))
