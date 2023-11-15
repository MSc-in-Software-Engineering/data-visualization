library(shiny)

source("plots/barcharts/population_growth.R")
source("plots/maps/gdp_growth_rate.R")
source("plots/maps/government_education_expenditure.R")
source("plots/scatterplots/birth_death_rate_scatterplot.R")

server <- function(input, output, session) {
    output$population_growth_barchart <- renderPlotly({population_growth_barchart(input$populationGrowthBarChartSelectedYear)})
    output$gdp_growth_rate_map <- renderPlotly({gdp_growth_rate_map(input$gdpGrowthRateMapSelectedYear)})
    output$government_education_expenditure_map <- renderPlotly({government_education_expenditure_map(input$governmentEducationExpenditureMapSelectedYear)})
    output$birth_death_rate_india_scatterplot <- renderPlotly({birth_death_rate_india_scatterplot()})
    output$birth_death_rate_united_states_scatterplot <- renderPlotly(birth_death_rate_united_states_scatterplot())
}
