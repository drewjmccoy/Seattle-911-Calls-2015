library(dplyr)
library(plotly)
data <- read.csv(file = 'C:/Users/Brendan/Documents/Git/info498f/Seattle-911-Calls-2015/Data/911Calls.csv')
types <- unique(data$Event.Clearance.Group)
summary <- group_by(data, Event.Clearance.Group, Event.Clearance.Description) %>%
summarize(instances = n())
state_data <- plot_ly(summary,
                         x = Event.Clearance.Group,
                         y = instances,
                         name = "Crime",
                         type = "bar",
                         hoverinfo = "none"
                        )
state_data
traffic_calls <- filter(summary, Event.Clearance.Group == "TRAFFIC RELATED CALLS")
traffic_calls$Event.Clearance.Description <- as.character(traffic_calls$Event.Clearance.Description)
traffic_calls <- mutate(traffic_calls, greatest_street = sapply(traffic_calls$Event.Clearance.Description,most_instances, data = data))
traffic_data <- plot_ly(traffic_calls,
                        x = Event.Clearance.Description,
                        y = instances,
                        name = "Traffic Violations",
                        type = "bar",
                        text = greatest_street,
                        hoverinfo = "text"
                        )

most_instances <- function(description, data){
  data$Event.Clearance.Description <- as.character(data$Event.Clearance.Description)
  data$Hundred.Block.Location <- as.character(data$Hundred.Block.Location)
  street <- filter(data, Event.Clearance.Description == description) %>% 
    group_by(Hundred.Block.Location) %>% 
    summarize(instances = n()) %>%   
    arrange(-instances)
  value <- street$Hundred.Block.Location[1]
  return(value)
}
bunk <- most_instances(data, "ABANDONED VEHICLE")
