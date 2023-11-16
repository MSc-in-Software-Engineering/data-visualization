page_1 <- function(input, output) {
    fluidPage(
        h1("Population growth", style = "font-weight: 600;"),
        p("N/A", style = "font-size:17px;"),
        column(width = 12, tags$hr()),
        h2("Highest population growth", style = "font-weight: 600;"),
        p("N/A", style = "font-size:17px;"),
        fluidRow(
            column(8, plotlyOutput("population_growth_increase_barchart")),
            column(
                4,
                sliderInput(
                    "populationGrowthIncreaseBarChartSelectedYear",
                    "Select year (2010 - 2022)",
                    min = 2010,
                    max = 2022,
                    value = 2022,
                )
            ),
        ),
        column(width = 12, tags$hr()),
        h2("Lowest population growth", style = "font-weight: 600;"),
        p("N/A", style = "font-size:17px;"),
        fluidRow(
            column(8, plotlyOutput("population_growth_decrease_barchart")),
            column(
                4,
                sliderInput(
                    "populationGrowthDecreaseBarChartSelectedYear",
                    "Select year (2010 - 2022)",
                    min = 2010,
                    max = 2022,
                    value = 2022,
                )
            ),
        ),
        column(width = 12, tags$hr()),
    )
}
