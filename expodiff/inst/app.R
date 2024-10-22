#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    h2("My"),

    #includeCSS(pathtoCSSfile)
    #(id+label)
    actionButton("button1", "Push me!"),
    actionLink("link1", "Push me too!"),
    checkboxInput("checkbox1", "Are you sure"),
    checkboxGroupInput("checkbox1", "Choose one", choices = c("First choice", "Second choice")),
    selectizeInput("selectize1", "Pick from dropdown", choice = c("First choice", "Second choice"), multiple = TRUE),
    numericInput("numeric1", "Enter number", value = 1, min = 1, max = 10, step = 1),
    radioButtons("id7", "Select one",
                 choices = c("Pizza", "Dumplings", "Sushi")),
    textInput("id9", "Enter text", value = "Enter coments here"),
    dateInput("id10", "Select day"),
    dateRangeInput("id11", "Select days"),
    selectInput("id12", "Select a drink", choices = c("Tea", "Coffee")),
    sliderInput("id13", "How many?", min = 0, max = 10, value = 0),




    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')
    })
}

# Run the application
shinyApp(ui = ui, server = server)
