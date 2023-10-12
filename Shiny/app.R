library(shiny)

ui<- fluidPage(
  titlePanel("My First Shiny App"),
  textInput(inputId = "text", label = "Type in here"),
  textOutput(outputId = "print_text")
)

server<-function(input, output) {
  output$print_text<-renderText(input$text)
}

shinyApp(ui=ui, server=server)