library(shiny)

# Define server logic required to draw the linear models
shinyServer(function(input, output) {
    
    # Linear models
    model2 <- lm(data = mtcars, mpg ~ wt + qsec)
    model1 <- lm(data = mtcars, mpg ~ wt)
    
    # Prediction of mpg based on the value provided, and values 0 and 6 to wt
    model2Pred <- reactive({
        qsInput <- input$sliderQS
        
        # This prediction gives two points on the model plane, which allows us to calculate the new line
        predict(object = model2,
                newdata = data.frame(wt = c(0, 6),
                                     qsec = c(qsInput, qsInput)))
    })
    
    # Plotting
    output$plot1 <- renderPlot({
        # New intersection
        a <- model2Pred()[1]
        
        # New slope
        b <- (model2Pred()[2] - model2Pred()[1]) / 6
        
        # Paint 2 plots
        par(mfrow=c(1,2))
        
        # Plots mtcars points (wt, mpg)
        plot(x = mtcars$wt, y = mtcars$mpg, xlab="weight", ylab="miles per galon", main="Comparing models")
        
        # Plots model line mpg ~ wt
        abline(model1, col = "darkred", lwd = 2)
        
        # Plots new model line: mpg ~ wt + qsec, with a fixed value of qsec
        abline(a = a, b = b, col = "seagreen", lwd = 2)
        
        # Plots mtcars points (qsec, mpg)
        plot(x = mtcars$qsec, y = mtcars$mpg, xlab="sec per 1/4 mile", ylab="miles per galon", main="Selected qsec")
        
        # Plots the line related to the selected value of qsec
        abline(v = input$sliderQS, col = "seagreen", lwd = 2)
    })
    
})
