page_1 <- function(input, output) {
    fluidPage(
        h1("Population growth", style = "font-weight: 600;"),
        p("N/A", style = "font-size:17px;"),
        column(width = 12, tags$hr()),
        h2("Highest population growth", style = "font-weight: 600;"),
        p("N/A", style = "font-size:17px;"),
        fluidRow(
            sidebarPanel(
                width = 3,
                align = "center",
                style = "margin-top: 100px;",
                sliderInput(
                    "populationGrowthIncreaseBarChartSelectedYear",
                    "Select year (2010 - 2022)",
                    min = 2010,
                    max = 2022,
                    value = 2022,
                )
            ),
            mainPanel(
                width = 9,
                style = "margin-top: 10px;",
                plotlyOutput("population_growth_increase_barchart")
            ),
        ),
        column(width = 12, tags$hr()),
        h2("Lowest population growth", style = "font-weight: 600;"),
        p("N/A", style = "font-size:17px;"),
        fluidRow(
            sidebarPanel(
                width = 3,
                align = "center",
                style = "margin-top: 100px;",
                sliderInput(
                    "populationGrowthDecreaseBarChartSelectedYear",
                    "Select year (2010 - 2022)",
                    min = 2010,
                    max = 2022,
                    value = 2022,
                )
            ),
            mainPanel(
                width = 9,
                style = "margin-top: 10px;",
                plotlyOutput("population_growth_decrease_barchart")
            ),
        ),
        column(width = 12, tags$hr()),
    )
}
