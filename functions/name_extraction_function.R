##' name_extraction function extracts all unique users without followers in alphabetic order
##'
##' @description
##' function extracts all unique users 
##'
##' @usage
##' name_extraction(users_data)
##'
##' @param users_data   A character list of user.txt file


name_extraction = function(users_data){ 
  
  # local error handlers
  withCallingHandlers(users_data,
                      # warning message 
                      warning = function(w){
                        message("warning:\n", w)
                      },
                      # error message
                      error = function(e){
                        message("error:\n", e)
                      })
  
  # use follows as a user separator
  keywords = "(follows)" 
  
  # extract keyword from character vector
  usernames = sub(keywords, "", users_data)  
  
  # remove commas
  usernames = gsub(",","",usernames)
  
  # extract unique names
  usernames = unique(
    unlist(
      strsplit(usernames, " ")
    )
  ) 
  
  # remove empty whitespace from the list
  usernames = stri_remove_empty(usernames)
  
  #return a sorted list of usernames
  return(sort(usernames))
  
}