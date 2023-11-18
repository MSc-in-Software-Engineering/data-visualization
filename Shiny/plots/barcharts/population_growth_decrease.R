library(readxl)
library(ggplot2)
library(tidyr)
library(dplyr)
library(stringr)
library(maps)

WDI_data <- read_excel("datasets/world-development-indicators.xlsx")

# Filtering to get Population growth data
population_data <- WDI_data %>%
    filter(`Series Name` == "Population growth (annual %)") %>%
    select(`Country Name`, contains("YR")) %>%
    pivot_longer(cols = -`Country Name`, names_to = "Year", values_to = "Population_growth") %>%
    na.omit()

# Refactoring the years to numeric values instead
population_data <- population_data %>%
    mutate(Year = as.numeric(str_extract(Year, "[0-9]+")))


population_growth_decrease_barchart <- function(selectedYear) {
    year <- selectedYear

    # Filtering out values that has not data
    population_data_for_selected_year <- population_data %>%
        filter(Year == year, !is.na(Population_growth))
        
    population_data_for_selected_year$Population_growth <- as.numeric(as.character(population_data_for_selected_year$Population_growth))

    # Getting the 10 countries with the lowest Population growth and arranging them
    lowest_countries <- population_data_for_selected_year %>%
        top_n(-20, wt = Population_growth) %>%
        arrange(-desc(Population_growth)) %>%
        mutate(Population_growth = round(Population_growth, digits = 2))
    lowest_countries
    lowest_countries$`Country Name` <- factor(lowest_countries$`Country Name`, levels = unique(lowest_countries$`Country Name`))

    bar_chart <- ggplot(lowest_countries, aes(x = `Country Name`, y = Population_growth, fill = Population_growth, text = paste("Population growth (Annual %): ", Population_growth, "%"))) +
        geom_bar(stat = "identity", color = "black") +
        scale_fill_gradient(low = "darkred", high = "indianred1") +
        labs(
            title = paste("Top 20 countries with lowest population growth (Annual %) in", year),
            x = "Country",
            y = "Population growth (annual %)"
        ) +
        theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
        scale_y_reverse() 

    ggplotly(bar_chart, tooltip = "text")
}
