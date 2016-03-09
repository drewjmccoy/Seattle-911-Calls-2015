# UI script
source('Scripts/InteractiveMap.R')
source('Scripts/DataWranglingScript.R')
source('Scripts/Crime_Types.R')
library(shiny)
library(plotly)
library(dplyr)
library(leaflet)
library(ggmap)

shinyUI(navbarPage(
  "Seattle 911 Calls", id = "nav",
  # Tab that houses the Interactive Map along with sidebar interactivity
  tabPanel(
    "Interactive map",
    div(class = "outer"),
    
    sidebarPanel(
      h1("Map Settings"),
      textInput(
        "location", label = h5("Navigate to Landmark or Address"), value = "ex: Space Needle"
      )
      ,
      checkboxInput("violent_crimes", label = "Violent Crimes Only", value = TRUE)
    ),
    # Render map in main panel
    mainPanel(leafletOutput('calls_map'))
  ),
  # Tab that shows other interactive plots
  tabPanel("Interactive Plots",
           sidebarPanel(
             selectInput(
               "crime_type", label = h4("Choose Type of Crime"),
               choices = list(
                 "Assaults" = "ASSAULTS",
                 "Auto Thefts" = "AUTO THEFTS",
                 "Burglary" = "BURGLARY",
                 "Car Prowl" = "CAR PROWL",
                 "Disturbances" = "DISTURBANCES",
                 "Liquor Violations" = "LIQUOR VIOLATIONS",
                 "Narcotics Complaints" = "NARCOTICS COMPLAINTS",
                 "Lost, Found, and Missing Persons" = "PERSONS - LOST, FOUND, MISSING",
                 "Missing and Found Property" = "PROPERTY - MISSING, FOUND",
                 "Traffic Related Calls" = "TRAFFIC RELATED CALLS"
               ),
               selected = "ASSAULTS"
             )),
             mainPanel(
               topText(),
               plotlyOutput('general_breakdown'),
               lowerText(),
               plotlyOutput('crime_type_plot')
             )
           ))
)
