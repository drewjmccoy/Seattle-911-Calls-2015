format_date <- function(date) {
  date <- unlist(strsplit(date, " "))[1]
  temp <- as.integer(unlist(strsplit(date, "/")))
  result <- "2015-"
  if (temp[1] < 10) {
    result <- paste0(result, "0")
  }
  result <- paste0(result, temp[1], "-")
  if (temp[2] < 10) {
    result <- paste0(result, "0")
  }
  result <- paste0(result, temp[2])
  return(result)
}

day_graph <- function(data) {
  sorted_data <- data %>% 
    mutate(date = unlist(lapply(data$At.Scene.Time, format_date))) %>% 
    group_by(date) %>% 
    summarize(calls = n())
  
  graph <- sorted_data %>% plot_ly(
    x = date,
    y = calls, 
    mode = "markers"
    ) %>% 
    layout(title = "Calls by Day of the Year",
           yaxis = list(title = "Number of Calls"), 
           xaxis = list(title = "Date"))
  return(graph)
}  
day_graph(data)

time_graph <- function(data) {
  sorted_data <- data %>% 
    mutate(time = unlist(lapply(data$At.Scene.Time, format_time))) %>% 
    group_by(time) %>% 
    summarize(calls = n())
  
  graph <- sorted_data %>% plot_ly(
    x = time,
    y = calls, 
    mode = "markers"
  ) %>% 
    layout(title = "Calls by Time of the Day",
           yaxis = list(title = "Number of Calls"), 
           xaxis = list(title = "Time"))
  return(graph)
}

format_time <- function(time) {
  return(as.integer(substr(time, nchar(time) - 4, nchar(time) - 3)))
}

  
