# NLP-COVID19-Tweet-PART-2
In this COVID19 twitter study, we have conducted NLP and text analysis from various official twitter account from Indian Health Ministry and News Media tweeter official account to identify trend and sentiment of tweets in the given period. 


## Table of Contents

- [Objective](#objective)
- [Data Collection](#data-collection)
- [Tweet Statistics](#tweet-statisitcs)
- [Word Cloud](#word-cloud)
- [Sentiment Analysis](#sentiment-analysis)
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
- Ministry Of Health India: @MoHFW_INDIA

- The Times of India; @timesofindia : India News

- CNN News: @CNN : The USA News

- BBC News: @BBCNews : UK New

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

For word cloud we used quantda library. Ans after some text cleaning, we found the folllwoing word clouds for individual twitter accounts. 

```
health_Dfm = dfm(as.character(Health_India$text), keep = c("#*"), 
            remove = c("amp", "rt", "https", "t.co", "will", "@MoHFW_INDIA", ":", '.', ',', ';', '-', '&','.',
                       remove_numbers = TRUE, 
                       remove_punct = TRUE,
                       stem = TRUE,
                       remove_symbols = TRUE, stopwords("english")))
```

### For The Ministry of Health India:

As we can see most of the tweets from The Ministry of Health account were focused on positive and to motivate Indian people 'indiafightscorona'. The second most highlighted word we see is for '@pib_india' this official twitter account of Press Information Bureau  : Info: Press Information Bureau. Nodal agency for communicating to media on behalf of  #Government of #India. This also indicated, all the official updates were passed to the Press Information Bureau via tweets. 

<p align="center"><img width=77% src=https://user-images.githubusercontent.com/44467789/79325508-e7a82100-7f2e-11ea-9141-8e33509821e1.png>

<br>

### For The Times Of India News

As we can see in TOI's tweets, which are more focused on lockdown and cases. However, they also supported homestay during lockdown with hashtag '#cautionyespanicno'.

<p align="center"><img width=77% src=https://user-images.githubusercontent.com/44467789/79325986-bda32e80-7f2f-11ea-8e78-519f07a33c3a.png>
  
<br>

### For CNN News

FOr CNN twitter account, new your, coronavirus, along with president trump. By close look, we can also observe that CNN tweets frequently used 'pandemic' and 'died' words. One more observation is that CNN tweets do not carry hashtags! 


<p align="center"><img width=77% src=https://user-images.githubusercontent.com/44467789/79326241-25597980-7f30-11ea-9b27-264e34b9db45.png>
  
<br>

### FOr BBC news

From the following word cloud, apart from coronavirus, we also observed tweets were also more on PM Boris Johnson. Apart from this BBC also seen running trends like '#tomorrowpapertoday' and '#bbcpapers'. 

<p align="center"><img width=96% src=https://user-images.githubusercontent.com/44467789/79326606-be889000-7f30-11ea-8eed-caad26c0318d.png>
  
  
<br>

Word cloud gives us some hint words tweets trend and sentiment and language. However, for text sentiment analysis we study in detail towards these tweets sent from the individual twitter accounts. 


<br>

## Sentiment Analysis

For sentiment analysis, first, we clean the text and applied library(syuzhet) 

```
#3 Text Cleaning

health_text = gsub("(RT|via)((?:\\b\\w*@\\w+)+)","",Health_India$text)
health_text = gsub("http[^[:blank:]]+","",health_text)
health_text = gsub("@\\w+","",health_text)
health_text = gsub("[[:punct:]]"," ",health_text)
health_text = gsub("[^[:alnum:]]"," ",health_text)

health_text = as.character(health_text)
```

Sentiment analysis we analyzed in the bar plot, as follows, 

#### 1. The Health Ministry of India Tweets Sentiment

In the following sentiment bar plot, we can see that positive and trust is more than 20%. However, negativity and fear is still accounting at a 10% level, these levels can be brought down by 7-5%. 

<p align="center"><img width=77% src=https://user-images.githubusercontent.com/44467789/79531107-f574b800-808e-11ea-9961-04fa28feb27b.png>
  
<br>

#### 2. The Times of India Tweets Sentiment

In the following sentiment bar plot of TOI we can see that tweets from this account is also spreading the good amount of negativity and fear. However, positive tweets are higher, but, in the crucial times like COVID, media should control on fear and negativity on Twitter. 

<p align="center"><img width=77% src=https://user-images.githubusercontent.com/44467789/79531171-310f8200-808f-11ea-94ee-26cbaaa4e21a.png>
  
<br>

#### 3. CNN News Tweets Sentiment

In the following sentiment analysis bar plot, we can see that two big bars represent positivity and trust 

<p align="center"><img width=77% src=https://user-images.githubusercontent.com/44467789/79531222-53a19b00-808f-11ea-97c2-f566d177e6b8.png>
  
<br>

#### 4. BBC News Tweets Sentiment

IN the following bar chart we can see that, BBC tweets are higher towards fear and negativity compare to other two media accounts tweets. However, the positive tweets bar is more than 20%. 

<p align="center"><img width=77% src=https://user-images.githubusercontent.com/44467789/79531287-8350a300-808f-11ea-86fb-b0a0a4bf2e3d.png>
  
<br>

As we can see analysis of the sentiments of the tweets from individual account tweets, we can say that all the accounts are high on positivity. However, we believe still there is room to follow the right words and bring down negativity and fear in these crucial times. 


<br>

## Key Topic Modeling

FOr topic modeling on tweets from individual accounts, we identified three topics trends from tweets. 

#### 1. The Health Ministry of India Tweets Key Topics 

```
> health_term
      Topic 1      Topic 2           Topic 3             
 [1,] "@pib_india" "#covid19"        "#indiafightscorona"
 [2,] "states"     "live"            "@pib_india"        
 [3,] "home"       "media"           "@covidnewsbymib"   
 [4,] "know"       "#covid2019"      "can"               
 [5,] "/"          "cases"           "#lockdown21"       
 [6,] "management" "@drharshvardhan" "updates"           
 [7,] "help"       "country"         "health"            
 [8,] "t"          "medical"         "➡"                 
 [9,] "today"      "briefing"        ")"                 
[10,] "important"  "india"           "please"  
```

As we see, the first topic is more inclined towards home, states, and management. The second topic is on COVID and media.  The third topic is on lockdown and health. This analysis tells us how the tweets are focused on from lockdown to health awareness on COVID virus. 

<br>

#### 2. The Times of India Tweets Key Topics 

```
> toi_term
      Topic 1                Topic 2    Topic 3             
 [1,] "cases"                "'"        "read"              
 [2,] "coronavirus"          "via"      "#cautionyespanicno"
 [3,] "positive"             "covid-19" "india"             
 [4,] "#covid19"             "lockdown" "@toisports"        
 [5,] "("                    "pm"       "people"            
 [6,] ")"                    "says"     "government"        
 [7,] "#coronavirusoutbreak" "can"      "april"             
 [8,] "new"                  "govt"     "pandemic"          
 [9,] "total"                "masks"    "/"                 
[10,] "state"                "home"     "till"   
```

As we can see in TOI media tweets the first topic is towards covid19 cases, the second topic is on lockdown and government actions on states. The third topic is on-trend #cautionyespanicno, which also extends for people and government on covid19 awareness. 

<br>

#### 3. CNN News Tweets Key Topics 

```
> cnn_term
      Topic 1    Topic 2     Topic 3      
 [1,] "new"      "says"      "coronavirus"
 [2,] "people"   "health"    "president"  
 [3,] "us"       "one"       "pandemic"   
 [4,] "said"     "workers"   "trump"      
 [5,] "gov"      "according" "died"       
 [6,] "york"     "home"      "dr"         
 [7,] "state"    "americans" "cases"      
 [8,] "covid-19" "care"      "world"      
 [9,] "week"     "time"      "department" 
[10,] "united"   "order"     "two"     
```

As we can see on the CNN media topics analysis, unless India Topic 1 and 2 are on people of new york (as NYC registered highest cases) and health workers. Where topic 3 is fully covered with President Donald Trump and World. 


<br>

#### 4. BBC News Tweets Key Topics 

```
> bbc_term
      Topic 1     Topic 2                 Topic 3       
 [1,] "?"         "("                     "coronavirus" 
 [2,] "nhs"       "via"                   "says"        
 [3,] "hospital"  ")"                     "uk"          
 [4,] "@bbcsport" "lockdown"              "minister"    
 [5,] "people"    "care"                  "@bbcpolitics"
 [6,] "first"     "boris"                 "secretary"   
 [7,] "us"        "#tomorrowspaperstoday" "prime"       
 [8,] "staff"     "#bbcpapers"            "@bbcworld"   
 [9,] "died"      "johnson"               "new"         
[10,] "/"         "intensive"             "health"    
```

In the BBC News tweets topics, Topic 1 and 2 are focused on hospitals to people to staff and PM Boris Johnson to care. Topic 3 is focused on coronavirus and news to the UK. 

<br>

## Conclusion

As we studied from the Tweets from the 4 official twitter accounts, one health minister Indian and three media accounts from 12th March 2020 to 14th April 2020. We can conclude the trend based on the study. CNN has the highest ratio of retweets and favoutited_count, which says, CCN has good influence with the highest numbers of followers amongst the three media twitter accounts. 

Based on the Word Cloud, all tweets were focused on coronavirus. Regarding updates on COVID, The Ministry of Health India also putPress Information Bureau (@pib_india) in the loop. 

All the four accounts tweets sentiment were positive; However, The Time of India sentiment analysis says that tweets have less trust than negativity. 

An individual recommendation has been given in a particular section.


<br>

