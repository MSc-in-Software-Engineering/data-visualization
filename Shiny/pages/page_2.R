page_2 <- function(input, output) {
  fluidPage(
    h1("GDP growth", style = "font-weight: 600;"),
    p("N/A", style = "font-size:17px;"),
    column(width = 12, tags$hr()),
    h2("Subsection 1", style = "font-weight: 600;"),
    p("N/A", style = "font-size:17px;"),
    fluidRow(
      sidebarPanel(
        width = 3,
        align = "center",
        style = "margin-top: 100px;",
        sliderInput(
          "gdpGrowthRateMapSelectedYear",
          "Select year (2010 - 2022)",
          min = 2010,
          max = 2022,
          value = 2022,
        )
      ),
      mainPanel(
        width = 9,
        style = "margin-top: 10px;",
        plotlyOutput("gdp_growth_rate_map")
      ),
    ),
    column(width = 12, tags$hr()),
    h2("Subsection 2", style = "font-weight: 600;"),
    p("N/A", style = "font-size:17px;"),
    fluidRow(
      sidebarPanel(
        width = 3,
        align = "center",
        style = "margin-top: 100px;",
        sliderInput(
          "gdpHighGrowthBarChartSelectedYear",
          "Choose a year to investigate",
          min = 2010,
          max = 2022,
          value = 2022,
        )
      ),
      mainPanel(
        width = 9,
        style = "margin-top: 10px;",
        plotlyOutput("gdp_growth_top_barchart")
      )
    ),
    column(width = 12, tags$hr()),
    h2("Subsection 3", style = "font-weight: 600;"),
    p("N/A", style = "font-size:17px;"),
    fluidRow(
      sidebarPanel(
        width = 3,
        align = "center",
        style = "margin-top: 100px;",
        sliderInput(
          "gdpLowGrowthBarChartSelectedYear",
          "Choose a year to investigate",
          min = 2010,
          max = 2022,
          value = 2022,
        )
      ),
      mainPanel(
        width = 9,
        style = "margin-top: 10px;",
        plotlyOutput("gdp_growth_low_barchart")
      )
    ),
    h2("Subsection 4", style = "font-weight: 600;"),
    p("N/A"),
    fluidRow(
      sidebarPanel(
        width = 3,
        align = "center",
        style = "margin-top: 100px;",
        sliderInput(
          "governmentEducationExpenditureMapSelectedYear",
          "Select year (2010 - 2022)",
          min = 2010,
          max = 2022,
          value = 2022,
        )
      ),
      mainPanel(
        width = 9,
        style = "margin-top: 10px;",
        plotlyOutput("government_education_expenditure_map")
      )
    ),
    column(width = 12, tags$hr()),
  )
}
