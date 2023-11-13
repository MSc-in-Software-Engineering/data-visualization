page_1 <- function(input, output) {
    fluidPage(
        h1("Page 1"),
        p("N/A"),
        h2("Subsection 1"),
        p("N/A"),
        fluidRow(
            column(8, plotOutput("population_growth_barchart")),
            column(
                4,
                sliderInput(
                    "populationGrowthBarChartSelectedYear",
                    "Choose a year to investigate",
                    min = 2010,
                    max = 2019,
                    value = 2010,
                )
            ),
        )
    )
}
