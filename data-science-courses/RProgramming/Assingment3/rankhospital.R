rankhospital <- function(state, outcome, num) {
  #Read outcome data
  data <- read.csv("outcome-of-care-measures.csv")
  outcomes <- c('heart attack', 'heart failure', 'pneumonia')
  columns <- c(11, 17, 23)
  rank <- c('best', 'worst', 1:4706)
  #Check that state and outcome are valid
  if (!state %in% data$State) stop("invalid state")
  if (!outcome %in% outcomes) stop("invalid outcome")
  if (num > data$sum(data$State, na.rm=TRUE))
      return(NA)
  #Return hsp name i state with rank (30-day death rate)
  #name of hospital that has ranking=num
  #num: best, worst, >integer<
    #if num > #hospitals
      #return(NA)
    #hosp without outcome (NAs)>> excluded from ranking 
      #ties sorted alphabetically
  j <- columns [match(outcome, outcomes)]
  i <- columns [match(num, rank)]
  hospitals <- data[data$State == state, c(2, j)]
  rankings <- data[data$State == state, c(2, j)]
  hospitals[, 2] <- as.numeric(as.character(hospitals[, 2]))
  hospitals <- na.omit(hospitals)
  names(hospitals) <- c("name", "deaths")
  min_deaths <- min(hospitals$deaths)
  candidates <- hospitals[hospitals$deaths == min_deaths, ]$name
  return(as.character(sort(candidates)[1]))
  
  
}