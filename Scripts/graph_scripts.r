# source in scripts

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
  margin <- list(
    t = 50
  )
  graph <- data %>% plot_ly(
    x = date,
    y = calls, 
    mode = "markers"
  ) %>% 
    layout(title = "Calls by Day of the Year",
           yaxis = list(title = "Number of Calls"), 
           xaxis = list(title = "Date"),margin = margin)
  return(graph)
}  

# returns a scatter plotly of calls by time of day
time_graph <- function(data) {
  margin <- list(
   t = 50
  )
  graph <- data %>% plot_ly(
    x = time,
    y = calls, 
    mode = "markers"
  ) %>% 
    layout(title = "Calls by Time of the Day",
           yaxis = list(title = "Number of Calls"), 
           xaxis = list(title = "Time in Hours"), margin = margin)
  return(graph)
}

# returns a bar plotly of calls by month
month_graph <- function(data) {
  margin <- list(
    b = 100,
    r = 50,
    t = 50
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

call_breakdown_graph <- function(data, slice) {
  # select slice of data to graph
  if (slice == 1) {
    data <- slice(data,1:21)
    graph_title <- "Breakdown of 2015 Seattle 911 Calls by Category"
    x_axis_title <- ""
    top_margin <- 100
    bot_margin <- 125
  } else {
    data <- slice(data,22:42)
    graph_title <- ""
    x_axis_title <- "Category of Crime"
    top_margin <- 25
    bot_margin <- 150
  }
  
  # create graph
  m1 <- list (
    b = bot_margin,
    t = top_margin,
    r = 125
  )
  f <- list(
    size = 10
  )
  #set x axis title
  x1 <- list (
    title = x_axis_title,
    tickfont = f
  )
  #set y axis title
  y1 <- list (
    title = "Instances",
    tickfont = f,
    range = c(0, 10000)
  )
  state_data <- data %>% plot_ly(
    x = Event.Clearance.Group,
    y = instances,
    name = "Crime",
    type = "bar",
    text = paste(Event.Clearance.Group, ":", instances, "instances", sep = " "),   
    hoverinfo = "text"
    ) %>% 
    layout(title = graph_title, 
           xaxis = x1, 
           yaxis = y1, 
           margin = m1
           )
  return(state_data)
}

specific_breakdown_graph <- function(data, crime_type) {
  # filter down to specific clearence group
  specific_data <- data %>% 
    filter(Event.Clearance.Group == crime_type) %>% 
    arrange(-instances)
 bot_margin <- 100
   if(crime_type == "TRAFFIC RELATED CALLS" |crime_type == "BURGLARY"){
    bot_margin <- 200
   }
 if(crime_type == "NARCOTICS COMPLAINTS"){
   bot_margin <- 125
 }
  # create graph
  m2 <- list (
    b = bot_margin,
    r = 100,
    t = 75,
    r = 125
  )
  f <- list(
    size = 8
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
