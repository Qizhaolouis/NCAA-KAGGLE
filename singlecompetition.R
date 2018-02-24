###only one comp
single <- function(team1,team2,fight){
    library(rbokeh)
    vector <- unique(fight[,3:5]) %>% .[,2:3]
    WTeamName <- match(vector$WTeamID, Teams$TeamID) %>% Teams$TeamName[.]
    LTeamName <- match(vector$LTeamID, Teams$TeamID) %>% Teams$TeamName[.]
##events
    fight <- fight %>% filter(WPoints!=0 | LPoints!=0)
    figure(fight,width=600,height=600 ,xlab= "Time in Seconds",ylab="Points",title=paste(WTeamName,"(red) VS ",LTeamName,"(green)",sep="")) %>% 
      ly_points(ElapsedSeconds,WPoints,color="red", hover=c(EventType,WPoints)) %>% 
      ly_points(ElapsedSeconds,LPoints,color="green", hover=c(EventType,LPoints))
}


