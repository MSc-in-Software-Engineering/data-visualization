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
  long_data[long_data$"Series Name" %in% c("Population growth (annual %)", "GDP growth (annual %)"),]

long_data$Value <- as.numeric(long_data$Value)
long_data[is.na(long_data)] <- 0

filtered_data <- long_data[long_data$"Country Name" == "Denmark", ]

# Plot
p <- filtered_data %>%
  ggplot(aes(x = Year, y = Value, group = `Series Name`,color = `Series Name`)) +
  geom_line(size = 1.2) +
  geom_point(size = 4, shape = 19, fill = "white") +
  theme_ipsum() +
  ylab("Value") +
  theme_minimal() +
  theme(panel.grid.major.x = element_blank(),
        
        axis.text.x = element_text(angle = 45, hjust = 1),
        axis.ticks.x = element_blank(),
        ) +
  transition_reveal(Year)+
  scale_x_continuous(breaks = unique(long_data$Year))+
  scale_y_continuous(
    limits = c(min(filtered_data$Value)-0.5, max(filtered_data$Value)),
    breaks = seq(floor(min(filtered_data$Value))-0.5, ceiling(max(filtered_data$Value)), 0.5)
  )+
  scale_color_manual(values = c(
    "Population growth (annual %)" = "#138D75",
    "GDP growth (annual %)" = "#900C3F"
  )) 


# Animate and view the plot
animate(p, nframes = 100, end_pause = 10)