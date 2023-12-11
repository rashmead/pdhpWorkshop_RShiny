
library(shiny)

myUI = fluidPage(
    
    "Hello World",
    textInput("text_input_example", label = "Type a Message", value = "Hello UofM"),
    verbatimTextOutput("message")
)

myServer = function(input, output){
    output$message = renderText({input$text_input_example})
}

shinyApp(ui = myUI, server = myServer)
