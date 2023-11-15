library(shiny)
library(shinydashboard)
library(shinyjs)
library(readxl)
library(ggplot2)

data <- read_excel("datasets/world-development-indicators-1.xlsx")

transparent_theme <- theme(
  panel.background = element_rect(fill = "transparent"),
  plot.background = element_rect(fill = "transparent", color = NA),
  panel.grid = element_blank(),
  panel.border = element_blank(),
  axis.line = element_line(),
  axis.text.x = element_text(angle = 45, hjust = 1)
)


population_growth_barchart <- function(selectedYear) {
  population_data <- na.omit(data[data$`Series Name` == "Population growth (annual %)", ])

  slider_year <- paste(selectedYear, " [YR", selectedYear, "]", sep = "")

  year <- as.numeric(population_data[[slider_year]])
  country <- population_data$`Country Name`

  sorted_population_data <- population_data[order(year), ]

  population_growth_plot <- ggplot(sorted_population_data, aes(x = country, y = year)) +
    geom_bar(stat = "identity", width = 0.5, fill = "#3C8DBC", aes(text = paste("Year: ", selectedYear, "<br>Growth: ", round(year, digits = 2), "%"))) +
    scale_y_continuous(labels = scales::comma) +
    labs(
      title = paste("Population growth (", selectedYear, ")", sep = ""),
      x = "Countries",
      y = "Growth in percentage (%)"
    ) +
    transparent_theme

  ggplotly(population_growth_plot, tooltip = "text")
}