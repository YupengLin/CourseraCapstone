load("ngram.RData")
library(stringr)
infer <- function(input, index){
  word <- gsub("[^a-zA-Z\n\']", " ", input)
  word <- tolower(word)
  trim <- function(x) return(gsub("^ *|(?<= ) | *$", "", x, perl=T))
  word<-trim(word)      
  
  str <- unlist(str_split(word," "))
  len <- length(str)
  
  if(len >= 3) {
    result <- threewordSearch(str[len - 2], str[len - 1], str[len])
    if(nrow(result) == 0) {
      result <- twowordSearch(str[len - 1], str[len])
      if(nrow(result) == 0) {
        result <- onewordSearch(str[len])
      }
    }
  }
  
  if(len == 2) {
    result <- twowordSearch(str[len - 1], str[len])
    if(nrow(result) == 0) {
      result <- onewordSearch(str[len])
    }
  }
  
  if(len == 1) {
    result <- onewordSearch(str[len])
  }
    
as.character(result[index,"pred"])

}

threewordSearch <- function(word1, word2, word3) {
  inquiry <- paste(word1, word2, word3)
  tdmQuadgram[tdmQuadgram$base == inquiry, ]
}

twowordSearch <- function(word1, word2) {
  inquiry <- paste(word1, word2)
  tdmTrigram[tdmTrigram$base == inquiry, ]
}

onewordSearch <- function(word1) {
  tdmBigram[tdmBigram$base == word1, ]
}

