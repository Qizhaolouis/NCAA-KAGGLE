#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(
  function(input, output){
  
   output$picture <- renderRbokeh({
        file <- paste("P",input$year,"/Events_",input$year,".csv",sep = "")
        data <- read_csv(file)
        teams <- read_csv("Data/Teams.csv")
        ## Team name/name input/find teamid 
        team1 <- match(tolower(input$team1), tolower(teams$TeamName)) %>% Teams$TeamID[.]
        team2 <- match(tolower(input$team2), tolower(teams$TeamName)) %>% Teams$TeamID[.]
        ## Find their events
        fight <- data %>% filter(WTeamID %in% c(team1,team2))%>% 
          filter(LTeamID %in% c(team1,team2))
        if(nrow(fight)==0){
          output$text <- renderText(paste("Team",input$team1,"and","team",input$team2,"never met each other in",input$year))
        }else{
          output$text <- renderText(paste("Team",input$team1,"and","team",input$team2,"had",
                                          n,"competition(s) in",input$year))
        }
        
        output$table <- renderTable({
          temp <- data[!duplicated(data[,4:5]),3:5]%>% filter(WTeamID %in% c(team1,team2) | LTeamID %in% c(team1,team2))
          temp["WTeamID"] <- temp["WTeamID"] %>% apply(1,function(x){
              x=match(x,Teams$TeamID) %>% Teams$TeamName[.]
              }) 
          temp["LTeamID"] <- temp["LTeamID"] %>% apply(1,function(x){
            x=match(x,Teams$TeamID) %>% Teams$TeamName[.]
          }) 
          temp
        })
        
        n <- length(unique(fight$DayNum))
        if(n==1){
          source("singlecompetition.R")
          single(team1,team2,fight)
        }else{
          daynum <- unique(fight$DayNum)
          source("multicompetition.R")
          multi(team1,team2,fight,n)
        } 
        
    
  })
  
}
)
