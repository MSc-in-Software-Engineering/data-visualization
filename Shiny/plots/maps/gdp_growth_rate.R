library(readxl)
library(ggplot2)
library(tidyr)
library(dplyr)
library(stringr)
library(maps)
library(mapproj)
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
  
  legend_values <- c("+4 %", "1 to 4 %", "0 to 1 %", "-2 to 0 %", "< -2 %", "No data")
  
  # Mutating intervals with the growth percentage values
  join_map_data <- join_map_data %>%
    mutate(
      color = factor(
        case_when(
          is.na(GDP_Growth) ~ legend_values[6],
          GDP_Growth < -2 ~ legend_values[5],  
          between(GDP_Growth, -2, 0) ~ legend_values[4],
          between(GDP_Growth, 0, 1) ~ legend_values[3],
          between(GDP_Growth, 1, 4) ~ legend_values[2],
          GDP_Growth > 4 ~ legend_values[1],
          TRUE ~ "No data"
        ),
        levels = legend_values
      )
    )
  
  # Color scale for the percentage intervals
  color_scale <- scale_fill_manual(
    values = c("darkblue", "blue", "lightblue", "goldenrod1", "coral2", "grey"),
    breaks = legend_values,
    labels = legend_values,
    name = "Percentage of growth",
    na.value = "grey"
  )
  
  # ggplot and plotly
  gdp_growth_rate_map_plot <- ggplot(data = join_map_data, aes(
    x = long,
    y = lat,
    group = group,
    fill = color,
    text = paste("Country: ", region, "\nGDP Growth: ", round(GDP_Growth, digits = 2), "%")
  )) +
    geom_polygon(size = .1, color = "black") +
    color_scale +
    labs(title = paste("GDP Growth Rate of all Countries in", year)) +
    coord_map()
  
  
  ggplotly(gdp_growth_rate_map_plot, tooltip = "text")
  
}