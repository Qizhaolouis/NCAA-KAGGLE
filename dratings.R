library(readr) #data import
library(stringr) #string manipulation
library(dplyr) #data wrangling
library(reshape) #more string manipulation
library(stringr)
ratings <- read.table("dratings.txt",sep="\n")
ratings.idx <- seq(2,2809-7,8)
Rank=ratings[ratings.idx,]
Team=ratings[ratings.idx+1,]
Rec=ratings[ratings.idx+2,]
Rating=ratings[ratings.idx+3,] %>% as.character() %>% as.numeric() 
Chg=ratings[ratings.idx+4,]
SOS=ratings[ratings.idx+5,]
Standard=ratings[ratings.idx+6,]
Aegis=ratings[ratings.idx+7,]
score <- colsplit(Rec, split="-",
                   names=c("win", "lose")) 
SOS <- substr(SOS,1,5) %>% as.numeric()
Standard <- substr(Standard,1,5) %>% as.numeric()
Aegis <- substr(Aegis,1,5) %>% as.numeric()

rankings.new <- tibble(Team, Rating,SOS, Standard, Aegis, win=score$win, lose=score$lose)
write.csv(rankings.new, "Qidata/dratings.csv",row.names = FALSE)
