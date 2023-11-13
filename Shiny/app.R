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
source("./pages/page_4.R")
source("./pages/project_report.R")

# Server
source("./server.R")

# User interface
ui <- dashboardPage(

  # Header
  dashboardHeader(title = "WDI visualization"),

  # Sidebar
  dashboardSidebar(sidebarMenu(
    menuItem("Introduction", tabName = "introduction"),
    menuItem("Page 1", tabName = "pageOne"),
    menuItem("Page 2", tabName = "pageTwo"),
    menuItem("Page 3", tabName = "pageThree"),
    menuItem("Page 4", tabName = "pageFour"),
    menuItem("Project report", tabName = "projectReport")
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
      tabItem("pageFour", page_4()),
      tabItem("projectReport", project_report())
    )
  )
)

shinyApp(ui, server)
