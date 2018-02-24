library(dplyr)
library(readr) #data import
library(data.table)
####3
input$team1="G Washington"
input$team2="Duquesne"
input$year=2015
## year input/find data
file <- paste("TeamCompetition/P",input$year,"/Events_",input$year,".csv",sep = "")
data <- read_csv(file)
teams <- read_csv("TeamCompetition/Data/Teams.csv")
## Team name/name input/find teamid 
team1 <- match(tolower(input$team1), tolower(teams$TeamName)) %>% Teams$TeamID[.]
team2 <- match(tolower(input$team2), tolower(teams$TeamName)) %>% Teams$TeamID[.]
## Find their events
fight <- data %>% filter(WTeamID %in% c(team1,team2))%>% 
                  filter(LTeamID %in% c(team1,team2))
n <- length(unique(fight$DayNum))
 
## Info about competitions
if(nrow(fight)==0){
  output$text <- renderText(paste("Team",input$team1,"and","team",input$team2,"never met each other in",input$year))
}else{
  output$text <- renderText(paste("Team",input$team1,"and","team",input$team2,"had",
                  n,"competition(s) in",input$year))
  }

##functions


####Visualization
if(n==1){
  source("singlecompetition.R")
  single(team1,team2,fight)
  }

if(n>1){
  daynum <- unique(fight$DayNum)
  source("TeamCompetition/multicompetition.R")
  multi(team1,team2,fight,n)
  } 

