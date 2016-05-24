load("ngram.RData")
library(data.table)
library(stringr)
Bitable <- data.table(tdmBigram)
Tritable <- data.table(tdmTrigram)
Quadtable <- data.table(tdmQuadgram)
setkey(Bitable, base)
setkey(Tritable, base)
setkey(Quadtable, base)

infer <- function(input){
  word <- gsub("[^a-zA-Z\n\']", " ", input)
  word <- tolower(word)
  trim <- function(x) return(gsub("^ *|(?<= ) | *$", "", x, perl=T))
  word<-trim(word)      
  
  str <- unlist(str_split(word," "))
  len <- length(str)
  
  if(len >= 3) {
    result <- threewordSearch(str[len - 2], str[len - 1], str[len])
    if(is.na(result[,pred])) {
      result <- twowordSearch(str[len - 1], str[len])
      if(is.na(result[,pred])) {
        result <- onewordSearch(str[len])
      }
    }
  }
  
  if(len == 2) {
    result <- twowordSearch(str[len - 1], str[len])
    if(is.na(result[,pred])) {
      result <- onewordSearch(str[len])
    }
  }
  
  if(len == 1) {
    result <- onewordSearch(str[len])
  }
word1 <- as.character(result[1,pred])
word2 <- as.character(result[2,pred])
word3 <- as.character(result[3,pred])

c(word1, word2, word3)


}

# Three word search
threewordSearch <- function(word1, word2, word3) {
  inquiry <- paste(word1, word2, word3)
  Quadtable[inquiry,]
}

# Two word search
twowordSearch <- function(word1, word2) {
  inquiry <- paste(word1, word2)
  Tritable[inquiry,]
}

# One word search
onewordSearch <- function(word1) {
  Bitable[word1,]
}


