page_1 <- function(input, output) {
    fluidPage(
        h1("Population growth", style = "font-weight: 600;"),
        p('Within these subsequent sections, the first proposed research question is to be analyzed and answered upon which states “How has the global population growth progressed throughout the years?”.', style = "font-size:17px;"),
        column(width = 12, tags$hr()),
        h2("Highest population growth", style = "font-weight: 600;"),
        p("To deduct how the global population growth have progressed throughout the years, the first aspect to be analyzed is the countries with highest population growth. Results show that its primarily countries within the African region which proposes highest population growth throughout the years, while there is no clear indication what specific region has the lowest population growth in the years past.", style = "font-size:17px;"),
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
                    sep = "",
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
        p("Consequently, to clarify how the global population growth have progressed throughout the years, the second aspect to be analyzed is the countries with the lowest population growth. Remarkably due to the Russian/Ukrainian war in Europe, Ukraine had around (-14.19%) decrease in population growth which is above the double of what Bulgaria had of (-6.19%); however, if you go further back in time there is no clear indication of what region concurrently have the most decrease in population growth over the years. There is some outliers within certain years that goes again e.g., Marshall Islands, Libya, and Lebanon.", style = "font-size:17px;"),
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
                    sep = "",
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
