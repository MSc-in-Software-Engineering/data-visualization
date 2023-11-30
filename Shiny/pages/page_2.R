page_2 <- function(input, output) {
  fluidPage(
    h1("GDP growth", style = "font-weight: 600;"),
    p("To analyse and answer the following question “Has the GDP of all countries grown positively within the last decade?”, the “GDP growth (annual %)” data series will be utilised. This data series contains data of countries’ GDP growth percentage from the year 2010 to 2022.", style = "font-size:17px;"),
    column(width = 12, tags$hr()),
    h2("Map chart of GDP growth", style = "font-weight: 600;"),
    p("The map chart visualises the annual GDP (Gross Domestic Product) growth of all the countries in the world. The map chart gives an insight into individual countries GDP growth in percentages and a general overview of how the GDP growth of the world has progressed over the years.
", style = "font-size:17px;"),
    p("As an example, looking at year 2020, it really stands out compared to the other years as the majority of the countries had a GDP growth under 0%. This shows that 2020 has overall been a really bad year for the global GDP and this is because of the global COVID-19 pandemic that had a serious negative impact on the global economy. However, the year after, only a few countries have had a negative growth and most of the countries have had a growth above 4%, and this shows that the world was slowly overcoming the pandemic", style = "font-size:17px;"),
    fluidRow(
      sidebarPanel(
        width = 3,
        align = "center",
        style = "margin-top: 100px;",
        sliderInput(
          "gdpGrowthRateMapSelectedYear",
          "Select year (2010 - 2022)",
          min = 2010,
          max = 2022,
          value = 2022,
          sep = "",
        )
      ),
      mainPanel(
        width = 9,
        style = "margin-top: 10px;",
        plotlyOutput("gdp_growth_rate_map", height=800)
      ),
    ),
    column(width = 12, tags$hr()),
    h2("20 countries with the highest GDP growth", style = "font-weight: 600;"),
    p("The bar chart visualizes the 20 countries with the highest GDP growth percentage for each year. Examining the 20 countries with the highest growth through the years, it reveals that for all years except one, the GDP growth has been above 6 % from the 20th country. The exception is the year 2020, where the GDP growth has been rather low even for the top 20 countries. The 20th country only had a GDP growth of a bit less and 2 %, and this further reveals the impact the COVID-19 pandemic had on the global GDP. ", style = "font-size:17px;"),
    fluidRow(
      sidebarPanel(
        width = 3,
        align = "center",
        style = "margin-top: 100px;",
        sliderInput(
          "gdpHighGrowthBarChartSelectedYear",
          "Choose a year to investigate",
          min = 2010,
          max = 2022,
          value = 2022,
          sep = "",
        )
      ),
      mainPanel(
        width = 9,
        style = "margin-top: 10px;",
        plotlyOutput("gdp_growth_top_barchart")
      )
    ),
    column(width = 12, tags$hr()),
    h2("20 countries with the lowest GDP growth", style = "font-weight: 600;"),
    p("The bar chart visualizes the 20 countries with the lowest GDP growth percentage for each year. Looking through the years, one year stands out compared to the others, which is year 2020. Here the 20th country had a GDP growth of roughly -14.5 % and it goes all the way down to -50% for the 1st country with the lowest growth. It is further noticeable that a majority of the 20 countries are smaller, more exotic countries and islands known for being vacation destinations. This would mean a majority of their income would be from tourism. These countries would have had the worst impact during the COVID-19 pandemic since people were unable to travel because of the lockdown restriction in the most part of the world. So as the chart reveals, the countries that thrived on tourism had an immense negative impact on their GDP growth. ", style = "font-size:17px;"),
    fluidRow(
      sidebarPanel(
        width = 3,
        align = "center",
        style = "margin-top: 100px;",
        sliderInput(
          "gdpLowGrowthBarChartSelectedYear",
          "Choose a year to investigate",
          min = 2010,
          max = 2022,
          value = 2022,
          sep = "",
        )
      ),
      mainPanel(
        width = 9,
        style = "margin-top: 10px;",
        plotlyOutput("gdp_growth_low_barchart")
      )
    ),
    h1("Government expenditure on education of GDP", style = "font-weight: 600;"),
    p("To analyse and answer the following question “How large of a proportion of the country’s GDP is spent on education?” the “Government expenditure on education, total (% of GDP)” data series will be utilised. contains the percentage of the total percentage of country’s GDP that is spend on education from the year 2010 to 2022.", style = "font-size:17px;"),
    column(width = 12, tags$hr()),
    h2("Map chart of the government expenditure", style = "font-weight: 600;"),
    p("The map chart visualizes how big of a percentage the governments spend on education from their total GDP. When examining the map through the different years it is noticeable that Namibia has had a dark green colour consistently through all the years, meaning the country has spent more than 8 % of their GDP on education. Namibia is one of the countries in Africa that has the highest literacy, and this could be correlated to the government’s expenditure on education.  ", style = "font-size:17px;"),
    fluidRow(
      sidebarPanel(
        width = 3,
        align = "center",
        style = "margin-top: 100px;",
        sliderInput(
          "governmentEducationExpenditureMapSelectedYear",
          "Select year (2010 - 2022)",
          min = 2010,
          max = 2022,
          value = 2022,
          sep = "",
        )
      ),
      mainPanel(
        width = 9,
        style = "margin-top: 10px;",
        plotlyOutput("government_education_expenditure_map", height=800)
      )
    ),
    column(width = 12, tags$hr()),
  )
}