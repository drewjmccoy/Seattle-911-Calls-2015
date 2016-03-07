build_map <- function(data, start, end, location){
  data <- data[monthly_row_nums(start):monthly_row_nums(end),]
  map <- leaflet(data) %>% addTiles() %>% addMarkers(
    clusterOptions = markerClusterOptions(),popup = ~as.character(Event.Clearance.Description)  
  )
  coordinates <- lat_and_lng(location)
  map <- setView(map,lng = coordinates[2], lat = coordinates[1], zoom = coordinates[3])
  return (map)
}
