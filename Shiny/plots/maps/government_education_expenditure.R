library(readxl)
library(ggplot2)
library(tidyr)
library(dplyr)
library(stringr)
library(maps)
library(mapproj)
library(plotly)

WDI_data <- read_excel("datasets/world-development-indicators.xlsx")

transparent_theme <- theme(
  panel.background = element_rect(fill = "transparent"),
  plot.background = element_rect(fill = "transparent", color = NA),
  panel.grid = element_blank(),
  panel.border = element_blank(),
  axis.text.x = element_text(angle = 45, hjust = 1)
)

# This filters the columns based on which series we want to utilize
education_expenditure_data <- WDI_data %>%
  filter(`Series Name` == "Government expenditure on education, total (% of GDP)") %>%
  select(`Country Name`, contains("YR")) %>%
  pivot_longer(cols = -`Country Name`, names_to = "Year", values_to = "Percentage_of_GDP") %>%
  na.omit()

# Mutate function that cleans the years columns to numeric values
education_expenditure_data <- education_expenditure_data %>%
  mutate(Year = as.numeric(str_extract(Year, "[0-9]+")))


government_education_expenditure_map <- function(selectedYear) {
  year <- selectedYear

  # Filtering out non existing values
  selected_education_expenditure_data <- education_expenditure_data %>%
    filter(Year == year, !is.na(Percentage_of_GDP))

  map <- map_data("world")

  join_map_data <- left_join(map, selected_education_expenditure_data, by = c("region" = "Country Name"))

  # Adding color column based on percentage of GDP
  join_map_data$Percentage_of_GDP <- as.numeric(join_map_data$Percentage_of_GDP)
  
  legend_values <- c("8+ %", "6 to 8 %", "4 to 6 %", "2 to 4 %", "0 - 2 %", "No data")
  

  # Mutating intervals with the growth percentage values
  join_map_data <- join_map_data %>%
    mutate(
      color = factor(
        case_when(
          is.na(Percentage_of_GDP) ~ legend_values[6],
          between(Percentage_of_GDP, 0, 2) ~ legend_values[5],  
          between(Percentage_of_GDP, 2, 4) ~ legend_values[4],
          between(Percentage_of_GDP, 4, 6) ~ legend_values[3],
          between(Percentage_of_GDP, 6, 8) ~ legend_values[2],
          Percentage_of_GDP > 8 ~ legend_values[1],
          TRUE ~ "No data"
        ),
        levels = legend_values
      )
    )
  
  # Color scale for the percentage intervals
  color_scale <- scale_fill_manual(
    values = c("darkblue", "blue", "lightblue", "lightyellow", "white", "grey"),
    breaks = legend_values,
    labels = legend_values,
    name = "% of GDP",
    na.value = "grey"
  )
  
  # ggplot and plotly
  government_education_expenditure_map_plot <- ggplot(data = join_map_data, aes(
    x = long,
    y = lat,
    group = group,
    fill = color,
    text = paste("Country: ", region, "\n% of GDP spent on education: ", round(Percentage_of_GDP, digits = 2), "%")
  )) +
    geom_polygon(size = .1, color = "black") +
    color_scale +
    labs(title = paste("Government expenditure on education, total (% of GDP)", year)) +
    coord_map()

  ggplotly(government_education_expenditure_map_plot, tooltip = "text")
}
