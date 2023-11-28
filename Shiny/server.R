library(shiny)

source("plots/barcharts/population_growth_increase.R")
source("plots/barcharts/population_growth_decrease.R")
source("plots/barcharts/gdp_growth_top_low.R")
source("plots/maps/gdp_growth_rate.R")
source("plots/maps/government_education_expenditure.R")
source("plots/scatterplots/birth_death_rate_scatterplot.R")
source("plots/linecharts/Mortality.R")
source("plots/groupedbarchart/life_expectancy_grouped_barchart.R")

server <- function(input, output, session) {
    output$population_growth_increase_barchart <- renderPlotly({population_growth_increase_barchart(input$populationGrowthIncreaseBarChartSelectedYear)})
    output$population_growth_decrease_barchart <- renderPlotly({population_growth_decrease_barchart(input$populationGrowthDecreaseBarChartSelectedYear)})
    output$gdp_growth_top_barchart <- renderPlotly({gdp_growth_top_barchart(input$gdpHighGrowthBarChartSelectedYear)})
    output$gdp_growth_low_barchart <- renderPlotly({gdp_growth_low_barchart(input$gdpLowGrowthBarChartSelectedYear)})
    output$gdp_growth_rate_map <- renderPlotly({gdp_growth_rate_map(input$gdpGrowthRateMapSelectedYear)})
    output$government_education_expenditure_map <- renderPlotly({government_education_expenditure_map(input$governmentEducationExpenditureMapSelectedYear)})
    output$birth_death_rate_scatterplot <- renderPlotly(birth_death_rate_scatterplot(input$countryScatterPlotSelectedCountry))
    output$mortality_linechart <- renderPlotly(mortality_linechart(input$countryLineChartSelectedCountry))
    output$life_expectancy_grouped_barchart <- renderPlotly(life_expectancy_grouped_barchart(input$countryStackedBarChartSelectedCountry))
    output$downloadReport <- downloadHandler(
    filename = "report.pdf",
    content = function(file) {
      file.copy("www/report.pdf", file)
    }
  )
}
