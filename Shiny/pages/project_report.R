project_report <- function(input, output) {
      fluidPage(
        h1("Download project report", style = "font-weight: 600;"),
        p("The visualization design proposed and the research conducted resulted in a thorough report consolidating the work initialized. Within this page, a PDF reader has been provided as well as a external download button if need be.", style = "font-size:17px;"),
        column(width = 12, tags$hr()),
        sidebarPanel(
          p("To download the report, either go click on [Download report] or the download button located within the PDF reader at the navigation bar.", style = "font-size:17px;"),
          downloadButton("downloadReport", "Download report")),
        mainPanel(
          br(),
          tabPanel(
            title = "PDF Viewer",
            tags$iframe(
              style = "height: 900px; width: 100%; scrolling: yes",
              src = "report.pdf" 
            )
          )
        )
    )
}
