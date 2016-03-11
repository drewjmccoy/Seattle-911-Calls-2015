
# source in scripts
source("scripts/data_wrangling.r")

# returns a scatter plotly of calls by day of year
graph_to_display <- function(graph_num){
  if(graph_num == 1){
    graph <- month_graph(month_graph_data)
  }
  if(graph_num == 2){
    graph <- day_graph(day_graph_data)
  }
  if(graph_num == 3){
    graph <- time_graph(time_graph_data)
  }
  return (graph)
}
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
  margin <- list(
    b = 125
  )
  graph <- plot_ly(data,
          x = Month,
          y = Count,
          name = "Crime by Month",
          type = "bar",
          text = paste("Most Common Crime Type:", Event.Clearance.Description, "Overall Count", Count,  sep = " "),   
          hoverinfo = "text"
  ) %>% 
    layout(title = 'Crime by Month')
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
