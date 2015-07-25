library(tm)
#library(RWeka)
#library(parallel)
#library(foreach)
#library(doParallel)
filePath_blog <- "final/en_US/en_US.blogs.txt"
filePath_news <- "final/en_US/en_US.news.txt"
filePath_twitter <- "final/en_US/en_US.twitter.txt"
conn_blog <- file(filePath_blog)
conn_news <- file(filePath_news)
conn_twitter <- file(filePath_twitter)

set.seed(1234)

blogs <- readLines(conn_blog)
blog_index <- c(1:length(blogs))
blog_training_index <- sample(blog_index, round(length(blog_index) * 0.01))
blog_training_set <- blogs[blog_training_index]
blog_testing_set <- blogs[-blog_training_index]

news <- readLines(conn_news)
news_index <- c(1:length(news))
news_training_index <- sample(news_index, round(length(news_index) * 0.01))
news_training_set <- news[news_training_index]
news_testing_set <- news[-news_training_index]

twitter <- readLines(conn_twitter)
twitter_index <- c(1:length(twitter))
twitter_training_index <- sample(twitter_index, round(length(twitter_index) * 0.01))
twitter_training_set <- twitter[twitter_training_index]
twitter_testing_set <- twitter[-twitter_training_index]

close(conn_blog)
close(conn_twitter)
close(conn_news)
training_set <- c(blog_training_set, news_training_set, twitter_training_set)


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
