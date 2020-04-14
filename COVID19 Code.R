

######     COVID19 TWITTER ANAYSIS     #####



## Set Up Twitter API

library(twitteR)
library(ROAuth)

library(base64enc)
library(httr)

api_key = 'XXXXX XXXXX XXXXX'

api_secret = 'XXXXX XXXXX XXXXX'

access_token = 'XXXXX XXXXX XXXXX'

access_token_secret = 'XXXXX XXXXX XXXXX'



## Download file : carcert.pem

download.file(url = "http://curl.haxx.se/ca/cacert.pem", destfile = "cacert.pem")



## Setup Twitter 

setup_twitter_oauth('XXXXX XXXXX XXXXX',
                    'XXXXX XXXXX XXXXX',
                    'XXXXX XXXXX XXXXX',
                    'XXXXX XXXXX XXXXX')



############################################################################

## Libraries

library(dplyr)
library(tidyverse)
library(tidytext)



## Extract Tweets 


## 1. Ministry Of Health India: @MoHFW_INDIA


Health_India = searchTwitter('from:@MoHFW_INDIA', 1000, lang = 'en', 
                             since = '2020-03-12', until = '2020-04-14')


Health_India = do.call('rbind', lapply(Health_India, as.data.frame))

View(Health_India)


## 2. The Times of India; @timesofindia : India News

TOI = searchTwitter('from:@timesofindia', 3000, lang = 'en', 
                    since = '2020-03-12', until = '2020-04-14')


TOI = do.call('rbind', lapply(TOI, as.data.frame))

View(TOI)


## 3. CNN News: @CNN : The USA News


CNN = searchTwitter('from:@CNN', 2000, lang = 'en', 
                    since = '2020-03-12', until = '2020-04-14')


CNN = do.call('rbind', lapply(CNN, as.data.frame))

View(CNN)


## 4. BBC News: @BBCNews : UK News


BBC = searchTwitter('from:@BBCNews', 1000, 
                    since = '2020-03-12', until = '2020-04-14')


BBC = do.call('rbind', lapply(BBC, as.data.frame))

View(BBC)




## ################################################################################

## Tweet Statistices

# Number of Followers: From Official Twitter account

# Ministry of Health India : 1.5 million
# Times Of India: 12.6 million
# CNN News: 47 million
# BBC News: 27.6 million



followeres = c(1500000, 12600000, 47000000, 27600000)


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

Names = c('Ministry of Health India', 'Times Of India', 'CNN News', 'BBC News')



Full_View = data.frame(Names, followeres, retweet_counts, retweet_ratio, favourited_counts, fav_ratio)

write.csv(Full_View, 'Tweet Account Stats.csv')

###########################################################################################
###########################################################################################

## Word Cloud

library(quanteda)


# For Ministry of Health India

health_Dfm = dfm(as.character(Health_India$text), keep = c("#*"), 
            remove = c("amp", "rt", "https", "t.co", "will", "@MoHFW_INDIA", ":", '.', ',', ';', '-', '&','.',
                       remove_numbers = TRUE, 
                       remove_punct = TRUE,
                       stem = TRUE,
                       remove_symbols = TRUE, stopwords("english")))

View(health_Dfm)

topfeatures(health_Dfm, 20)

textplot_wordcloud(health_Dfm, min.freq = 5, max_words = 500, random.order = FALSE, color = c('coral', 'seagreen'))




## FOr Times Of India 


toi_Dfm = dfm(as.character(TOI$text), keep = c("#*"),
                 remove = c("amp", "rt", "https", "t.co", "will", "@timesofindia", ":", '.', ',', ';', '-', '&','.',
                            remove_numbers = TRUE, 
                            remove_punct = TRUE,
                            stem = TRUE,
                            remove_symbols = TRUE, stopwords("english")))

View(toi_Dfm)

topfeatures(toi_Dfm, 20)

textplot_wordcloud(toi_Dfm, min.freq = 5, max_words = 500, random.order = FALSE, color = c('coral', 'seagreen'))



## For CNN News


cnn_Dfm = dfm(as.character(CNN$text), keep = c("#*"),
              remove = c("amp", "rt", "https", "t.co", "will", "@CNN", ":", '.', ',', ';', '-', '&','.', '"',
                         remove_numbers = TRUE, 
                         remove_punct = TRUE,
                         stem = TRUE,
                         remove_symbols = TRUE, stopwords("english")))

View(cnn_Dfm)

topfeatures(cnn_Dfm, 20)

textplot_wordcloud(cnn_Dfm, min.freq = 5, max_words = 500, random.order = FALSE, color = c('coral', 'seagreen'))



## FOr BBC News


bbc_Dfm = dfm(as.character(BBC$text), keep = c("#*"),
              remove = c("amp", "rt", "https", "t.co", "will", "@BBCNews", ":", '.', ',', ';', '-', '&','.', '"', "'",
                         remove_numbers = TRUE, 
                         remove_punct = TRUE,
                         stem = TRUE,
                         remove_symbols = TRUE, stopwords("english")))

View(bbc_Dfm)

topfeatures(bbc_Dfm, 20)

textplot_wordcloud(bbc_Dfm, min.freq = 5, max_words = 500, random.order = FALSE, color = c('coral', 'seagreen'))


############################################################################################################################
#############################################################################################################################



## Sentiment Analysis


## For Ministry of Health India


