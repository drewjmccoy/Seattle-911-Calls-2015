# set working directory
setwd("/Users/drewmccoy/GitHub/info-498f/assignments/Seattle-911-Calls-2015")

# source in scripts
source("scripts/data_wrangling.r")

# returns a scatter plotly of calls by day of year
day_graph <- function(data) {
  graph <- data %>% plot_ly(
    x = date,
    y = calls, 
    mode = "markers"
  ) %>% 
    layout(title = "Calls by Day of the Year",
           yaxis = list(title = "Number of Calls"), 
           xaxis = list(title = "Date"))
  return(graph)
}  

# returns a scatter plotly of calls by time of day
time_graph <- function(data) {
  graph <- data %>% plot_ly(
    x = time,
    y = calls, 
    mode = "markers"
  ) %>% 
    layout(title = "Calls by Time of the Day",
           yaxis = list(title = "Number of Calls"), 
           xaxis = list(title = "Time"))
  return(graph)
}

# returns a bar plotly of calls by month
month_graph <- function(data) {
  months <- list(
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  )
  margin <- list(
    b = 75
  )
  graph <- plot_ly(data,
          x = Month,
          y = Count,
          name = "Crime by Month",
          type = "bar",
          text = paste("Most Common Crime Type:", Event.Clearance.Description, "Overall Count", Count,  sep = " "),   
          hoverinfo = "text"
  ) %>% 
    layout(title = 'Crime by Month', margin = margin)
  return(graph)
}

# Build's a leaflet map based on the given data. Filters the data down to just violent crimes if the violent condition is true
build_map <- function(data, violent) {
  if (violent) {
    data <- violent_crimes(data)
  }
  
  map <- leaflet(data) %>% addTiles() %>% addMarkers(
    clusterOptions = markerClusterOptions(),popup = ~ as.character(Event.Clearance.Description)
  )
  return (map)
}
