library(readxl)
library(ggplot2)
library(tidyr)
library(dplyr)
library(stringr)
library(plotly)

dataset <- read_excel("datasets/world-development-indicators-2.xlsx")

# This filters the columns based on which series we want to utilize
death_rate_data <- dataset %>%
  filter(`Series Name` == "Death rate, crude (per 1,000 people)") %>%
  select(`Country Name`, contains("YR")) %>%
  pivot_longer(cols = -`Country Name`, names_to = "Year", values_to = "Death_rate") %>%
  na.omit()

birth_rate_data <- dataset %>%
  filter(`Series Name` == "Birth rate, crude (per 1,000 people)") %>%
  select(`Country Name`, contains("YR")) %>%
  pivot_longer(cols = -`Country Name`, names_to = "Year", values_to = "Birth_rate") %>%
  na.omit()

# Mutate function that cleans the years columns to numeric values
death_rate_data <- death_rate_data %>%
  mutate(Year = as.numeric(str_extract(Year, "[0-9]+")))

birth_rate_data <- birth_rate_data %>%
  mutate(Year = as.numeric(str_extract(Year, "[0-9]+")))

################################################################################
country_1 <- c("India")  

# Filtering out non existing values
filtered_death_rate_data <- death_rate_data %>%
  filter(`Country Name` %in% country_1 & !is.na(Death_rate))

# Filter for the selected countries and non-missing values for birth rate
filtered_birth_rate_data <- birth_rate_data %>%
  filter(`Country Name` %in% country_1 & !is.na(Birth_rate))

scatterPlot_1 <- ggplot() +
  geom_point(data = filtered_death_rate_data, aes(x = factor(Year), y = as.numeric(Death_rate), color = "Death Rate", text = paste("Year: ", Year, "<br>Death Rate: ", Death_rate)), size = 3) +
  geom_point(data = filtered_birth_rate_data, aes(x = factor(Year), y = as.numeric(Birth_rate), color = "Birth Rate", text = paste("Year: ", Year, "<br>Birth Rate: ", Birth_rate)), size = 3) +
  scale_color_manual(values = c("Death Rate" = "red", "Birth Rate" = "green")) +
  labs(x = "Year", y = "Rate (per 1,000 people)", title = "Death and Birth Rate of India Over Years") +
  theme(legend.position = "bottom") +
  labs(color = " ")

# Modify tooltip content
birth_death_rate_india_scatterplot <- function() {
  scatterPlot_1
}

################################################################################
country_2 <- c("United States")  

# Filtering out non existing values
filtered_death_rate_data <- death_rate_data %>%
  filter(`Country Name` %in% country_2 & !is.na(Death_rate))

# Filter for the selected countries and non-missing values for birth rate
filtered_birth_rate_data <- birth_rate_data %>%
  filter(`Country Name` %in% country_2 & !is.na(Birth_rate))

scatterPlot_2 <- ggplot() +
  geom_point(data = filtered_death_rate_data, aes(x = factor(Year), y = as.numeric(Death_rate), color = "Death Rate", text = paste("Year: ", Year, "<br>Death Rate: ", Death_rate)), size = 3) +
  geom_point(data = filtered_birth_rate_data, aes(x = factor(Year), y = as.numeric(Birth_rate), color = "Birth Rate", text = paste("Year: ", Year, "<br>Birth Rate: ", Birth_rate)), size = 3) +
  scale_color_manual(values = c("Death Rate" = "red", "Birth Rate" = "green")) +
  labs(x = "Year", y = "Rate (per 1,000 people)", title = "Death and Birth Rate of United States Over Years") +
  theme(legend.position = "bottom") +
  labs(color = " ")


# Modify tooltip content
birth_death_rate_united_states_scatterplot <- function() {
  scatterPlot_2
}