# set working directory and read in data
setwd("/Users/drewmccoy/GitHub/info-498f/assignments/Seattle-911-Calls-2015")
data <- read.csv("data/911Calls.csv", stringsAsFactors = FALSE)

# source in scripts
source("scripts/data_wrangling_scripts.r")

# data for the day_graph
day_graph_data <- data %>% 
  mutate(date = unlist(lapply(data$At.Scene.Time, format_date))) %>% 
  group_by(date) %>% 
  summarize(calls = n())

# data for the time_graph
time_graph_data <- data %>% 
  mutate(time = unlist(lapply(data$At.Scene.Time, format_time))) %>% 
  group_by(time) %>% 
  summarize(calls = n())

# data for the month_graph
month_graph_data <- format_month_data(data)
