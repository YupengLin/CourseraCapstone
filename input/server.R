source("infer.R")
library(data.table)
shinyServer(function(input, output) {
  
   textInput <- reactive({
     if(substring(input$text, nchar(input$text), nchar(input$text)) == " ")
     infer(input$text)
  })
 
  
  output$text1 <- renderText({
     textInput()[1]
     
   })
   output$text2 <- renderText({
      textInput()[2]
       
   })
   output$text3 <- renderText({
      textInput()[3]
      
   })

  
})
