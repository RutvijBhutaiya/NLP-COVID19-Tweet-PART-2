

######     COVID19 TWITTER ANAYSIS     #####



## Set Up Twitter API

library(twitteR)
library(ROAuth)

library(base64enc)
library(httr)

api_key = 'sHSKXXlLYAOJhRqETrDuOwi0W'

api_secret = 'azuwJQEumOVYZakdfGyLlmKBXfEMDx4808CxhKeBoaBlYJBa2c'

access_token = '108908632-Lm0LAjRNb6DdBjwOCklitFqAerX2Vd7Qd4WzLkJD'

access_token_secret = 'PgPwa6q2Wb9tryukoEFCs4KOkHyxU4J6x1pOzLmicG6yM'



## Download file : carcert.pem

download.file(url = "http://curl.haxx.se/ca/cacert.pem", destfile = "cacert.pem")



## Setup Twitter 

setup_twitter_oauth('sHSKXXlLYAOJhRqETrDuOwi0W',
                    'azuwJQEumOVYZakdfGyLlmKBXfEMDx4808CxhKeBoaBlYJBa2c',
                    '108908632-Lm0LAjRNb6DdBjwOCklitFqAerX2Vd7Qd4WzLkJD',
                    'PgPwa6q2Wb9tryukoEFCs4KOkHyxU4J6x1pOzLmicG6yM')



############################################################################

## Libraries

library(dplyr)
library(tidyverse)
library(tidytext)







## Extract Tweets 


## 1. Ministry Of Health India: @MoHFW_INDIA


Health_India = searchTwitter('from:@MoHFW_INDIA', 1000, lang = 'en', 
                             since = '2020-03-12', until = '2020-04-12')


Health_India = do.call('rbind', lapply(Health_India, as.data.frame))

View(Health_India)


## 2. The Times of India; @timesofindia : India News

TOI = searchTwitter('from:@timesofindia', 1000, lang = 'en', 
                    since = '2020-03-12', until = '2020-04-12')


TOI = do.call('rbind', lapply(TOI, as.data.frame))

View(TOI)


## 3. CNN Breaking News: @cnnbrk : The USA News


CNN = searchTwitter('from:@cnnbrk', 1000, lang = 'en', 
                    since = '2020-03-12', until = '2020-04-12')


CNN = do.call('rbind', lapply(CNN, as.data.frame))

View(CNN)


## 4. BBC Breaking News: @BBCBreaking : UK News


BBC = searchTwitter('from:@BBCBreaking', 1000, 
                    since = '2020-03-12', until = '2020-04-12')


BBC = do.call('rbind', lapply(BBC, as.data.frame))

View(BBC)




## ################################################################################

## Tweet Statistices

# Number of Followers: From Official Twitter account

# Ministry of Health India : 1.5 million
# Times Of India: 12.6 million
# CNN Breaking News: 57.3 million
# BBC Breaking News: 42.6 million



followeres = c(1500000, 12600000, 57300000, 42600000)


## Retweet Counts

Health_India_retweet = sum(Health_India$retweetCount)

TOI_retweet = sum(TOI$retweetCount)

CNN_retweet = sum(CNN$retweetCount)

BBC_retweet = sum(BBC$retweetCount)

retweet_counts = c(Health_India_retweet, TOI_retweet,CNN_retweet,BBC_retweet)


## Tweet Favourited Count

Health_India_fav = sum(Health_India$favoriteCount)

TOI_fav = sum(TOI$favoriteCount)
  
CNN_fav = sum(CNN$favoriteCount)

BBC_fav = sum(BBC$favoriteCount)

favourited_counts = c(Health_India_fav, TOI_fav, CNN_fav, BBC_fav)



# retweets to followers count ratios

retweet_ratio = (retweet_counts/followeres)*100

fav_ratio = (favourited_counts/followeres)*100

Names = c('Ministry of Health India', 'Times Of India', 'CNN Breaking News', 'BBC Breaking News')



Full_View = data.frame(Names, followeres, retweet_counts, retweet_ratio, favourited_counts, fav_ratio)

###########################################################################################


## Word Cloud







