library(readr) #data import
library(stringr) #string manipulation
library(dplyr) #data wrangling
library(reshape) #more string manipulation
ordinals <- read_csv("MasseyOrdinals.csv")

## before year
year <- 2014
players <- read_csv(P)

##team rank mean in the past years
rank.past <- ordinals %>% 
  filter(Season<(year-1)) %>% 
  group_by(TeamID) %>% 
  summarise(mean = mean(OrdinalRank))
##team rank mean in the year before the prediction year
rank.new <- ordinals %>% 
  filter(Season==year-1) %>% 
  group_by(TeamID) %>% 
  summarise(mean = mean(OrdinalRank))
##join the two list and get the weighted Team rank.
rank.hist <- full_join(rank.past, rank.new, by="TeamID")  
weighted.rank <- apply(rank.hist[,2:3],1,function(x)mean(x[!is.na(x)])) %>% 
  tibble(TeamID=rank.hist$TeamID,rank=.)


