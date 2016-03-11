# UI script
library(shiny)
library(dplyr)
library(leaflet)
library(plotly)
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
    mapText <- renderText({
      "Shown below is a map of all the 911 Calls made in the Seattle area during the year 2015. On the sidebar panel you
      have the option to show all 911 calls or only 911 calls made about violent crimes. In addition you can enter an Seattle area
      address or landmark to zoom in on that specific area of the map. Simply clear the search bar to reset the view." 
    }),
    mapText(),
    mainPanel(leafletOutput('calls_map'))
  ),
  # Tab that shows other interactive plots
  tabPanel(
    "Call Type Breakdown",
    sidebarPanel(selectInput(
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
        "Traffic Related Calls" = "TRAFFIC RELATED CALLS"),
      selected = "ASSAULTS"
      
      
      
    )),
    mainPanel(
      topText <- renderText({
        "Below is a breakdown of 911 calls in Seattle by specific subgroup.
        You can use the dropdown on the left to select which type of crime you'd like to investigate:" 
      }),
      topText(),
      plotlyOutput('crime_type_plot'),
      lowerText <- renderText({
        "Below are two charts that together, display the frequencies in which certain crimes were reported, shown by general group:"
      }),
      lowerText(),
      plotlyOutput('general_breakdown1'),
      plotlyOutput('general_breakdown2'))
  ),
  tabPanel(
    "Call's Over Time Breakdown",
    sidebarPanel(
      radioButtons("graph_choice", label = h3("Graph to Display"),
                   choices = list("Month Graph" = 1, "Day Graph" = 2, "Hour Graph" = 3), 
                   selected = 1)
    ),
    mainPanel(
      plotlyOutput("time_plot")

    )
  )
))