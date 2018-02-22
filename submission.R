library(readr) #data import
library(stringr) #string manipulation
library(dplyr) #data wrangling
library(reshape) #more string manipulation
##the submission
submission <- read.csv("SampleSubmissionStage1.csv")
submission.new <- c("Season", "FirstTeam", "SecondTeam") %>% 
  colsplit(submission[,1], split="_",names= .) %>% 
  as_tibble
###four years
submission14 <- submission.new %>% filter(Season==2014)
submission15 <- submission.new %>% filter(Season==2015)
submission16 <- submission.new %>% filter(Season==2016)
submission17 <- submission.new %>% filter(Season==2017)
