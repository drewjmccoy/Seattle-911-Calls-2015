build_map <- function(data, location, violent) {
  if (violent) {
    data <- violent_crimes(data)
  }
  
  map <- leaflet(data) %>% addTiles() %>% addMarkers(
    clusterOptions = markerClusterOptions(),popup = ~ as.character(Event.Clearance.Description)
  )
  coordinates <- lat_and_lng(location)
  map <-
    setView(map,lng = coordinates[2], lat = coordinates[1], zoom = coordinates[3])
  return (map)
}
