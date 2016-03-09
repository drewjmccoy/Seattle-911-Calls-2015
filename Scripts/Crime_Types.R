f <- list(
  family = "Courier New, monospace",
  size = 18,
  color = "#7f7f7f"
)
topText <- renderText({
  "Below is a breakdown of 911 calls in Seattle by specific subgroup.
    You can use the dropdown on the left to select which type of crime you'd like to investigate:" 
  })
lowerText <- renderText({"Below is a chart displaying the frequencies in which certain crimes were reported, shown by general group:"
  })

call_breakdown <- function(data){
types <- unique(data$Event.Clearance.Group)
summary <- group_by(data, Event.Clearance.Group, Event.Clearance.Description) %>%
summarize(instances = n())
state_data <- plot_ly(summary,
                         x = Event.Clearance.Group,
                         y = instances,
                         name = "Crime",
                         type = "bar",
                         text = paste(Event.Clearance.Group, ":", instances, "instances", sep = " "),
                         hoverinfo = "text"
                        )
m <- list (
  l = 100,
  r = 50,
  b = 325,
  t = 75,
  pad = 4
)

#set x axis title
x <- list (
  title = "Category of Crime",
  titlefont = f
)

#set y axis title
y <- list (
  title = "Instances",
  titlefont = f
)
state_data <- layout(data, title = "Breakdown of 2015 Seattle 911 Calls by Category", xaxis = x, yaxis = y ,margin = m)
return(state_data)
}
call_breakdown(data)

specific_data <- function(data, type) {
summary <- group_by(data, Event.Clearance.Group, Event.Clearance.Description) %>%
  summarize(instances = n())  
individual_data <- filter(summary, Event.Clearance.Group == type)
individual_data$Event.Clearance.Description <- as.character(individual_data$Event.Clearance.Description)
individual_data <- mutate(individual_data, greatest_street = sapply(individual_data$Event.Clearance.Description,most_instances, data = data))
individual_plot <- plot_ly(individual_data,
                        x = Event.Clearance.Description,
                        y = instances,
                        name = "Traffic Violations",
                        type = "bar",
                        text = paste(instances, "instances on", greatest_street, sep = " "),
                        hoverinfo = "text"
                        )
m <- list (
  l = 100,
  r = 50,
  b = 325,
  t = 75,
  pad = 4
)

#set x axis title
x <- list (
  title = "Specific Category of Crime",
  titlefont = f
)

#set y axis title
y <- list (
  title = "Instances",
  titlefont = f
)

state_data <- layout(data, title = paste("Breakdown of 2015 Seattle 911 Calls for", Event.Clearance.Description, "by Subgroup", sep = " "), xaxis = x, yaxis = y ,margin = m)
return(individual_plot)
}
specific_data(data, "ASSAULTS")

