library(shiny)

source("plots/barcharts/population_growth.R")

server <- function(input, output, session) {
    output$population_growth_barchart <- renderPlot({population_growth_barchart(input$populationGrowthBarChartSelectedYear)}, bg = "transparent")
}
