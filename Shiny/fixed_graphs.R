library(readxl)
library(ggplot2)

data <- read_excel("world-development-indicators-set.xlsx")

population_data <- na.omit(data[data$`Series Name` == "Population, total",])

year = as.numeric(population_data$`2019 [YR2019]`)
country = population_data$`Country Name`

sorted_population_data <- population_data[order(year),]

ggplot(sorted_population_data, aes(x = country, y = year)) +
  geom_bar(stat = "identity", width = 0.5) +
  scale_y_continuous(labels = scales::comma, breaks = seq(0, 1e10, by = 1e08)) +
  labs(title = "Population of each country in 2019", x = "Countries", y = "Population") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

###

population_data <- na.omit(data[data$`Series Name` == "Population growth (annual %)",])

year = as.numeric(population_data$`2019 [YR2019]`)
country = population_data$`Country Name`

sorted_population_data <- population_data[order(year),]

ggplot(sorted_population_data, aes(x = country, y = year)) +
  geom_bar(stat = "identity", width = 0.5) +
  scale_y_continuous(labels = scales::comma)  +
  labs(title = "Population growth of each country in 2019", x = "Countries", y = "Population growth in percentage") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

###

population_data <- na.omit(data[data$`Series Name` == "Life expectancy at birth, total (years)",])

year = as.numeric(population_data$`2019 [YR2019]`)
country = population_data$`Country Name`

sorted_population_data <- population_data[order(year),]

ggplot(sorted_population_data, aes(x = country, y = year)) +
  geom_bar(stat = "identity", width = 0.5) +
  scale_y_continuous(labels = scales::comma)  +
  labs(title = "Total life expectancy from birth in 2019", x = "Countries", y = "Life expectancy at birth, total (years)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

###

population_data <- na.omit(data[data$`Series Name` == "Death rate, crude (per 1,000 people)",])

year = as.numeric(population_data$`2019 [YR2019]`)
country = population_data$`Country Name`

sorted_population_data <- population_data[order(year),]

ggplot(sorted_population_data, aes(x = country, y = year)) +
  geom_bar(stat = "identity", width = 0.5) +
  scale_y_continuous(labels = scales::comma)  +
  labs(title = "Death rate per 1,000 people in 2019", x = "Countries", y = "Death rate, crude (per 1,000 people)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))




