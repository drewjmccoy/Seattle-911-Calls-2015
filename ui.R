# UI script
library(shiny)
library(leaflet)
shinyUI(navbarPage(
  "Seattle 911 Calls", id = "nav",
  # Tab that displays the map
  tabPanel(
    "Interactive map",
    div(class = "outer"),
    
    titlePanel("Map Settings"),
    
    sidebarPanel(
      sliderInput(
        "month_range", label = h3("Month Range"), min = 1,
        max = 12, value = c(1, 12)
      ),
      selectInput("select_place", label = h3("Popular Locations"), 
                  choices = list("Seattle" = "Seattle", "The Ave" = "the ave", "Space Needle" = "space needle", "China Town" = "china town"), 
                  selected = "Seattle")
    ),
    mainPanel(leafletOutput('calls_map'))
  ),
  # Tab that shows other interactive plots
  tabPanel("Interactive Plots")
))
