complete <- function(directory, id = 1:332) {
  count_complete <- function(fname) sum(complete.cases(read.csv(fname)))
  fnames <- list.files(directory, full.names=TRUE)[id]
  data.frame(id = id, complete = unlist(lapply(fnames, count_complete)))
}