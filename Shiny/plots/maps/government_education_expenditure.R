library(readxl)
library(ggplot2)
library(tidyr)
library(dplyr)
library(stringr)
library(maps)
library(plotly)

dataset <- read_excel("datasets/world-development-indicators-2.xlsx")

transparent_theme <- theme(
  panel.background = element_rect(fill = "transparent"),
  plot.background = element_rect(fill = "transparent", color = NA),
  panel.grid = element_blank(),
  panel.border = element_blank(),
  axis.text.x = element_text(angle = 45, hjust = 1)
)

# This filters the columns based on which series we want to utilize
education_expenditure_data <- dataset %>%
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

  # Mutate method to create unique intervals on legend
  join_map_data <- join_map_data %>%
    mutate(color = case_when(
      is.na(Percentage_of_GDP) ~ "grey",
      between(Percentage_of_GDP, 0, 2) ~ "white",
      between(Percentage_of_GDP, 2, 4) ~ "lightyellow",
      between(Percentage_of_GDP, 4, 6) ~ "lightgreen",
      between(Percentage_of_GDP, 6, 8) ~ "green",
      Percentage_of_GDP > 8 ~ "darkgreen",
      TRUE ~ "grey"
    ))


  government_education_expenditure_map_plot <- ggplot(data = join_map_data, aes(x = long, y = lat, group = group, fill = color, text = paste("Expenditure of GDP (%): ", round(Percentage_of_GDP, digits = 2), "%"))) +
    geom_polygon(size = 0.1, color = "black") +
    scale_fill_manual(
      values = c("darkgreen", "green", "lightgreen", "lightyellow", "white", "grey"),
      breaks = c("darkgreen", "green", "lightgreen", "lightyellow", "white", "grey"),
      name = "% of GDP", na.value = "grey",
      labels = c("8+ %", "6 to 8 %", "4 to 6 %", "2 to 4 %", "0 to 2 %", "No data")
    ) +
    labs(title = paste("Government expenditure on education, total (% of GDP)", year)) +
    transparent_theme

  ggplotly(government_education_expenditure_map_plot, tooltip = "text")
}
