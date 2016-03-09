library(dplyr)
library(plotly)
call_breakdown <- function(data){
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
return(state_data)
}

specific_data <- function(data, crime_type) {
summary <- group_by(data, Event.Clearance.Group, Event.Clearance.Description) %>%
  summarize(instances = n())  
individual_data <- filter(summary, Event.Clearance.Group == crime_type)
individual_data$Event.Clearance.Description <- as.character(individual_data$Event.Clearance.Description)
individual_data <- mutate(individual_data, greatest_street = sapply(individual_data$Event.Clearance.Description,most_instances, data = data))
individual_plot <- plot_ly(individual_data,
                        x = Event.Clearance.Description,
                        y = instances,
                        name = "Traffic Violations",
                        type = "bar",
                        text = paste("The worst street for", Event.Clearance.Description, ":", greatest_street, sep = " "),
                        hoverinfo = "text"
                        )
return(individual_plot)
}

