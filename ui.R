# UI for Elk Island App #
# Cortland Reed #

#Required packages:
library(shiny)
library(shinythemes)

# Set up UI as fluid page with designated theme
shinyUI(fluidPage(theme = shinytheme("superhero"),
                  titlePanel("Population Trends in Elk Island National Park"),
                  sidebarLayout(
                    sidebarPanel(
                      selectInput(inputId = "sel_Species.name",
                                  label = "Select a Species:",
                                  list("Bison","Deer","Elk","Moose"
                                       )
                      )
                      ),
                    # Prints scatterplot and table in main panel
                    mainPanel(
                      plotOutput('newScat', brush = "plot_brush"),
                      tableOutput("data")
                    )
                    )
                  )
        )
