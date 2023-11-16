page_2 <- function(input, output) {
    fluidPage(
        h1("GDP growth", style = "font-weight: 600;"),
        p("N/A", style = "font-size:17px;"),
        column(width = 12, tags$hr()),
        h2("Subsection 1", style = "font-weight: 600;"),
        p("N/A", style = "font-size:17px;"),
        fluidRow(
            column(8, plotlyOutput("gdp_growth_rate_map")),
            column(4, sliderInput(
                "gdpGrowthRateMapSelectedYear",
                "Select year (2010 - 2019)",
                min = 2010,
                max = 2019,
                value = 2010,
            ))
        ),
        column(width = 12, tags$hr()),
        h2("Subsection 2", style = "font-weight: 600;"),
        p("N/A", style = "font-size:17px;"),
        fluidRow(
            column(8, plotlyOutput("government_education_expenditure_map")),
            column(4, sliderInput(
                "governmentEducationExpenditureMapSelectedYear",
                "Select year (2010 - 2019)",
                min = 2010,
                max = 2019,
                value = 2010,
            ))
        ),
        column(width = 12, tags$hr()),
    )
}
