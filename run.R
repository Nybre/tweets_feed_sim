# ---> run application by running code below

# load dependency libraries
library("readr")
library("stringr")
library("stringi")

# load/read text files
users_data_input = read_tsv(paste(getwd(),"/txt_files/user.txt",sep =""), col_names = F, show_col_types = F)
tweets_data_input = read_tsv(paste(getwd(),"/txt_files/tweet.txt",sep =""), col_names = F, show_col_types = F)


# extract users data
users_data = users_data_input$X1 

# extract tweets data
tweets = tweets_data_input$X1

# source/load functions
source(paste(getwd(),"/functions/name_extraction_function.R", sep = ""),local=TRUE) 
source(paste(getwd(),"/functions/tweet_feed_function.R", sep = ""),local=TRUE) 

# call function extract_tweet_feeds
extract_tweet_feeds(users_data, tweets)


############################################################################
## UNIT TESTING
############################################################################
  
test_file(paste(getwd(),"/tests/testthat/test_code.R", sep = ""))

