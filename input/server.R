source("infer.R")
shinyServer(function(input, output) {
   output$text1 <- renderText({
     infer(input$text, 1)
   })
   output$text2 <- renderText({
     infer(input$text, 2)
   })
   output$text3 <- renderText({
     infer(input$text, 3)
   })

  
})
