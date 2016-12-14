# Extract first element from the strand info
ext1strand <- function(strand){
  strand <- gsub(",.*", "", strand)
  return(strand)
}