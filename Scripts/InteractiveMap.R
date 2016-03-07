build_map <- function(data, start, end){
  data <- data[monthly_row_nums(start):monthly_row_nums(end),]
  leaflet(data) %>% addTiles() %>% addMarkers(
    clusterOptions = markerClusterOptions(),popup = ~as.character(Event.Clearance.Description) 
  )
}
