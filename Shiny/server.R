library(shiny)

source("plots/barcharts/population_growth.R")
source("plots/maps/gdp_growth_rate.R")
source("plots/maps/government_education_expenditure.R")
source("plots/scatterplots/birth_death_rate_scatterplot.R")

server <- function(input, output, session) {
    output$population_growth_barchart <- renderPlot({population_growth_barchart(input$populationGrowthBarChartSelectedYear)}, bg = "transparent")
    output$gdp_growth_rate_map <- renderPlot({gdp_growth_rate_map()}, bg = "transparent")
    output$government_education_expenditure_map <- renderPlot({government_education_expenditure_map()}, bg = "transparent")
    output$birth_death_rate_india_scatterplot <- renderPlot({birth_death_rate_india_scatterplot()}, bg = "transparent")
    output$birth_death_rate_united_states_scatterplot <- renderPlot({birth_death_rate_united_states_scatterplot()}, bg = "transparent")
}
