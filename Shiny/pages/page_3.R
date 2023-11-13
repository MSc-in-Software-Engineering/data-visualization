page_3 <- function(input, output) {
    fluidPage(
        h1("Page 3"),
        p("N/A"),
        h2("Subsection 1"),
        p("N/A"),
        fluidRow(
            column(8, plotOutput("birth_death_rate_scatterplot"))
        )
    )
}
