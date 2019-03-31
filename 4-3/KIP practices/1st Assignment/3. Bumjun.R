library(readr)
library(KoNLP)
library(dplyr)
library(stringr)
library(wordcloud)
library(RColorBrewer)
useNIADic()

setwd("C:/Users/Seongsu Park/Desktop")
getwd()
txt <- readLines("Bumjun.txt", encoding="UTF-8")
head(txt)

nouns <- extractNoun(txt)
wordcount <- table(unlist(nouns))
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
head(df_word)

df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)

df_word <- filter(df_word, nchar(word) >= 2)

top_20 <- df_word %>%
  arrange(desc(freq)) %>%
  head(20)

pal <- brewer.pal(8,"Dark2")  # Dark2 색상 목록에서 8개 색상 추출

wordcloud(words = df_word$word,  # 단어
          freq = df_word$freq,   # 빈도
          min.freq = 5,          # 최소 단어 빈도
          max.words = 1000,       # 표현 단어 수
          random.order = F,      # 고빈도 단어 중앙 배치
          rot.per = .1,          # 회전 단어 비율
          scale = c(3, 1.5),     # 단어 크기 범위
          colors = pal)          # 색깔 목록

# https://rstudio-pubs-static.s3.amazonaws.com/424287_ae9bfc2611ef4b8cad31fcce00337923.html 참조


