library(shiny)

# Define UI for application that draws a marginal utility curve
ui <- fluidPage(

    # Application title
    titlePanel("MDCEV Utility Function Visualization"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("psi",
                        "Value of Psi parameter",
                        min = 1,
                        max = 50,
                        value = 30),
            sliderInput("gamma",
                        "Value of Gamma parameter",
                        min = 0.1,
                        max = 10,
                        value = 2),
            sliderInput("alpha",
                        "Value of Alpha parameter",
                        min = 0,
                        max = 1,
                        value = 0.5)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    ux <- function(x, psi, gamma, alpha) {
        psi * ((x + gamma) / gamma)^(alpha - 1)
    }
    
    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- seq(0, 10, 0.1)
        
        # draw the marginal utility curve with specified parameters
        plot(x,
             ux(x, psi = input$psi, gamma = input$gamma, alpha = input$alpha),
             type = "l"
             )
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
