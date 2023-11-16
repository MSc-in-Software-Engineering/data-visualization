library(shiny)
library(shinydashboard)
library(shinyjs)
library(readxl)
library(ggplot2)

# Pages
source("./pages/introduction.R")
source("./pages/page_1.R")
source("./pages/page_2.R")
source("./pages/page_3.R")
source("./pages/conclusion.R")
source("./pages/project_report.R")

# Server
source("./server.R")


# User interface
ui <- dashboardPage(

  # Header
  dashboardHeader(title = "World Development Indicators", titleWidth = 300),

  # Sidebar
  dashboardSidebar(sidebarMenu(
    menuItem("1. Introduction", tabName = "introduction"),
    menuItem("2. Population growth", tabName = "pageOne"),
    menuItem("3. GDP growth", tabName = "pageTwo"),
    menuItem("4. Death and birth rate", tabName = "pageThree"),
    menuItem("5. Conclusion", tabName = "conclusion"),
    menuItem("6. Download project report", tabName = "projectReport")
  )),

  # Body
  dashboardBody(
    includeCSS("styles.css"),
    # Tabs
    tabItems(
      tabItem("introduction", introduction()),
      tabItem("pageOne", page_1()),
      tabItem("pageTwo", page_2()),
      tabItem("pageThree", page_3()),
      tabItem("conclusion", conclusion()),
      tabItem("projectReport", project_report())
    )
  )
)

shinyApp(ui, server)
