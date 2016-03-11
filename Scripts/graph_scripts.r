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

call_breakdown_graph <- function(data, slice) {
  # select slice of data to graph
  if (slice == 1) {
    data <- slice(data,1:21)
  } else {
    data <- slice(data,22:42)
  }
  
  # create graph
  m1 <- list (
    b = 150,
    t = 100,
    r = 125
  )
  f <- list(
    family = "Arial",
    size = 10,
    color = "#7f7f7f"
  )
  #set x axis title
  x1 <- list (
    title = "Category of Crime",
    tickfont = f
  )
  #set y axis title
  y1 <- list (
    title = "Instances",
    tickfont = f
  )
  state_data <- data %>% plot_ly(
    x = Event.Clearance.Group,
    y = instances,
    name = "Crime",
    type = "bar",
    text = paste(Event.Clearance.Group, ":", instances, "instances", sep = " "),   
    hoverinfo = "text"
    ) %>% 
    layout(title = "Breakdown of 2015 Seattle 911 Calls by Category", 
           xaxis = x1, 
           yaxis = y1, 
           margin = m1)
  return(state_data)
}

specific_breakdown_graph <- function(data, crime_type) {
  # filter down to specific clearence group
  specific_data <- data %>% 
    filter(Event.Clearance.Group == crime_type) %>% 
    arrange(-instances)
  
  # create graph
  m2 <- list (
    b = 250,
    r = 100,
    t = 75,
    r = 125
  )
  f <- list(
    family = "Arial",
    size = 10,
    color = "#7f7f7f"
  )
  #set x axis title
  x2 <- list (
    title = "Specific Category of Crime",
    tickfont = f
  )
  #set y axis title
  y2 <- list (
    title = "Instances",
    tickfont = f
  )
  
  individual_plot <- specific_data %>% plot_ly(
    x = Event.Clearance.Description,
    y = instances,
    name = "Traffic Violations",
    type = "bar",
    text = paste("Most incidents on:", greatest_street, sep = " "),
    hoverinfo = "text"
    ) %>% 
    layout(title = paste("Breakdown of 2015 Seattle 911 Calls for", crime_type, "by Subgroup", sep = " "), 
           xaxis = x2, 
           yaxis = y2, 
           margin = m2)
  return(individual_plot)
}
