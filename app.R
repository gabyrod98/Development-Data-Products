library(shiny)
ui <- fluidPage (
  
  
  titlePanel("How many grams do you need to prepare a Molar solution?"),
  sidebarLayout(
    sidebarPanel(
      
      sliderInput("num1", "Final Molarity of your solution (M):",
                  min = 0, max = 10,
                  value = 0, step = 0.1),
      sliderInput("num2", "Total Volume in mililiters:",
                  min = 0, max = 1000,
                  value = 0, step = 0.5),
      sliderInput("num3", "Compound Molecular weight:",
                  min = 0, max = 300,
                  value = 0, step = 0.1),
      submitButton("Submit")),
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Table summarizing the values entered ----
      tableOutput("values"),
      h3("Grams needed to prepare the solution"),
      textOutput("grams")
      
    )))

# Define server logic for sliders 
server <- function(input, output) {
  
  # Reactive expression to create data frame of all input values ----
  sliderValues <- reactive({
    
    data.frame(
      Name = c("Molarity",
               "Volume in mililiters",
               "Molecular weight"),
      Value = as.character(c(input$num1,
                             input$num2,
                             input$num3)),stringsAsFactors=FALSE)})
  
  #Calculus of the grams with the given variables
  
  grams <- reactive({input$num1*input$num2*input$num3/1000})
  
  
  # Show the values in an HTML table ----
  output$values <- renderTable({
    sliderValues()
  })
  output$grams <- renderText({grams()})
  
}

# Create Shiny app ----
shinyApp(ui, server)   

