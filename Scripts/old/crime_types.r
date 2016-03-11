f <- list(
  family = "Arial",
  size = 10,
  color = "#7f7f7f"
)
call_breakdown <- function(data, slice){
  #types <- unique(data$Event.Clearance.Group)
  summary <- group_by(data, Event.Clearance.Group) %>%
    summarize(instances = n()) %>% 
    arrange(-instances)
  if(slice == 1){
  summary <- slice(summary,1:21)
  }
  else{
  summary <- slice(summary,22:42)
  }
  state_data <- plot_ly(summary,
                        x = Event.Clearance.Group,
                        y = instances,
                        name = "Crime",
                        type = "bar",
                        text = paste(Event.Clearance.Group, ":", instances, "instances", sep = " "),   
                        hoverinfo = "text"
  )
  m1 <- list (
    b = 150,
    t = 100,
    r = 125
  )
  #set x axis title
  x1 <- list (
    title = "Category of Crime",
    tickfont = f
  )
  #set y axis title
  y1 <- list (
    title = "Instances",
    tickfont = f
  )
  state_data <- layout(state_data, title = "Breakdown of 2015 Seattle 911 Calls by Category", xaxis = x1, yaxis = y1, margin = m1)
  return(state_data)
}

specific_data <- function(data, crime_type) {
  summary <- group_by(data, Event.Clearance.Group, Event.Clearance.Description) %>%
    summarize(instances = n())  
  individual_data <- filter(summary, Event.Clearance.Group == crime_type) %>% 
                arrange(-instances)
  individual_data$Event.Clearance.Description <- as.character(individual_data$Event.Clearance.Description)
  individual_data <- mutate(individual_data, greatest_street = sapply(individual_data$Event.Clearance.Description,most_instances, data = data))
  
  individual_plot <- plot_ly(individual_data,
                             x = Event.Clearance.Description,
                             y = instances,
                             name = "Traffic Violations",
                             type = "bar",
                             text = paste("Most incidents on:", greatest_street, sep = " "),
                             hoverinfo = "text"
  )
  m2 <- list (
    b = 250,
    r = 100,
    t = 75,
    r = 125
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
  individual_plot <- layout(individual_plot, title = paste("Breakdown of 2015 Seattle 911 Calls for", crime_type, "by Subgroup", sep = " "), xaxis = x2, yaxis = y2, margin = m2 )
  return(individual_plot)
}
