library(lubridate)
library(dplyr)

# Sort's the data frame by date
sort_by_date <- function(data) {
  data <-
    data[order(as.Date(data$At.Scene.Time, "%m/%d/%Y"), decreasing = FALSE),]
  return (data)
}

# Violent crimes only
violent_crimes <- function(data) {
  data <-
    filter(
      data, Event.Clearance.Description == "ASSAULTS, GANG RELATED" |
        Event.Clearance.Description == "HOMICIDE" |
        Event.Clearance.Description == "ARMED ROBBERY" |
        Event.Clearance.Description == "BURGLARY - RESIDENTIAL, OCCUPIED" |
        Event.Clearance.Description == "STRONG ARM ROBBERY" |
        Event.Clearance.Description == "THEFT - MISCELLANEOUS" |
        Event.Clearance.Description == "THEFT - CAR PROWL" |
        Event.Clearance.Description == "HARASSMENT, THREATS" |
        Event.Clearance.Description == "PROPERTY DESTRUCTION" |
        Event.Clearance.Description == "PERSON WITH A GUN" |
        Event.Clearance.Description == "BURGLARY - COMMERCIAL" |
        Event.Clearance.Description == "FIGHT DISTURBANCE" |
        Event.Clearance.Description == "PERSON WITH A WEAPON (NOT GUN)" |
        Event.Clearance.Description == "HARASSMENT, THREATS - BY TELEPHONE, WRITING" |
        Event.Clearance.Description == "DRIVE BY SHOOTING (NO INJURIES)" 
      )
  return (data)
}

# Returns the column number where a month ends
# Useful for filtering certain months
monthly_row_nums <- function(month) {
  row_num <- -1
  if (month == 1) {
    row_num <- 1
  }
  if (month == 2) {
    row_num <- 5749
  }
  if (month == 3) {
    row_num <- 11012
  }
  if (month == 4) {
    row_num <- 17250
  }
  if (month == 5) {
    row_num <- 23547
  }
  if (month == 6) {
    row_num <- 31866
  }
  if (month == 7) {
    row_num <- 39470
  }
  if (month == 8) {
    row_num <- 49783
  }
  if (month == 9) {
    row_num <- 58585
  }
  if (month == 10) {
    row_num <- 66623
  }
  if (month == 11) {
    row_num <- 74633
  }
  if (month == 12) {
    row_num <- 83418
  }
  if (month == 13) {
    row_num <- 91067
  }
  return (row_num)
}

# Lattitudes and longitudes for common destinations
lat_and_lng <- function (place) {
  if (place == "the ave") {
    lat_lng <- c(47.661281,-122.313154,17)
  }
  if (place == "space needle") {
    lat_lng <- c(47.620423,-122.349355,17)
  }
  if (place == "china town") {
    lat_lng <- c(47.598409,-122.325060,17)
  }
  if (place == "Seattle") {
    lat_lng <- c(47.606209,-122.332071, 10)
  }
  
  return (lat_lng)
}
