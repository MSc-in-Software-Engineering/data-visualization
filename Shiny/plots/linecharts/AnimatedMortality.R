library(readxl)
library(ggplot2)
library(gganimate)
library(hrbrthemes)
library(dplyr)
library(tidyr)

WDI_data <- read_excel("datasets/world-development-indicators.xlsx")

long_data <- WDI_data %>%
  gather(Year, Value, 5:14) %>%
  mutate(Year = as.numeric(gsub(".*?(\\d{4}).*", "\\1", Year)))

long_data <-
  long_data[long_data$"Series Name" %in% c("Mortality from CVD, cancer, diabetes or CRD between exact ages 30 and 70, female (%)", "Mortality from CVD, cancer, diabetes or CRD between exact ages 30 and 70, male (%)"),]

long_data$Value <- as.numeric(long_data$Value)
long_data[is.na(long_data)] <- 0

filtered_data <- long_data[long_data$"Country Name" == "China", ]

# Plot
p <- filtered_data %>%
  ggplot(aes(x = Year, y = Value, group = `Series Name`,color = `Series Name`)) +
  geom_line(size = 1.2) +
  geom_point(size = 4, shape = 19, fill = "white") +
  theme_ipsum() +
  ylab("Percentage") +
  theme_minimal() +
  theme(panel.grid.major.x = element_blank(),
        
        axis.text.x = element_text(angle = 45, hjust = 1),
        axis.ticks.x = element_blank(),
  ) +
  scale_x_continuous(breaks = unique(long_data$Year))+
  scale_y_continuous(
    limits = c(0, max(filtered_data$Value) + 1),
    breaks = seq(0, max(filtered_data$Value) + 1, 4)
  ) +
  transition_reveal(Year)+
  scale_color_manual(values = c(
    "Mortality from CVD, cancer, diabetes or CRD between exact ages 30 and 70, female (%)" = "#138D75",
    "Mortality from CVD, cancer, diabetes or CRD between exact ages 30 and 70, male (%)" = "#900C3F"
  ),
  labels = c(
    "Female (%)",
    "Male (%)"
  ))  +
  labs(color = "Series Name", title = "Mortality from CVD, cancer, diabetes or CRD between exact ages 30 and 70 (Female/Male)")
p

# Animate and view the plot
a <- animate(p, duration = 10, fps = 10, width = 2000, height = 1400, renderer = gifski_renderer(), res = 250)

# Save animation
anim_save("animation.gif", a)