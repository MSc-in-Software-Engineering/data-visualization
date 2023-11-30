library(readxl)
library(ggplot2)
library(tidyr)
library(dplyr)
library(stringr)
library(maps)
library(plotly)

WDI_data <- read_excel("datasets/world-development-indicators.xlsx")

long_data <- WDI_data %>%
    gather(Year, Value, 5:14) %>%
    mutate(Year = as.numeric(gsub(".*?(\\d{4}).*", "\\1", Year)))

mortality_linechart <- function(selectedCountry) {
  long_data <-
    long_data[long_data$"Series Name" %in% c("Mortality from CVD, cancer, diabetes or CRD between exact ages 30 and 70, female (%)", "Mortality from CVD, cancer, diabetes or CRD between exact ages 30 and 70, male (%)"),]

  long_data$Value <- as.numeric(long_data$Value)
  long_data[is.na(long_data)] <- 0

  filtered_data <- long_data[long_data$`Country Name` == selectedCountry, ]

  linechart <- ggplot(
    data = filtered_data,
    aes(x = Year, y = Value, group = `Series Name`, color = `Series Name`, text = paste("Year: ", Year, "\nPercentage: ", round(Value, digits = 2), "%"))
  ) +
    geom_smooth(method = "loess", se = FALSE, size = 1, span = 0.2) +
    geom_point(size = 4, shape = 19, fill = "white") +
    labs(
      x = "Year",
      y = "Percentage",
      title = "Mortality from CVD, cancer, diabetes or CRD between exact ages 30 and 70 (Female/Male)"
    ) +
    scale_y_continuous(
      limits = c(min(filtered_data$Value) - 1, max(filtered_data$Value) + 1),
      breaks = seq(min(filtered_data$Value) - 1, max(filtered_data$Value) + 1, 1)
    ) +
    scale_x_continuous(breaks = unique(long_data$Year)) +
    theme_minimal() +
    theme(
      panel.grid.major.x = element_blank(),
      panel.grid.minor.x = element_blank(),
      panel.grid.minor.y = element_blank(),
      axis.text.x = element_text(angle = 45, hjust = 1),
      axis.ticks.x = element_blank()
    ) +
    scale_color_manual(values = c(
      "Mortality from CVD, cancer, diabetes or CRD between exact ages 30 and 70, female (%)" = "#138D75",
      "Mortality from CVD, cancer, diabetes or CRD between exact ages 30 and 70, male (%)" = "#900C3F"
    )) +
    annotate(geom = "segment", x = unique(long_data$Year), xend = unique(long_data$Year), y = -0.1, yend = 0.1, color = "black")

  p_plotly <- ggplotly(linechart, tooltip = "text")
  
  p_plotly$x$data[[1]]$name <- "Female (%)"
  p_plotly$x$data[[2]]$name <- "Male (%)"

  p_plotly
}

