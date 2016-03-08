library(dplyr)
library(plotly)

data <- read.csv(file = 'C:/Users/Brendan/Documents/Git/info498f/Seattle-911-Calls-2015/Data/911Calls.csv')
types <- unique(data$Event.Clearance.Group)
summary <- group_by(data, Event.Clearance.Group, Event.Clearance.Description) %>%
  summarize(instances = n())

state_data <- plot_ly(summary,
                      x = Event.Clearance.Group,
                      y = instances,
                      name = "killed",
                      type = "bar",
                      hoverinfo = "none"
)
state_data

traffic_calls <- 
