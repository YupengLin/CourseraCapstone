library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  titlePanel("Coursera Capstone Project"),
  
  sidebarLayout(  sidebarPanel( 
                  textInput("text", label = h3("Please type the sentences here"), 
                            value = "Enter text...")
                  ),
                mainPanel(
                  h3("The prediction outcome"),
                  h4("option1"),
                  textOutput("text1"),
                  br(),
                  h4("option2"),
                  textOutput("text2"),
                  br(),
                  h4("option3"),
                  textOutput("text3")
                 
                  
                  )
  )
))