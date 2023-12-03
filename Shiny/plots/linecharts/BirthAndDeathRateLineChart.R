library(readxl)
library(ggplot2)
library(tidyr)
library(dplyr)
library(stringr)
library(plotly)

WDI_data <- read_excel("datasets/world-development-indicators.xlsx")

death_rate_data <- WDI_data %>%
  filter(`Series Name` == "Death rate, crude (per 1,000 people)") %>%
  select(`Country Name`, contains("YR")) %>%
  pivot_longer(
    cols = -`Country Name`,
    names_to = "Year",
    values_to = "Death_rate"
  ) %>%
  na.omit()

birth_rate_data <- WDI_data %>%
  filter(`Series Name` == "Birth rate, crude (per 1,000 people)") %>%
  select(`Country Name`, contains("YR")) %>%
  pivot_longer(
    cols = -`Country Name`,
    names_to = "Year",
    values_to = "Birth_rate"
  ) %>%
  na.omit()

death_rate_data <- death_rate_data %>%
  mutate(Year = as.numeric(str_extract(Year, "[0-9]+")))

birth_rate_data <- birth_rate_data %>%
  mutate(Year = as.numeric(str_extract(Year, "[0-9]+")))

countries <-
  c("India", "United States", "China", "Denmark", "Nigeria")

death_rate_filtered <- death_rate_data %>%
  filter(`Country Name` %in% countries & !is.na(Death_rate))

birth_rate_filtered <- birth_rate_data %>%
  filter(`Country Name` %in% countries & !is.na(Birth_rate))

death_rate_filtered <- na.omit(death_rate_filtered)
birth_rate_filtered <- na.omit(birth_rate_filtered)

death_rate_line_chart <- function() {
  death_rate_plot <- ggplot() +
    geom_line(
      data = death_rate_filtered,
      aes(
        x = Year,
        y = as.numeric(Death_rate),
        group = `Country Name`,
        color = `Country Name`
      ),
      size = 1
    ) +
    geom_point(data = death_rate_filtered,
               aes(
                 x = Year,
                 y = as.numeric(Death_rate),
                 color = `Country Name`,
                 text = paste("Year: ", Year, "<br>Death Rate: ", Death_rate)
               ),
               size = 3) +
    scale_color_manual(
      values = c(
        "India" = "orange",
        "United States" = "blue",
        "China" = "brown",
        "Denmark" = "black",
        "Nigeria" = "purple"
      )
    ) +
    labs(x = "Year", y = "Death Rate (per 1,000 people)", title = "Death Rate of Selected Countries Over Years") +
    theme(legend.position = "bottom") +
    scale_x_continuous(breaks = seq(
      min(death_rate_filtered$Year),
      max(death_rate_filtered$Year),
      by = 1
    ))
  
  ggplotly(death_rate_plot, tooltip = "text")
}

birth_rate_line_chart <- function() {
  birth_rate_plot <- ggplot() +
    geom_line(
      data = birth_rate_filtered,
      aes(
        x = Year,
        y = as.numeric(Birth_rate),
        group = `Country Name`,
        color = `Country Name`
      ),
      size = 1
    ) +
    geom_point(data = birth_rate_filtered,
               aes(
                 x = Year,
                 y = as.numeric(Birth_rate),
                 color = `Country Name`,
                 text = paste("Year: ", Year, "<br>Birth Rate: ", Birth_rate)
               ),
               size = 3) +
    scale_color_manual(
      values = c(
        "India" = "orange",
        "United States" = "blue",
        "China" = "brown",
        "Denmark" = "black",
        "Nigeria" = "purple"
      )
    ) +
    labs(x = "Year", y = "Birth Rate (per 1,000 people)", title = "Birth Rate of Selected Countries Over Years") +
    theme(legend.position = "bottom") +
    scale_x_continuous(breaks = seq(
      min(birth_rate_filtered$Year),
      max(birth_rate_filtered$Year),
      by = 1
    ))
  
  ggplotly(birth_rate_plot, tooltip = "text") 
}



