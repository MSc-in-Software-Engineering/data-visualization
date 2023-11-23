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
  pivot_longer(cols = -`Country Name`, names_to = "Year", values_to = "Death_rate") %>%
  na.omit()

birth_rate_data <- WDI_data %>%
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

# Filtering out non-existing values
filtered_death_rate_data <- death_rate_data %>%
  filter(`Country Name` %in% country_1 & !is.na(Death_rate))

# Filter for the selected countries and non-missing values for birth rate
filtered_birth_rate_data <- birth_rate_data %>%
  filter(`Country Name` %in% country_1 & !is.na(Birth_rate))

# Remove rows with non-finite values
filtered_death_rate_data <- na.omit(filtered_death_rate_data)
filtered_birth_rate_data <- na.omit(filtered_birth_rate_data)

scatterPlot_1 <- ggplot() +
  geom_point(data = filtered_death_rate_data, aes(x = Year, y = as.numeric(Death_rate), color = "Death Rate", text = paste("Year: ", Year, "<br>Death Rate: ", Death_rate)), size = 3) +
  geom_point(data = filtered_birth_rate_data, aes(x = Year, y = as.numeric(Birth_rate), color = "Birth Rate", text = paste("Year: ", Year, "<br>Birth Rate: ", Birth_rate)), size = 3) +
  scale_color_manual(values = c("Death Rate" = "red", "Birth Rate" = "green")) +
  labs(x = "Year", y = "Rate (per 1,000 people)", title = "Death and Birth Rate of India Over Years") +
  theme(legend.position = "bottom") +
  labs(color = " ") +
  # Add regression lines using geom_smooth
  geom_smooth(data = filtered_death_rate_data, aes(x = Year, y = as.numeric(Death_rate), color = "Death Rate"), method = "lm", se = FALSE, na.rm = TRUE) +
  geom_smooth(data = filtered_birth_rate_data, aes(x = Year, y = as.numeric(Birth_rate), color = "Birth Rate"), method = "lm", se = FALSE, na.rm = TRUE) +
  # Adjust x-axis breaks to display whole numbers
  scale_x_continuous(breaks = seq(min(filtered_death_rate_data$Year), max(filtered_death_rate_data$Year), by = 1))

# Modify tooltip content
ggplotly(scatterPlot_1, tooltip = "text")


################################################################################

# Modify tooltip content
birth_death_rate_scatterplot <- function(selectedCountry) {
  country_2 <- c(selectedCountry)  
  
  
  # Filtering out non-existing values
  filtered_death_rate_data <- death_rate_data %>%
    filter(`Country Name` %in% country_2 & !is.na(Death_rate))
  
  # Filter for the selected countries and non-missing values for birth rate
  filtered_birth_rate_data <- birth_rate_data %>%
    filter(`Country Name` %in% country_2 & !is.na(Birth_rate))
  
  # Remove rows with non-finite values
  filtered_death_rate_data <- na.omit(filtered_death_rate_data)
  filtered_birth_rate_data <- na.omit(filtered_birth_rate_data)
  
  scatterPlot_2 <- ggplot() +
    geom_point(data = filtered_death_rate_data, aes(x = Year, y = as.numeric(Death_rate), color = "Death Rate", text = paste("Year: ", Year, "<br>Death Rate: ", Death_rate)), size = 3) +
    geom_point(data = filtered_birth_rate_data, aes(x = Year, y = as.numeric(Birth_rate), color = "Birth Rate", text = paste("Year: ", Year, "<br>Birth Rate: ", Birth_rate)), size = 3) +
    scale_color_manual(values = c("Death Rate" = "red", "Birth Rate" = "green")) +
    labs(x = "Year", y = "Rate (per 1,000 people)", title = paste("Death and Birth Rate of", selectedCountry ,"Over Years")) +
    theme(legend.position = "bottom") +
    labs(color = " ") +
    # Add regression lines using geom_smooth
    geom_smooth(data = filtered_death_rate_data, aes(x = Year, y = as.numeric(Death_rate), color = "Death Rate"), method = "lm", se = FALSE, na.rm = TRUE) +
    geom_smooth(data = filtered_birth_rate_data, aes(x = Year, y = as.numeric(Birth_rate), color = "Birth Rate"), method = "lm", se = FALSE, na.rm = TRUE) +
    # Adjust x-axis breaks to display whole numbers
    scale_x_continuous(breaks = seq(min(filtered_death_rate_data$Year), max(filtered_death_rate_data$Year), by = 1))

   ggplotly(scatterPlot_2, tooltip = "text")
}

