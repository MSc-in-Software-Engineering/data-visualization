page_2 <- function(input, output) {
    fluidPage(
        h1("Page 2"),
        p("N/A"),
        h2("Subsection 1"),
        p("N/A"),
        fluidRow(
            column(8, plotOutput("gdp_growth_rate_map"))
        ),
        h2("Subsection 2"),
        p("N/A"),
        fluidRow(
            column(8, plotOutput("government_education_expenditure_map"))
        )
    )
}
