page_3 <- function(input, output) {
    fluidPage(
        h1("Death and birth rate", style = "font-weight: 600;"),
        p("For the question “How has the death- and birth rate of different countries progressed over the years?”, the dataset was analyzed where two data series were selected which are the “Death rate, crude (per 1,000 people)” and “Birth rate, crude (per 1,000 people)”. The selected data series would bring value to examining the death- and birth rates in different countries over the years. A scatter plot was utilized where the data was selected, filtered, and cleaned for non-existing values in order to visualize the data in the most meaningful manner.", style = "font-size:17px;"),
        column(width = 12, tags$hr()),
        h2("Scatter plot with death and birth rate", style = "font-weight: 600;"),
        p("For example, if India were chosen as the country to examine the death and birth rate over the year, it was shown that the death rate was decreasing from 2010 to 2017 and then began to increase again. The birth rate was decreasing with a consistent interval which could be seen with the regression calculated based on each data series. The implemented regression line visually showcased the correlation between the data points. The scatterplot visualized how the death and birth rate progressed over the year where the example with India showcased that the birth rate was decreasing, and the death rate were increasing. This is a very interesting observation, where the years 2020 and 2021 were impacted of the covid-19 pandemic around the world which could explain the death rate that was increasing drastically.", style = "font-size:17px;"),
        
        fluidRow(
            sidebarPanel(
                width = 3,
                align = "center",
                style = "margin-top: 100px;",
                selectInput("countryScatterPlotSelectedCountry", "Select a Country", choices = unique(long_data$`Country Name`))
            ),
            mainPanel(
                width = 9,
                style = "margin-top: 10px;",
                plotlyOutput("birth_death_rate_scatterplot")
            )
    )
    )
}
