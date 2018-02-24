###if more than one comp
multi <- function(team1,team2,fight,n) {
   library(rbokeh)
   fight <- fight %>% filter(WPoints!=0 | LPoints!=0)
   daynum <- unique(fight$DayNum)
   vector <- unique(fight[,3:5]) %>% .[,2:3]
   
   team1 <- match(vector$WTeamID[1], Teams$TeamID) %>% Teams[.,1:2]
   team2 <- match(vector$LTeamID[1], Teams$TeamID) %>% Teams[.,1:2]
  
   team1
   team2


   xlabel <- paste(team1[2],"(green) VS ",team2[2],"(red) seconds",sep="")
 
   idx <- split(1:nrow(fight),fight$DayNum)
   figs <- list()
   for(i in 1:n){
      if(vector$WTeamID[i]==team1$TeamID){c1="green"
      c2="red"}else{c2="green"
      c1="red"}
      figs[[i]] <- figure(fight[unlist(idx[i]),], width=600,height=600, xlab= xlabel,ylab="Points") %>% 
         ly_points(ElapsedSeconds,WPoints,color=c1  , hover=c(EventType,WPoints)) %>% 
         ly_points(ElapsedSeconds,LPoints,color=c2  , hover=c(EventType,LPoints))
    }
   grid_plot(figs,nrow=3)
} 


 
 
 