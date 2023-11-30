library(readxl)
library(ggplot2)
library(tidyr)
library(dplyr)
library(stringr)
library(plotly)

WDI_data <- read_excel("datasets/world-development-indicators.xlsx")

# This filters the columns based on which series we want to utilize
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

# Mutating years to numeric values
death_rate_data <- death_rate_data %>%
  mutate(Year = as.numeric(str_extract(Year, "[0-9]+")))

birth_rate_data <- birth_rate_data %>%
  mutate(Year = as.numeric(str_extract(Year, "[0-9]+")))

################################################################################
country_1 <- c("India")

# Filtering out non-existing values for death rate
death_rate_filtered <- death_rate_data %>%
  filter(`Country Name` %in% country_1 & !is.na(Death_rate))

# Filtering out non-existing values for birth rate
birth_rate_filtered <- birth_rate_data %>%
  filter(`Country Name` %in% country_1 & !is.na(Birth_rate))

# Removing non-finite values
death_rate_filtered <- na.omit(death_rate_filtered)
birth_rate_filtered <- na.omit(birth_rate_filtered)

scatterPlot_1 <- ggplot() +
  geom_point(
    data = death_rate_filtered,
    aes(
      x = Year,
      y = as.numeric(Death_rate),
      color = "Death Rate",
      text = paste("Year: ", Year, "<br>Death Rate: ", Death_rate)
    ),
    size = 3
  ) +
  geom_point(
    data = birth_rate_filtered,
    aes(
      x = Year,
      y = as.numeric(Birth_rate),
      color = "Birth Rate",
      text = paste("Year: ", Year, "<br>Birth Rate: ", Birth_rate)
    ),
    size = 3
  ) +
  scale_color_manual(values = c("Death Rate" = "orange", "Birth Rate" = "blue")) +
  labs(x = "Year", y = "Rate (per 1,000 people)", title = "Death and Birth Rate of India Over Years") +
  theme(legend.position = "bottom") +
  labs(color = " ") +
  geom_smooth(
    data = death_rate_filtered,
    aes(
      x = Year,
      y = as.numeric(Death_rate),
      color = "Death Rate"
    ),
    method = "lm",
    se = FALSE,
    na.rm = TRUE
  ) +
  geom_smooth(
    data = birth_rate_filtered,
    aes(
      x = Year,
      y = as.numeric(Birth_rate),
      color = "Birth Rate"
    ),
    method = "lm",
    se = FALSE,
    na.rm = TRUE
  ) +
  scale_x_continuous(breaks = seq(
    min(death_rate_filtered$Year),
    max(death_rate_filtered$Year),
    by = 1
  ))

ggplotly(scatterPlot_1, tooltip = "text")


################################################################################

birth_death_rate_scatterplot <- function(selectedCountry) {
  country_2 <- c(selectedCountry)
  
  
  # Filtering out non-existing values
  death_rate_filtered <- death_rate_data %>%
    filter(`Country Name` %in% country_2 & !is.na(Death_rate))
  
  # Filter for the selected countries and non-missing values for birth rate
  birth_rate_filtered <- birth_rate_data %>%
    filter(`Country Name` %in% country_2 & !is.na(Birth_rate))
  
  # Removing non-finite values
  death_rate_filtered <- na.omit(death_rate_filtered)
  birth_rate_filtered <- na.omit(birth_rate_filtered)
  
  scatterPlot_2 <- ggplot() +
    geom_point(
      data = death_rate_filtered,
      aes(
        x = Year,
        y = as.numeric(Death_rate),
        color = "Death Rate",
        text = paste("Year: ", Year, "<br>Death Rate: ", Death_rate)
      ),
      size = 3
    ) +
    geom_point(
      data = birth_rate_filtered,
      aes(
        x = Year,
        y = as.numeric(Birth_rate),
        color = "Birth Rate",
        text = paste("Year: ", Year, "<br>Birth Rate: ", Birth_rate)
      ),
      size = 3
    ) +
    scale_color_manual(values = c("Death Rate" = "orange", "Birth Rate" = "blue")) +
    labs(
      x = "Year",
      y = "Rate (per 1,000 people)",
      title = paste("Death and Birth Rate of", selectedCountry , "Over Years")
    ) +
    theme(legend.position = "bottom") +
    labs(color = " ") +
    geom_smooth(
      data = death_rate_filtered,
      aes(
        x = Year,
        y = as.numeric(Death_rate),
        color = "Death Rate"
      ),
      method = "lm",
      se = FALSE,
      na.rm = TRUE
    ) +
    geom_smooth(
      data = birth_rate_filtered,
      aes(
        x = Year,
        y = as.numeric(Birth_rate),
        color = "Birth Rate"
      ),
      method = "lm",
      se = FALSE,
      na.rm = TRUE
    ) +
    scale_x_continuous(breaks = seq(
      min(death_rate_filtered$Year),
      max(death_rate_filtered$Year),
      by = 1
    ))
  
  ggplotly(scatterPlot_2, tooltip = "text")
}
