# require libraries
library(dplyr)

# source in scripts
source("scripts/data_wrangling_scripts.r")

# Read in data
data <- read.csv("data/911Calls.csv", stringsAsFactors = FALSE)

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

# data for the call_breakdown graph
call_breakdown_graph_data <- data %>%
  group_by(Event.Clearance.Group) %>%
  summarize(instances = n()) %>%
  arrange(-instances)
call_breakdown_graph_data[42,1] <- "FAIL TO REGISTER SEX OFFENDER"

# data for the specific_breakdown graph
specific_breakdown_graph_data <- data %>% 
  group_by(Event.Clearance.Group, Event.Clearance.Description) %>%
  summarize(instances = n()) %>%
  mutate(greatest_street = sapply(Event.Clearance.Description, most_instances, data = data))
