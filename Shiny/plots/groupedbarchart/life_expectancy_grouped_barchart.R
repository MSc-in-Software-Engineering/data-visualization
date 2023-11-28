library(readxl)
library(ggplot2)
library(tidyr)
library(dplyr)
library(stringr)
library(plotly)

WDI_data <- read_excel("datasets/world-development-indicators.xlsx")

### ONLY CHOOSE THE COLUMS I'M INTERESTED IN ###
relevant_rows <- subset(
  WDI_data,
  `Series Name` %in% c(
    "Life expectancy at birth, male (years)",
    "Life expectancy at birth, female (years)"
  )
)

### FILTER, SELECT, PIVOT AS WELL AS REMOVING NON VALUES FROM MALE DATA ###
male_data <- relevant_rows %>%
  filter(`Series Name` == "Life expectancy at birth, male (years)") %>%
  select(`Country Name`, contains("YR")) %>%
  pivot_longer(
    cols = -`Country Name`,
    names_to = "Year",
    values_to = "Male"
  ) %>%
  mutate(Year = as.numeric(str_extract(Year, "[0-9]+"))) %>%
  filter(!is.na(Male),!str_detect(Male, "\\.{2}")) %>%
  na.omit()

### FILTER, SELECT, PIVOT AS WELL AS REMOVING NON VALUES FROM FEMALE DATA ###
female_data <- relevant_rows %>%
  filter(`Series Name` == "Life expectancy at birth, female (years)") %>%
  select(`Country Name`, contains("YR")) %>%
  pivot_longer(
    cols = -`Country Name`,
    names_to = "Year",
    values_to = "Female"
  ) %>%
  mutate(Year = as.numeric(str_extract(Year, "[0-9]+"))) %>%
  filter(!is.na(Female),!str_detect(Female, "\\.{2}")) %>%
  na.omit()

### JOIN BOTH TABLES TOGETHER AS ONE  ###
final_table <-
  inner_join(male_data, female_data, by = c("Country Name", "Year"))

### MODIFY YEAR, MALE AND FEMALE TO BE NUMERIC RATHER THAN CHARACTER BASED AS THEY ARE INTEGERS ###
final_table$Year <- as.numeric(final_table$Year)
final_table$Male <- as.numeric(final_table$Male)
final_table$Female <- as.numeric(final_table$Female)

life_expectancy_grouped_barchart <- function(selected_country) {
  selected_country <- selected_country
  specific_country <-
    subset(final_table, `Country Name` == selected_country)
  
  country_male_female_selection_data <- specific_country %>%
    select(CountryName = `Country Name`, Year, Male, Female)
  
  country_value_data_frame <-
    gather(country_male_female_selection_data,
           key = "Gender",
           value = "Value",
           -c(CountryName, Year))
  
  ### CREATE GROUPED BAR CHART ###
  grouped_barchart_for_a_specific_country <-
    ggplot(country_value_data_frame, aes(x = Year, y = Value, fill = Gender)) +
    geom_bar(
      position = "dodge",
      stat = "identity",
      color = "black",
      size = 0.25
    ) +
    labs(
      title = paste(
        "Average life expectancy at birth for male and female in",
        selected_country
      ),
      x = "Year",
      y = "Life Expectancy",
      fill = "Gender"
    ) +
    scale_fill_manual(values = c("Male" = "blue", "Female" = "orange")) +
    scale_x_continuous(breaks = seq(
      min(country_value_data_frame$Year),
      max(country_value_data_frame$Year),
      by = 1
    ))
  ggplotly(grouped_barchart_for_a_specific_country)
}