introduction <- function(input, output) {
    fluidPage(
        h1("Introduction"),
        p("The introductory page consolidates the proposal as well as aspects to why the visualization of this data would occur. The dashboard is based upon research questions developed and will justify both the objectives and goals for the visualization design. When doing so, the visual encodings of processing data will be presented to accommodate the techniques used for each of the accomplished charts.", style = "font-size:17px; max-width: 1400px;"),
        p("Additionally, the main thread of this dashboard is to construct a linear story of the motivation for the research conducted, while promoting a great use case for the theory and practices gathered from the Data Visualization course at University of Southern Denmark.", style = "font-size:17px; max-width: 1400px;"),
        h2("Team members"),
        p("Nina Siwakoti", style = "font-size:17px;"),
        p("Karthikan Vimalarasan", style = "font-size:17px;"),
        p("Sathveekan Mohanabalan", style = "font-size:17px;"),
        p("Wahid Tobias Winberg Razzaghi", style = "font-size:17px;"),
        h2("Point of interest"),
        p("Compare the standard of living in different countries in correlation with the state of global development indicators.", style = "font-size:17px;"),
        h2("Problem"),
        p("Standard of living around the world varies greatly", style = "font-size:17px;"),
        h2("Research questions"),
        p("How has the global population progressed in the last decade?", style = "font-size:17px;"),
        p("How has the economic growth progressed in the last decade?", style = "font-size:17px;"),
        p("Which countries have the highest living standards?", style = "font-size:17px;"),
        p("Which countries have the lowest living standards?", style = "font-size:17px;"),
        h2("Dataset(s) utilized"),
        h3("World Development Indicators - Databank"),
        p("https://databank.worldbank.org/source/world-development-indicators", style = "font-size:17px;"),
    )
}
