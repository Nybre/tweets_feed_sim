############################################################################
## UNIT TESTING
############################################################################
library(testthat)

#---------test user sampling function (1)---------------

#test one user: good
show_failure(expect_identical(name_extraction("Brian"),"Brian"))
#test one user: bad
show_failure(expect_identical(name_extraction("Brian"),"Mpho"))

#test for list of users with keyword: good
users = "Alan follows Martin"
output = c("Alan", "Martin")
show_failure(expect_identical(name_extraction(users), output))
#test for list of users with keyword: good
users = "Alan follows Martin"
output = c("Alan", "Mpho")
show_failure(expect_identical(name_extraction(users), output))


# test for no users: good
expect_identical(name_extraction(""), character(0))
# test for no users: bad
show_failure(expect_identical(name_extraction(""), NA)) 
show_failure(expect_identical(name_extraction(""), ""))


#test for following multiple users with ordering: good
users_ = "Alan follows Martin, Brian, Mpho"
output_ = c("Alan", "Brian", "Martin", "Mpho")
show_failure(expect_identical(name_extraction(users_), output_))

#test for following multiple users with ordering: bad
users_ = "Alan follows Martin, Brian, Mpho"
output_ = c("Alan", "Martin", "Brian", "Mpho")
show_failure(expect_identical(name_extraction(users_), output_))

#---------test user sampling function (1)---------------

# expect null: good 
show_failure(expect_identical(extract_tweet_feeds("Mpho","Brian> testing."),"Mpho"))
show_failure(expect_identical(extract_tweet_feeds("Mpho","Brian> testing."),NULL))
expect_null(extract_tweet_feeds("Mpho","Brian> testing."))

