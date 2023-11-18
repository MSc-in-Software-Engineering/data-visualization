library(readxl)
library(ggplot2)
library(tidyr)
library(dplyr)
library(stringr)
library(maps)
library(plotly)

WDI_data <- read_excel("datasets/world-development-indicators.xlsx")

transparent_theme <- theme_bw(14) + theme(
  panel.background = element_rect(fill = "transparent"),
  plot.background = element_rect(fill = "transparent", color = NA),
  panel.grid = element_blank(),
  panel.border = element_blank(),
  axis.text.x = element_text(angle = 45, hjust = 1)
)

# This filters the columns based on which series we want to utilize
gdp_data <- WDI_data %>%
  filter(`Series Name` == "GDP growth (annual %)") %>%
  select(`Country Name`, contains("YR")) %>%
  pivot_longer(cols = -`Country Name`, names_to = "Year", values_to = "GDP_Growth") %>%
  na.omit()

# Mutate function that cleans the years columns to numeric values
gdp_data <- gdp_data %>%
  mutate(Year = as.numeric(str_extract(Year, "[0-9]+")))

gdp_growth_rate_map <- function(selectedYear) {
  year <- selectedYear
  
  # Filtering out non-existing values
  selected_gdp_data <- gdp_data %>%
    filter(Year == year, !is.na(GDP_Growth))
  
  map <- map_data("world")
  
  join_map_data <- left_join(map, selected_gdp_data, by = c("region" = "Country Name"))
  
  # Adding color column based on GDP growth
  join_map_data$GDP_Growth <- as.numeric(join_map_data$GDP_Growth)
  
  # Mutate method to create unique intervals on legend
  join_map_data <- join_map_data %>%
    mutate(color = case_when(
      is.na(GDP_Growth) ~ "grey",
      GDP_Growth < -2 ~ "darkred",
      between(GDP_Growth, -2, 0) ~ "red",
      between(GDP_Growth, 0, 1) ~ "lightgreen",
      between(GDP_Growth, 1, 4) ~ "green",
      GDP_Growth > 4 ~ "darkgreen",
      TRUE ~ "grey"
    ))
  
  gdp_growth_rate_map_plot <- ggplot(data = join_map_data, aes(x = long, y = lat, group = group, fill = color, text = paste("GDP Growth: ", round(GDP_Growth, digits = 2), "%"))) +
    geom_polygon(size = 0.1, color = "black") +
    scale_fill_manual(
      values = c("darkgreen", "green", "lightgreen", "red", "darkred", "grey"),
      breaks = c("darkgreen", "green", "lightgreen", "red", "darkred", "grey"),
      name = "Percentage of growth", na.value = "grey",
      labels = c("+4 %", "1 to 4 %", "0 to 1 %", "-2 to 0 %", "< -2 %", "No data")
    ) +
    scale_shape_manual(values = c(15, 15, 15, 15, 15, 15)) +
    labs(title = paste("GDP Growth Rate of all Countries in", year)) +
    transparent_theme
  
  ggplotly(gdp_growth_rate_map_plot, tooltip = "text")
}