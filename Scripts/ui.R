# UI script
library(shiny)
library(leaflet)
shinyUI(fluidPage(
  titlePanel("911 Calls in 2015"),
  
  sidebarPanel(
    sliderInput("slider_range", label = h3("Month Range"), min = 1, 
                max = 12, value = c(1, 12))
  ),
  mainPanel(
    leafletOutput('calls_map')
  )
)
)

