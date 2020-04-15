# NLP-COVID19-Tweet-PART-2
In this COVID19 twitter study, we have conducted NLP and text analysis from various official twitter account from Indian Health Ministry and News Media tweeter official account to identify trend and sentiment of tweets in the given period. 


## Table of Contents

- [Objective](#objective)
- [Data Collection](#data-collection)
- [Tweet Statistics](#tweet-statisitcs)
- [Word Cloud](#word-cloud)
- [Sentimet Analysis](#sentiment-analysis)
- [Key Topic Modeling](#key-topic-modeling)
- [Conclusion](#conclusion)

## Objective
The objective of the study is to do the analysis on official twitter accounts of Ministry of Health India, The Times of India, CNN News and BBC News for trend and sentiment analysis regarding COVID19. 

<br>

#### Note: 
The Study includes tweets from the day COVID19 declared a pandemic by @WHO till 14th April 2020 (a month)

<br>

## Data Collection

For data collection, we used a Twitter website. We identified targeted official twitter accounts like the Ministry of Health India, The Times of India, CNN Breaking News and BBC Breaking News. 

With the help to twitter AIP, we started extracting the tweets from the accounts since = '2020-03-12', until = '2020-04-14'. 

Official Accounts tweets from : 
1. Ministry Of Health India: @MoHFW_INDIA

2. The Times of India; @timesofindia : India News

3. CNN News: @CNN : The USA News

4. BBC News: @BBCNews : UK New

```
Health_India = searchTwitter('from:@MoHFW_INDIA', 1000, lang = 'en', 
                             since = '2020-03-12', until = '2020-04-14')


Health_India = do.call('rbind', lapply(Health_India, as.data.frame))

```

<br>

## Tweet Statistics

Tweet statistics is interesting, it tells which account stands where in terms of tweets.

Number of Followers: From Official Twitter account

The Ministry of Health India: 1.5 million
The Times Of India: 12.6 million
CNN News: 47 million
BBC News: 27.6 million

For the analysis we extracted the information, like, Retweet Counts, Tweet Favourited Count, retweets to followers count ratios, and favorited to followers ratios.

```
Health_India_retweet = sum(Health_India$retweetCount)

Health_India_fav = sum(Health_India$favoriteCount)

retweet_ratio = (retweet_counts/followeres)*100

fav_ratio = (favourited_counts/followeres)*100
```

Results:

<p align="left"><img width=77% src=https://user-images.githubusercontent.com/44467789/79304260-85d7bf00-7f0e-11ea-8c94-84314a3589cc.png>
  

As we can see in the above table, CNN News is having the highest followers across 4 twitter accounts. However, despite the least followers The Ministry of Health India has the highest retweet ratio with 6.9. That counts @MoHFW_INDIA 's tweets are retweeted and also has a good amount of favorite ratio with 2.76. 

We have also observed despite being more than 27 million followers to BBC News, users are not paying attention to BBC News tweets. 

<br>

## Word Cloud


  




