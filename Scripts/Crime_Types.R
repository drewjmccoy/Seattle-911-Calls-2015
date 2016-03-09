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
traffic_calls <- filter(summary, Event.Clearance.Group == "TRAFFIC RELATED CALLS")
traffic_calls$Event.Clearance.Description <- as.character(traffic_calls$Event.Clearance.Description)
traffic_calls <- mutate(traffic_calls, most_instances = most_instances(data,traffic_calls$Event.Clearance.Description))


most_instances <- function(data, description){
  street <- filter(data, Event.Clearance.Description == description) %>% 
    group_by(Hundred.Block.Location) %>% 
    summarize(instances = n()) %>% 
    filter(instances == max(instances)) %>% 
    select(Hundred.Block.Location)
  return(as.character(street$Hundred.Block.Location[1]))
}
bunk <- most_instances(data, "ABANDONED VEHICLE")
