# How to Get Twitter Data using R
# Source: https://www.r-bloggers.com/2022/03/how-to-get-twitter-data-using-r/?utm_source=phpList&utm_medium=email&utm_campaign=R-bloggers-daily&utm_content=HTML
# Posted on March 5, 2022 by George Pipis 
# --------
#Install the rtweet Library and API Authorization
# We can install the rtweet library either from CRAN or from GitHub as follows:
## install rtweet from CRAN
# install.packages("rtweet")
## OR
## install remotes package if it's not already
if (!requireNamespace("remotes", quietly = TRUE)) {
  install.packages("remotes")
}
if (!requireNamespace("remotes", quietly = TRUE)) {
## install dev version of rtweet from github
remotes::install_github("ropensci/rtweet")
}

#Install and Load R packages
if (!requireNamespace("twitteR", quietly = TRUE)) {
  install.packages("twitteR")
}

library("twitteR")

#Then we are ready to load the library:
## load rtweet package
library(rtweet)

## load the tidyverse
library(tidyverse)

## store api keys (these are fake example values; replace with your own keys)
access_token <- "21497396-C2BRBV5xyEhWvL0GpBdqto3QjNdtWGinQFT0K85Xm"
access_token_secret <- "LL8SYQ3GC3N7Lpc2YFhefqbjkE9g3bJE2dXIY2YHLfO6z"

api_key = "Tn3fhOeqB2T9Y9XwbYTCjsEB2"
api_secret_key = "FR6YfcVmdI1J18aUuLnub1UZGhCLeGlM0QDdQlKgLVrj5KP6i5"
## authenticate via web browser
token <- create_token(
  app = "tweepy-jpa",
  consumer_key = api_key,
  consumer_secret = api_secret_key)

get_token()

# Second way...
setup_twitter_oauth(api_key,api_secret_key,access_token,access_token_secret)

searchTwitter("nba", n=3, lang="en")

#Search Tweets
# Now we are ready to get our first data from Twitter, starting with 1000 tweets containing the hashtag “#DataScience” 
# by excluding the re-tweets. Note that the “search_tweets” returns data from the last 6-9 days

#rt <- search_tweets("#DataScience", n = 1000, include_rts = FALSE)
rt <- searchTwitter("#DataScience", n = 1000)
View(rt)

## lapply through three different search queries
lrt <- lapply(
  c("rstats OR tidyverse", "data science", "python"),
  search_tweets,
  n = 5000
)

lrt <- lapply(
  c("rstats OR tidyverse", "data science", "python"),
  searchTwitter,
  n = 5000
)
## convert list object into single parsed data rame
xrt <- do_call_rbind(lrt)

## preview tweets data
xrt

## preview users data
users_data(xrt)

# Usually, we want to get the screen name, the text, the number of likes and the number of re-tweets.
View(
  rt %>% select(screen_name, text, favorite_count, retweet_count))

