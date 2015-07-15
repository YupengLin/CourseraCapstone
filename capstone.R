library(tm)
library(RWeka)
filePath_blog <- "final/en_US/en_US.blogs.txt"
filePath_news <- "final/en_US/en_US.news.txt"
filePath_twitter <- "final/en_US/en_US.twitter.txt"
conn_blog <- file(filePath_blog)
conn_news <- file(filePath_news)
conn_twitter <- file(filePath_twitter)

blogs <- readLines(conn_blog)
news <- readLines(conn_news)
twitter <- readLines(conn_twitter)

set.seed(1234)
comb <- c(blogs, news, twitter)
index <- c(1:length(comb))
training_index <- sample(index, length(index)*0.6)
training_set <- comb[training_index]
testing_set <- comb[-training_index]



blog_corpus <- VCorpus(VectorSource(training_set))
toSpace <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
blog_corpus <- tm_map(blog_corpus, toSpace, "/")
blog_corpus <- tm_map(blog_corpus, toSpace, "@")
blog_corpus<- tm_map(blog_corpus, toSpace, "\\|")
blog_corpus <- tm_map(blog_corpus,content_transformer(tolower))
blog_corpus <- tm_map(blog_corpus,removeNumbers)
blog_corpus <- tm_map(blog_corpus,removePunctuation)
blog_corpus <- tm_map(blog_corpus,removeWords, stopwords("english"))
blog_corpus <- tm_map(blog_corpus, stripWhitespace)

sentence <- ""
for (i in 1:length(training_set)){
  sentence <- paste(sentence, as.character(blog_corpus[[i]]))
}
tokens <- unlist(strsplit(sentence," "))
tokens <- tokens[tokens != ""]

two_tokens <- c("")
three_tokens <-c("")

for(i in 1:length(training_set)){
  sentence <- ""
  sentence <- paste(sentence, as.character(blog_corpus[[i]])) #ingest single sentence
  one_token <- unlist(strsplit(sentence," "))
  one_token <- one_token[one_token != ""]
  one_token_moved <- c(one_token[-1], ".")
  sentence_tokens <- paste(one_token, one_token_moved)
  two_tokens <- c(two_tokens, sentence_tokens)
  
  one_token_moved2 <- c(one_token_moved[-1], ".")
  trigram_tokens <- paste(one_token, one_token_moved, one_token_moved2)
  three_tokens <- c(three_tokens, trigram_tokens)
}
