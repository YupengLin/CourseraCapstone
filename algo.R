freq_one <- sort(table(tokens), decreasing=T)
stat_one <- data.frame(word = row.names(freq_one), count = as.vector(freq_one))
stat_one$prob <- stat_one$count / length(tokens)

freq_two <- sort(table(two_tokens), decreasing = T)
stat_two <- data.frame(word = row.names(freq_two), count = as.vector(freq_two))
stat_two$prob <- stat_two$count / length(two_tokens)

freq_three <- sort(table(three_tokens), decreasing = T)
stat_three <- data.frame(word= row.names(freq_three), count = as.vector(freq_three))
stat_three$prob <- stat_three$count / length(three_tokens)