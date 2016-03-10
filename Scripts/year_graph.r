

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

year_graph <- function(data) {
  setwd("/Users/drewmccoy/GitHub/info-498f/assignments/Seattle-911-Calls-2015")
  data <- read.csv("Data/911Calls.csv", stringsAsFactors = FALSE)
  
  library(dplyr)
  library(plotly)
  
  sorted_data <- data %>% 
    mutate(date = unlist(lapply(data$At.Scene.Time, format_date))) %>% 
    group_by(date) %>% 
    summarize(calls = n())
  
  graph <- sorted_data %>% plot_ly(
    x = date,
    y = calls, 
    mode = "markers"
    )
}  
  
