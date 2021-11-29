##' extract_tweet_feeds function extracts all tweets feeds of a particular user and who they follow
##' 
##' Assumption : when you follow someone, you will be able to see their tweets on your timeline
##'
##' @description
##' function creates list of user and who they follow, then collects all their tweets and individuals they 
##' follow tweets, then displays on their respective tweet timeline 
##'
##' @usage
##' extract_tweet_feeds(users_data, tweets)
##'
##' @param users_data   A character list of user.txt file
##' @param tweets   A character list of tweet.txt file


extract_tweet_feeds = function(users_data, tweets){
  
  # local error handlers
  withCallingHandlers(users_data, tweets,
                      # warning message 
                      warning = function(w){
                        message("warning:\n", w)
                      },
                      # error message
                      error = function(e){
                        message("error:\n", e)
                      })
  
  # function extracts all unique users 
  user = name_extraction(users_data)
  
  ############################################################################
  ## first loop collects list of users and their following
  ############################################################################
  
  # users list
  tweet_users=c()
  
  # following list
  users_following = list()
  
  for (i in 1:NROW(user)){
    
    # users
    tweet_users[i] = user[i] 
    
    # extract every follower
    users_following[[i]] = str_extract(users_data, paste(tweet_users[i],' follows','.*', sep = ""))
    
    # remove NAs
    users_following[[i]] = users_following[[i]][!is.na(users_following[[i]])]
    
    # replace keyword follow including whitespace characters between keyword follow
    users_following[[i]] = sub(" follows ", ",", users_following[[i]]) 
    
    # ensure all whitespaces are removed
    users_following[[i]] = gsub("\\s", "", users_following[[i]]) 
    
    # scan all names separated by comma 
    # first name is the driving name
    # unique to avoid duplicate following
    users_following[[i]]  = unique(scan(text = users_following[[i]] , sep = ",", what = ""))
    
  }
  
  #######################################################################################
  ## Second nested loops collects a list of tweets associated to users and their following
  #########################################################################################
  
  for (i in 1:NROW(users_following)){
    # Update: first name is the driving name 
    users_following[[i]][1] = tweet_users[i]
    
    # output ordered driving names on console 
    cat(tweet_users[i]) 
    
    for (j in 1:NROW(users_following[[i]])){
      
      # remove NA
      users_following[[i]][j] = users_following[[i]][j][!is.na(users_following[[i]][j])] 
      
      # extract matching tweets to user 
      match_tweets = str_extract(tweets, paste(users_following[[i]][j],'.*', sep = ""))
      
      # remove NAs
      match_tweets = match_tweets[!is.na(match_tweets)]
      
      # replace space > and space with :
      tweet_feeds = gsub(paste('> ', sep=""), ": ",match_tweets)
      
      # add @before name of user
      tweet_feeds = gsub(paste(users_following[[i]][j], sep=""), paste("\n\t@",users_following[[i]][j], sep = ""),tweet_feeds)
      
      # output tweets on console
      cat(tweet_feeds,"\n") 
    }
  }
}