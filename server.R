###### App for Exploring Elk Island Data Set ######
########   Cortland Reed ###################

# Required packages:
library(shiny)  
library(dplyr)
library(ggplot2)


shinyServer(
  function(input,output,session){
    # Read in data set, may need to change directory:
    elkisland <- read.csv(file = "C:/Users/Cortl/Downloads/Elk_Island.csv",
                          header = T)
    # Adjust classes of variables to allow for proper reading
    elkisland %>%
      mutate(Population.year = as.factor(elkisland$Population.year),
             Area.of.park = as.factor(elkisland$Area.of.park),
             Species.name = as.factor(elkisland$Species.name),
             Fall.population.estimate = as.numeric(elkisland$Fall.population.estimate))
    # New, reactive data frame allows for changes in species in dropdown:
    data <- reactive({
      req(input$sel_Species.name)
      df <- elkisland %>% filter(Species.name %in% input$sel_Species.name) %>% group_by(Population.year) %>% summarise(Fall.population.estimate = mean(Fall.population.estimate))
    })
    # Defines output as scatterplot:
    output$newScat <- renderPlot({
        g <- ggplot(data(), aes( y = Fall.population.estimate, x = Population.year))
        g + geom_point(position = "jitter",
                   size = 2,
                   color = "forestgreen") +
        xlab("Year") +
        ylab("Average Fall Population Estimates")+
        ggtitle("Wildlife Population on Elk Island")+
        theme(axis.text = element_text(size = 10),
              axis.title = element_text(size = 15),
              plot.title = element_text(size = 20, face = "bold"),
              panel.border = element_rect(color = "black", fill = NA, size = 1.5))
    })
    # Defines output as table:
    output$data <- renderTable(
      brushedPoints(data(), input$plot_brush)
    )
  }
)