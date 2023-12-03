library(shiny)
library(shinydashboard)
library(shinyjs)
library(readxl)
library(ggplot2)
library(rsconnect)

# Pages
source("./pages/introduction.r")
source("./pages/page_1.r")
source("./pages/page_2.r")
source("./pages/page_3.r")
source("./pages/page_4.r")
source("./pages/conclusion.r")
source("./pages/project_report.r")
source("plots/barcharts/population_growth_increase.r")
source("plots/barcharts/population_growth_decrease.r")
source("plots/barcharts/gdp_growth_top_low.r")
source("plots/maps/gdp_growth_rate.r")
source("plots/maps/government_education_expenditure.r")
source("plots/scatterplots/birth_death_rate_scatterplot.r")
source("plots/linecharts/Mortality.r")
source("plots/linecharts/BirthAndDeathRateLineChart.r")
source("plots/groupedbarchart/life_expectancy_grouped_barchart.r")
library(profmem)

# User interface
ui <- dashboardPage(

  # Header
  dashboardHeader(title = "World Development Indicators", titleWidth = 300),

  # Sidebar
  dashboardSidebar(sidebarMenu(
    menuItem("1. Introduction", tabName = "introduction"),
    menuItem("2. Population growth", tabName = "pageOne"),
    menuItem("3. GDP growth", tabName = "pageTwo"),
    menuItem("4. Death and birth rate", tabName = "pageThree"),
    menuItem("5. Life expectancy", tabName = "pageFour"),
    menuItem("6. Conclusion", tabName = "conclusion"),
    menuItem("7. Download project report", tabName = "projectReport")
  )),

  # Body
  dashboardBody(
    includeCSS("styles.css"),
    # Tabs
    tabItems(
      tabItem("introduction", introduction()),
      tabItem("pageOne", page_1()),
      tabItem("pageTwo", page_2()),
      tabItem("pageThree", page_3()),
      tabItem("pageFour", page_4()),
      tabItem("conclusion", conclusion()),
      tabItem("projectReport", project_report())
    )
  )
)

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
  output$death_rate_line_chart <- renderPlotly(death_rate_line_chart())
  output$birth_rate_line_chart <- renderPlotly(birth_rate_line_chart())
  output$downloadReport <- downloadHandler(
    filename = "report.pdf",
    content = function(file) {
      file.copy("www/report.pdf", file)
    }
  )
}

shinyApp(ui, server)