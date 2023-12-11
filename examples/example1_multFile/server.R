function(input, output){
    output$message = renderText({input$text_input_example})
}