library(syuzhet)

health_text = as.character(Health_India$text)

#3 Text Cleaning

health_text = gsub("(RT|via)((?:\\b\\w*@\\w+)+)","",Health_India$text)
health_text = gsub("http[^[:blank:]]+","",health_text)
health_text = gsub("@\\w+","",health_text)
health_text = gsub("[[:punct:]]"," ",health_text)
health_text = gsub("[^[:alnum:]]"," ",health_text)

health_text = as.character(health_text)


# Get Sentiment Analysis

health_senti = get_nrc_sentiment(health_text)

# Bar Plot

barplot(sort(colSums(prop.table(health_senti[, 1:10]))), 
         cex.names = 0.7, 
         las = 1, 
         main = "Ministry of Health Tweet Sentiment Analysis", xlab="Percentage", col = 'seagreen')



# **************************************************************


## For The Times Of india

toi_text = as.character(TOI$text)

#3 Text Cleaning

toi_text = gsub("(RT|via)((?:\\b\\w*@\\w+)+)","",TOI$text)
toi_text = gsub("http[^[:blank:]]+","",toi_text)
toi_text = gsub("@\\w+","",toi_text)
toi_text = gsub("[[:punct:]]"," ",toi_text)
toi_text = gsub("[^[:alnum:]]"," ",toi_text)

toi_text = as.character(toi_text)


# Get Sentiment Analysis

toi_senti = get_nrc_sentiment(toi_text)

# Bar Plot

barplot(sort(colSums(prop.table(toi_senti[, 1:10]))), 
        cex.names = 0.7, 
        las = 1, 
        main = "The Times of India Tweet Sentiment Analysis", xlab="Percentage", col = 'coral')



# *********************************************

## For CNN News

cnn_text = as.character(CNN$text)

#3 Text Cleaning

cnn_text = gsub("(RT|via)((?:\\b\\w*@\\w+)+)","",CNN$text)
cnn_text = gsub("http[^[:blank:]]+","",cnn_text)
cnn_text = gsub("@\\w+","",cnn_text)
cnn_text = gsub("[[:punct:]]"," ",cnn_text)
cnn_text = gsub("[^[:alnum:]]"," ",cnn_text)

cnn_text = as.character(cnn_text)


# Get Sentiment Analysis

cnn_senti = get_nrc_sentiment(cnn_text)

# Bar Plot

barplot(sort(colSums(prop.table(cnn_senti[, 1:10]))), 
        cex.names = 0.7, 
        las = 1, 
        main = "CNN News Tweet Sentiment Analysis", xlab="Percentage", col = 'cornflowerblue')



# **********************************

## For BBC News


bbc_text = as.character(BBC$text)

#3 Text Cleaning

bbc_text = gsub("(RT|via)((?:\\b\\w*@\\w+)+)","",BBC$text)
bbc_text = gsub("http[^[:blank:]]+","",bbc_text)
bbc_text = gsub("@\\w+","",bbc_text)
bbc_text = gsub("[[:punct:]]"," ",bbc_text)
bbc_text = gsub("[^[:alnum:]]"," ",bbc_text)

bbc_text = as.character(bbc_text)


# Get Sentiment Analysis

bbc_senti = get_nrc_sentiment(bbc_text)

# Bar Plot

barplot(sort(colSums(prop.table(bbc_senti[, 1:10]))), 
        cex.names = 0.7, 
        las = 1, 
        main = "BBC News Tweet Sentiment Analysis", xlab="Percentage", col = 'darkgoldenrod1')



#################################################################################################################
#################################################################################################################



## Key Topic Modeling Analysis 

## For Ministry of Health India


library(topicmodels)

# We now export to a format that we can run the topic model with

health_dtm =  convert(health_Dfm, to="topicmodels")

# Estimate LDA with K topics

health_lda = LDA(health_dtm, k = 3, method = "Gibbs", 
           control = list(verbose=25L, seed = 123, burnin = 100, iter = 500))


health_term <- terms(health_lda, 10) ## top 10 topics

health_term



# *****************************************



## For The Times of India

# We now export to a format that we can run the topic model with

toi_dtm =  convert(toi_Dfm, to="topicmodels")

# Estimate LDA with K topics

toi_lda = LDA(toi_dtm, k = 3, method = "Gibbs", 
                 control = list(verbose=25L, seed = 123, burnin = 100, iter = 500))


toi_term <- terms(toi_lda, 10) ## top 10 topics

toi_term


# ******************************************



## For CNN News

# We now export to a format that we can run the topic model with

cnn_dtm =  convert(cnn_Dfm, to="topicmodels")

# Estimate LDA with K topics

cnn_lda = LDA(cnn_dtm, k = 3, method = "Gibbs", 
              control = list(verbose=25L, seed = 123, burnin = 100, iter = 500))


cnn_term <- terms(cnn_lda, 10) ## top 10 topics

cnn_term


# *******************************************



## For BBC news

# We now export to a format that we can run the topic model with

bbc_dtm =  convert(bbc_Dfm, to="topicmodels")

# Estimate LDA with K topics

bbc_lda = LDA(bbc_dtm, k = 3, method = "Gibbs", 
              control = list(verbose=25L, seed = 123, burnin = 100, iter = 500))


bbc_term <- terms(bbc_lda, 10) ## top 10 topics

bbc_term



#############################################################################################
#############################################################################################




