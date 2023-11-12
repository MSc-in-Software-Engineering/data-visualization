page_1 <- function(input, output) {
    fluidPage(
        # First bar chart
        h1("Population growth"),
        p("N/A"),
        h2("Annual population growth in percentage"),
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
