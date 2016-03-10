month_data <- function(data){
  new_data <- select(data, At.Scene.Time, Event.Clearance.Description)
  
  with_month <- mutate(new_data, Month = substr(At.Scene.Time, 0, (regexpr("/",At.Scene.Time)-1)))
  
  with_common <- with_month %>% 
    group_by(Month) %>% 
    summarize(Event.Clearance.Description = names(which.max(table(Event.Clearance.Description))))
  
  summary <- group_by(with_month, Month) %>%
    summarize(Count = n()) %>% 
    arrange(-Count)
  
  joined <- left_join(with_common, summary, by='Month')
  
  months_fixed <- mutate(joined, Month = months)
  
  months <- list(
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  )
  margin <- list(
    b = 75
  )
  plot_ly(months_fixed,
      x = Month,
      y = Count,
      name = "Crime by Month",
      type = "bar",
      text = paste("Most Common Crime Type:", Event.Clearance.Description, "Overall Count", Count,  sep = " "),   
      hoverinfo = "text"
  ) %>% 
    layout(title = 'Crime by Month', margin = margin)
}
