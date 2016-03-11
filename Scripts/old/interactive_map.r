# Build's a leaflet map based on the given data. Filters the data down to just violent crimes if the violent condition is true
build_map <- function(data, violent) {
  if (violent) {
    data <- violent_crimes(data)
  }
  
  map <- leaflet(data) %>% addTiles() %>% addMarkers(
    clusterOptions = markerClusterOptions(),popup = ~ as.character(Event.Clearance.Description)
  )
  return (map)
}
