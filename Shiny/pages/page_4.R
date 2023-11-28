page_4 <- function(input, output) {
    fluidPage(
        h1("Life expectancy", style = "font-weight: 600;"),
        p("Within these last sections, the last  proposed research question is to be analyzed and answered upon which states “What gender has the highest life expectancy generally in the years past?”.", style = "font-size:17px;"),
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
                plotlyOutput("life_expectancy_grouped_barchart")
            )
        ),
        column(width = 12, tags$hr()),
        h2("Mortality from prominent diseases in China", style = "font-weight: 600;"),
        p("The following animated graph shows the mortality from cardiovascular diseases (CVDs), cancer, diabetes or chronic respiratory diseases (CRDs) between the ages of 30 and 70 for both male and female in China. It indicates that there is a higher mortality rate for males in constrast to females which could assume that males have lower life expectancy than females.", style = "font-size:17px;"),
        fluidRow(
            column(width = 3),
            mainPanel(
                img(src='AnimatedMortality.gif', align = "left", height=550,width=800),
            )
        ),
        column(width = 12, tags$hr()),
        h2("Mortality from prominent diseases in other countries", style = "font-weight: 600;"),
        p("To accomodate the animation as well as the statement for mortality rates, further examination can be conducted on other countries.", style = "font-size:17px;"),
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
                plotlyOutput("mortality_linechart")
            )
        )
    )
}
