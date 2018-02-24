#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("NCAA with Qi"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       textInput("team1", label="First Team:", value = "Valparaiso"),
       textInput("team2", label="Second Team:", value = "Arizona"),
       sliderInput("year",
                   "The Year:",
                   min = 2010,
                   max = 2017,
                   value = 2012)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       textOutput("text"),
       rbokehOutput("picture"),
       tableOutput("table")
    )
  )
))
