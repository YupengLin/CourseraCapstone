library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  titlePanel("Coursera Capstone Project"),
  
  sidebarLayout(  sidebarPanel( 
                  textInput("text", label = h3("Please type the sentences here"), 
                            value = "Enter text..."),
                  h4("Hint: "),
                  h5("Please enter space after your typing, so that the algorithm will begin to predict"),
                  h5("For example, if you want to predict what the next word is after 'happy', type 'happy ' ")
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