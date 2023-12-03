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

# Filter data for death rate and birth rate
death_rate_filtered <- death_rate_data %>%
  filter(!is.na(Death_rate))

birth_rate_filtered <- birth_rate_data %>%
  filter(!is.na(Birth_rate))

# Removing non-finite values
death_rate_filtered <- na.omit(death_rate_filtered)
birth_rate_filtered <- na.omit(birth_rate_filtered)

# Plotting line charts with data points connected by lines
deathRateLineChart <- ggplot() +
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
  geom_point(
    data = death_rate_filtered,
    aes(
      x = Year,
      y = as.numeric(Death_rate),
      color = `Country Name`
    ),
    size = 3
  ) +
  labs(x = "Year", y = "Death Rate (per 1,000 people)", title = "Death Rate of All Countries Over Years") +
  theme(legend.position = "bottom") +
  scale_x_continuous(breaks = seq(
    min(death_rate_filtered$Year),
    max(death_rate_filtered$Year),
    by = 1
  ))

birthRateLineChart <- ggplot() +
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
  geom_point(
    data = birth_rate_filtered,
    aes(
      x = Year,
      y = as.numeric(Birth_rate),
      color = `Country Name`
    ),
    size = 3
  ) +
  labs(x = "Year", y = "Birth Rate (per 1,000 people)", title = "Birth Rate of All Countries Over Years") +
  theme(legend.position = "bottom") +
  scale_x_continuous(breaks = seq(
    min(birth_rate_filtered$Year),
    max(birth_rate_filtered$Year),
    by = 1
  ))

# Display the plots
print(deathRateLineChart)
print(birthRateLineChart)
