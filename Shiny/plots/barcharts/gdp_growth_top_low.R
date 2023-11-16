library(readxl)
library(ggplot2)
library(tidyr)
library(dplyr)
library(stringr)
library(maps)
library(plotly)

WDI_data <-
  read_excel("datasets/world-development-indicators-2.xlsx")

# Filtering to get GDP growth data
gdp_data <- WDI_data %>%
  filter(`Series Name` == "GDP growth (annual %)") %>%
  select(`Country Name`, contains("YR")) %>%
  pivot_longer(
    cols = -`Country Name`,
    names_to = "Year",
    values_to = "GDP_Growth"
  ) %>%
  na.omit()

# Refactoring the years to numeric values instead
gdp_data <- gdp_data %>%
  mutate(Year = as.numeric(str_extract(Year, "[0-9]+")))


# Getting the 10 countries with the highest GDP growth and arranging them
gdp_growth_top_barchart <- function(selectedYear) {
  year <- selectedYear
  
  # Filtering out values that has not data
  gdp_data_for_selected_year <- gdp_data %>%
    filter(Year == year,!is.na(GDP_Growth))
  
  gdp_data_for_selected_year$GDP_Growth <- as.numeric(as.character(gdp_data_for_selected_year$GDP_Growth))
  
  # Getting the 20 countries with the highest GDP growth and arranging them
  highest_countries <- gdp_data_for_selected_year %>%
    top_n(20, wt = GDP_Growth) %>%
    arrange(desc(GDP_Growth)) %>%
    mutate(GDP_Growth = round(GDP_Growth, digits = 5))
  
  highest_countries$`Country Name` <-
    factor(highest_countries$`Country Name`,
           levels = unique(highest_countries$`Country Name`))
  
  bar_chart <-
    ggplot(
      highest_countries,
      aes(
        x = `Country Name`,
        y = GDP_Growth,
        fill = GDP_Growth,
        text = paste("GDP Growth Rate: ", GDP_Growth, "%")
      )
    ) +
    geom_bar(stat = "identity", color = "black") +
    scale_fill_gradient(low = "lightgreen", high = "darkgreen") +
    labs(
      title = paste("Top 10 GDP Growth Rates in", year),
      x = "Country",
      y = "GDP Growth Rate (%)"
    ) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
  p_plotly <- ggplotly(bar_chart, tooltip = "text")
  
  p_plotly
}

#____________________________________________________________________________#

gdp_growth_low_barchart <- function(selectedYear) {
  year <- selectedYear
  
  # Filtering out values that has not data
  gdp_data_for_selected_year <- gdp_data %>%
    filter(Year == year,!is.na(GDP_Growth))
  
  gdp_data_for_selected_year$GDP_Growth <- as.numeric(as.character(gdp_data_for_selected_year$GDP_Growth))
  
  
  # Getting the 10 countries with the lowest GDP growth and arranging them
  lowest_countries <- gdp_data_for_selected_year %>%
    top_n(-20, wt = GDP_Growth) %>%
    arrange(-desc(GDP_Growth)) %>%
    mutate(GDP_Growth = round(GDP_Growth, digits = 5))
  
  lowest_countries
  lowest_countries$`Country Name` <-
    factor(lowest_countries$`Country Name`,
           levels = unique(lowest_countries$`Country Name`))
  
  bar_chart <-
    ggplot(
      lowest_countries,
      aes(
        x = `Country Name`,
        y = GDP_Growth,
        fill = GDP_Growth,
        text = paste("GDP Growth Rate: ", GDP_Growth, "%")
      )
    ) +
    geom_bar(stat = "identity", color = "black") +
    scale_fill_gradient(low = "darkred", high = "indianred1") +
    labs(
      title = paste("Top 10 GDP Growth Rates in", year),
      x = "Country",
      y = "GDP Growth Rate (%)"
    ) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    scale_y_reverse()
  
  p_plotly <- ggplotly(bar_chart, tooltip = "text")
  
  p_plotly
}