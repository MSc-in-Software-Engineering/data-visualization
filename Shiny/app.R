library(shiny)
library(shinydashboard)
library(shinyjs)
library(readxl)
library(ggplot2)

data <- read_excel("world-development-indicators-set.xlsx")

ui <- dashboardPage(
  dashboardHeader(title = "WDI visualization"),
  dashboardSidebar(sidebarMenu(
    menuItem("Introduction", tabName = "introduction"),
    menuItem("Population growth", tabName = "populationGrowth")
  )),
  dashboardBody(
    tags$style(HTML(".content-wrapper { background-color: white; }")),  
    tabItems(
    tabItem("introduction",
            h1("N/A")),
    tabItem(
      "populationGrowth",
      h1("Population growth"),
      p("N/A"),
      h2("Annual population growth in percentage"),
      p("N/A"),
      fluidRow(
        column(8, plotOutput("ggplot")),
        column(
          4,
          sliderInput(
            "selectedYear",
            "Choose a year to investigate",
            min = 2010,
            max = 2019,
            value = 2010,
          )
        ),
        )
    )
  )),
  skin = "blue"
)

server <- function(input, output, session) {
  output$ggplot <- renderPlot({
    population_data <-
      na.omit(data[data$`Series Name` == "Population growth (annual %)",])
    
    slider_year = paste(input$selectedYear, " [YR", input$selectedYear, "]", sep = "")
    
    year = as.numeric(population_data[[slider_year]])
    country = population_data$`Country Name`
    
    sorted_population_data <- population_data[order(year),]
    
    ggplot(sorted_population_data, aes(x = country, y = year)) +
      geom_bar(stat = "identity", width = 0.5, fill="#3C8DBC") +
      scale_y_continuous(labels = scales::comma) +
      labs(title = paste("Population growth (", input$selectedYear, ")", sep = ""), x = "Countries", y = "Population growth in percentage (%)") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
}

shinyApp(ui, server)
