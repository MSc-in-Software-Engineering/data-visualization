page_3 <- function(input, output) {
    fluidPage(
        h1("Death and birth rate", style = "font-weight: 600;"),
        p("N/A", style = "font-size:17px;"),
        column(width = 12, tags$hr()),
        h2("Subsection 1", style = "font-weight: 600;"),
        p("N/A", style = "font-size:17px;"),
        fluidRow(
            mainPanel(
                width = 9,
                style = "margin-top: 10px;",
                plotlyOutput("birth_death_rate_india_scatterplot")
            ),
        ),
        column(width = 12, tags$hr()),
        h2("Subsection 2", style = "font-weight: 600;"),
        p("N/A", style = "font-size:17px;"),
        fluidRow(
            mainPanel(
                width = 9,
                style = "margin-top: 10px;",
                plotlyOutput("birth_death_rate_united_states_scatterplot")
            ),
        ),
        column(width = 12, tags$hr()),
    )
}
