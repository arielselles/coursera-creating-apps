library(shiny)

# Define UI for modeling wt vs mpg, adjusted by changing qsec values
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Adjusting linear model"),
    
    # Sidebar with a slider input for qsec 
    sidebarLayout(
        sidebarPanel(
            includeHTML("documentation.html"),
            h1("Time to run 1/4 mile:"),
            sliderInput("sliderQS", "seconds", 10, 24, 17)
        ),
        
        # Show a plot of the modified linear model
        mainPanel(
            plotOutput("plot1")
        )
    )
))
