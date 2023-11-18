library(readxl)
library(ggplot2)
library(tidyr)
library(dplyr)
library(stringr)
library(plotly)

WDI_data <- read_excel("datasets/world-development-indicators.xlsx")

relevant_rows <- subset(WDI_data, `Series Name` %in% c("Life expectancy at birth, male (years)", "Life expectancy at birth, female (years)"))

male_data <- relevant_rows %>%
  filter(`Series Name` == "Life expectancy at birth, male (years)") %>%
  select(`Country Name`, contains("YR")) %>%
  pivot_longer(
    cols = -`Country Name`,
    names_to = "Year",
    values_to = "Male"
  ) %>%
  mutate(Year = as.numeric(str_extract(Year, "[0-9]+"))) %>%
  na.omit()

female_data <- relevant_rows %>%
  filter(`Series Name` == "Life expectancy at birth, female (years)") %>%
  select(`Country Name`, contains("YR")) %>%
  pivot_longer(
    cols = -`Country Name`,
    names_to = "Year",
    values_to = "Female"
  ) %>%
  mutate(Year = as.numeric(str_extract(Year, "[0-9]+"))) %>%
  na.omit()

join_tables <- inner_join(male_data, female_data, by = c("Country Name", "Year"))

join_tables$Year <- as.numeric(join_tables$Year)
join_tables$Male <- as.numeric(join_tables$Male)
join_tables$Female <- as.numeric(join_tables$Female)

