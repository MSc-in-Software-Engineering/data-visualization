page_4 <- function(input, output) {
    fluidPage(
        h1("Life expectancy", style = "font-weight: 600;"),
        p("N/A", style = "font-size:17px;"),
        column(width = 12, tags$hr()),
        h2("Subsection 1", style = "font-weight: 600;"),
        fluidRow(
            sidebarPanel(
                width = 3,
                align = "center",
                style = "margin-top: 100px;",
                selectInput("countryStackedBarChartSelectedCountry", "Select a Country", choices = unique(long_data$`Country Name`))
            ),
            mainPanel(
                width = 9,
                style = "margin-top: 10px;",
                plotlyOutput("life_expectancy_stacked_barchart")
            )
        ),
        column(width = 12, tags$hr()),
        h2("Subsection 1", style = "font-weight: 600;"),
        fluidRow(
            sidebarPanel(
                width = 3,
                align = "center",
                style = "margin-top: 100px;",
                selectInput("countryLineChartSelectedCountry", "Select a Country", choices = unique(long_data$`Country Name`))
            ),
            mainPanel(
                width = 9,
                style = "margin-top: 10px;",
                plotlyOutput("gdp_vs_population_growth_linechart")
            )
        )
    )
}
