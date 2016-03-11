# UI script
library(shiny)
library(dplyr)
library(leaflet)
library(plotly)
library(ggmap)
shinyUI(navbarPage(
  "Seattle 911 Calls in 2015", id = "nav",
  # Tab that houses the Interactive Map along with sidebar interactivity
  tabPanel(
    "Call Map",
    div(class = "outer"),
    # Sidebar panel that houses the widgets that control the map
    sidebarPanel(
      h1("Map Settings"),
      textInput(
        "location", label = h5("Navigate to Landmark or Address"), value = "ex: Space Needle"
      )
      ,
      checkboxInput("violent_crimes", label = "Violent Crimes Only", value = TRUE)
    ),
    # Create and show text that intoduces map
    mapText <- renderText({
      "Shown below is a map of all the 911 Calls made in the Seattle area during the year 2015. On the sidebar panel you
      have t\he option to show all 911 calls or only 911 calls made about violent crimes. In addition you can enter an Seattle area
      address or landmark to zoom in on that specific area of the map. Simply clear the search bar to reset the view."
    }),
    mapText(),
    # Render map in main panel
    mainPanel(leafletOutput('calls_map'))
    ),
  # Tab that shows call type plots
  tabPanel(
    "Call Type Breakdown",
    # Sidebar panel that holds widget that controls plot
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
      )
    ),
    mainPanel(
      # Create and show text that introduces first call type plot, then render that plot
      topText <- renderText({
        "Below is a breakdown of 911 calls in Seattle by specific subgroup.
        You can use the dropdown on the left to select which type of crime you'd like to investigate:"
      }),
      topText(),
      plotlyOutput('crime_type_plot'),
      # Create and show text that introduces next two plots, then render those plots
      lowerText <- renderText({
        "Below are two charts that together, display the frequencies in which certain crimes were reported, shown by general group:"
      }),
      lowerText(),
      plotlyOutput('general_breakdown1'),
      plotlyOutput('general_breakdown2')
      )
  ),
  # Tab that shows calls over time plots
  tabPanel(
    "Calls Over Time Breakdown",
    # Sidebar panel that holds widget that controls which plot is displayed
    sidebarPanel(
      radioButtons(
        "graph_choice", label = h3("Graph to Display"),
        choices = list(
          "Month Graph" = 1, "Day Graph" = 2, "Hour Graph" = 3
        ),
        selected = 1
      )
    ),
    mainPanel(
      # Create and show text that introduces calls over time plots, then render plot
      headerText <- renderText({
        "Below are three different display options for 911 calls in Seattle in 2015 based on time frames. The first graph
        shows how many calls there were per month, as well as the most common type of incident that caused the call. The
        second graph shows how many calls there were per day, and the third shows the number of calls, on average, in each
        hour of the day in 2015."
      }),
      headerText(),
      plotlyOutput("time_plot")
      
      )
    )
  ))