page_4 <- function(input, output) {
    fluidPage(
        h1("Life expectancy", style = "font-weight: 600;"),
        p("Within these last sections, the last  proposed research question is to be analyzed and answered upon which states “What gender has the highest life expectancy generally in the years past?”. Additionally, within these sections, the research questions proposed in the (Population Growth) topic and (GDP growth) will be revisited.", style = "font-size:17px;"),
        column(width = 12, tags$hr()),
        h2("Average life expectancy at birth for male and female", style = "font-weight: 600;"),
        p("When averaging the life expectancy at birth for both male and female respectively, it is striking to see that in every country provided within the research, females generally have a higher life expectancy at birth in contrast to males. This goes for every region in the world at every year from 2010 to 2021. Utilize the country name dropdown to swap country datasets.", style = "font-size:17px;"),
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
        h2("Subsection 2", style = "font-weight: 600;"),
        p("N/A", style = "font-size:17px;"),
        fluidRow(
            column(width = 3),
            mainPanel(
                img(src='AnimatedGDPvsPopulationGrowth.gif', align = "left", height=550,width=800),
            )
        ),
        column(width = 12, tags$hr()),
        h2("Subsection 3", style = "font-weight: 600;"),
        p("N/A", style = "font-size:17px;"),
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
