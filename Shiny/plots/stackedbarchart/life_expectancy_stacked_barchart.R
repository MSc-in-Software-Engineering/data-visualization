library(readxl)
library(ggplot2)
library(tidyr)
library(dplyr)
library(stringr)
library(plotly)

WDI_data <- read_excel("datasets/world-development-indicators.xlsx")

### ONLY CHOOSE THE COLUMS I'M INTERESTED IN ###
relevant_rows <- subset(WDI_data, `Series Name` %in% c("Life expectancy at birth, male (years)", "Life expectancy at birth, female (years)"))

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
  filter(!is.na(Male), !str_detect(Male, "\\.{2}")) %>%
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
  filter(!is.na(Female), !str_detect(Female, "\\.{2}")) %>%
  na.omit()

### JOIN BOTH TABLES TOGETHER AS ONE  ###
final_table <- inner_join(male_data, female_data, by = c("Country Name", "Year"))

### MODIFY YEAR, MALE AND FEMALE TO BE NUMERIC RATHER THAN CHARACTER BASED AS THEY ARE INTEGERS ###
final_table $Year <- as.numeric(final_table$Year)
final_table $Male <- as.numeric(final_table$Male)
final_table $Female <- as.numeric(final_table$Female)

life_expectancy_stacked_barchart <- function(selected_country) {
  selected_country <- selected_country

  specific_country <- subset(final_table, `Country Name` == selected_country)

  ### CREATE STACKED BAR CHART ###
  stacked_barchart <- ggplot(specific_country, aes(x = Year, y = Female, fill = "Gender")) +
    geom_bar(aes(x = Year, y = Female, fill = "Female", text = paste("Female<br>Year:", Year, "<br>Life expectancy:", round(Female))), stat = "identity", position = "dodge") +
    geom_bar(aes(x = Year, y = Male, fill = "Male", text = paste("Male<br>Year:", Year, "<br>Life expectancy:", round(Male))), stat = "identity", position = "dodge") +
    labs(title = paste("Average life expectancy at birth for male and female in", selected_country),
        x = "Year",
        y = "Life Expectancy",
        fill = "Gender") +
    scale_fill_manual(values = c("Male" = "blue", "Female" = "orange")) +
    scale_x_continuous(breaks = seq(min(specific_country$Year), max(specific_country$Year), by = 1))

  ggplotly(stacked_barchart, tooltip = "text")
}