page_2 <- function(input, output) {
    fluidPage(
        h1("Page 2"),
        p("N/A"),
        h2("Subsection 1"),
        p("N/A"),
        fluidRow(
            column(8, plotlyOutput("gdp_growth_rate_map")),
            column(4, sliderInput(
                "gdpGrowthRateMapSelectedYear",
                "Choose a year to investigate",
                min = 2010,
                max = 2019,
                value = 2010,
            ))
        ),
        h2("Subsection 2"),
        p("N/A"),
        fluidRow(
            column(8, plotlyOutput("government_education_expenditure_map")),
            column(4, sliderInput(
                "governmentEducationExpenditureMapSelectedYear",
                "Choose a year to investigate",
                min = 2010,
                max = 2019,
                value = 2010,
            ))
        )
    )
}
