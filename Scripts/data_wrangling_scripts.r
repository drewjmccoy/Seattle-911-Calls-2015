# Script that contains helpful functions for manipulating data
library(lubridate)
library(dplyr)

# Sort's the data frame by date
sort_by_date <- function(data) {
  data <-
    data[order(as.Date(data$At.Scene.Time, "%m/%d/%Y"), decreasing = FALSE),]
  return (data)
}

# Returns the street where the most 911 calls, that meet a given description, happen.
most_instances <- function(description, data){
  data$Event.Clearance.Description <- as.character(data$Event.Clearance.Description)
  data$Hundred.Block.Location <- as.character(data$Hundred.Block.Location)
  street <- filter(data, Event.Clearance.Description == description) %>% 
               group_by(Hundred.Block.Location) %>% 
                summarize(instances = n()) %>%   
                  arrange(-instances)
  value <- street$Hundred.Block.Location[1]
  return(value)
}
# Returns the data filtered down to contain only "violent" crimes
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
# Useful for filtering certain the data down to certain months
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

# Lattitudes and longitudes for a given destinations
lat_and_lng <- function (place) {
  return (geocode(place))
}

# takes in a date with format %m/%d/%y %h:%M and returns a date with format %Y-%M-%D
format_date <- function(date) {
  date <- unlist(strsplit(date, " "))[1]
  temp <- as.integer(unlist(strsplit(date, "/")))
  result <- "2015-"
  if (temp[1] < 10) {
    result <- paste0(result, "0")
  }
  result <- paste0(result, temp[1], "-")
  if (temp[2] < 10) {
    result <- paste0(result, "0")
  }
  result <- paste0(result, temp[2])
  return(result)
}

# takes in a time of format %m/%d/%y %h:%M and returns a time with format %m
format_time <- function(time) {
  return(as.integer(substr(time, nchar(time) - 4, nchar(time) - 3)))
}

# Format's data for the month graph
format_month_data <- function(data) {
  new_data <- select(data, At.Scene.Time, Event.Clearance.Description)
  
  with_month <- mutate(new_data, Month = substr(At.Scene.Time, 0, (regexpr("/",At.Scene.Time)-1)))
  
  with_common <- with_month %>% 
    group_by(Month) %>% 
    summarize(Event.Clearance.Description = names(which.max(table(Event.Clearance.Description))))
  
  summary <- group_by(with_month, Month) %>%
    summarize(Count = n()) %>% 
    arrange(-Count)
  
  joined <- left_join(with_common, summary, by='Month')
  
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
  months_fixed <- mutate(joined, Month = months)
  
  return (months_fixed)
}