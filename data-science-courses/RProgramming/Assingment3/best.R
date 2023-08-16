best <- function(state, outcome) {
  #Read outcome data
  data <- read.csv("outcome-of-care-measures.csv")
  outcomes <- c('heart attack', 'heart failure', 'pneumonia')
  columns <- c(11, 17, 23)
  #Check that state and outcome are valid
  if (!state %in% data$State) stop("invalid state")
  if (!outcome %in% outcomes) stop("invalid outcome")
  #Return hospital name in that state with lowest 30-day
  #death rate
  j <- columns [match(outcome, outcomes)]
  hospitals <- data[data$State == state, c(2, j)]
  hospitals[, 2] <- as.numeric(as.character(hospitals[, 2]))
  hospitals <- na.omit(hospitals)
  names(hospitals) <- c("name", "deaths")
  min_deaths <- min(hospitals$deaths)
  candidates <- hospitals[hospitals$deaths == min_deaths, ]$name
  return(as.character(sort(candidates)[1]))
  
}