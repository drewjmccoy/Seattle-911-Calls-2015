build_map <- function(data, violent) {
  if (violent) {
    data <- violent_crimes(data)
  }
  
  map <- leaflet(data) %>% addTiles() %>% addMarkers(
    clusterOptions = markerClusterOptions(),popup = ~ as.character(Event.Clearance.Description)
  )
  return (map)
}
