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

time_graph <- function(data) {
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
