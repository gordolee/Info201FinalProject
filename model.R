library("shiny")



my.ui <- fluidPage(
  
  titlePanel("Ski Resort Planner"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      # User has the option to select which ski resort s/he would like to go to (more can be added here)
      selectInput(
        "resort", "Select ski resort:", choices = c("Snoqualmie Ski Resort", "Stevens Pass Ski Area" , "Mt. Baker" , "etc")
      ),
      
      # To select color for graph
      radioButtons(
        "col", "Select color for graph:", choices = c("Red" = 'red', "Green" = 'green', "Blue" = 'blue', "Black" = 'black'), selected = "black"
      ),
      
      # Calender data selection interface
      dateInput(
        "date", label = h3("Date input"), value = "2018-03-06"
      )
    ),
    
    mainPanel(
      
      uiOutput("output"),
      
      plotOutput("plot")
    )
  )
)



my.server <- function(input, output) {
  
  
  
  user_input <- reactive({ input$resort })
  
  
  output$output <- renderUI({
    
    # if statement to select correct URL
    if (identical(user_input(), "Snoqualmie Ski Resort")) {
      link = "http://www.summitatsnoqualmie.com/"
    } else if (identical(user_input(), "Stevens Pass Ski Area")) {
      link = "https://www.stevenspass.com/site"
    } else if (identical(user_input(), "Mt. Baker")) {
      link = "http://www.mtbaker.us/"
    } else {
      link = "http://www.google.com"
    }
    
    url <- reactive({
      a(paste(input$resort, "Homepage"), href=link)
    })
    
    # This adds a hyperlink to the correct webpage
    tagList(paste("URL Link to "), url())
  })
  
  # Plot to visualize snowfall during the day (currently using example data, will need to replace with API data)
  output$plot <- renderPlot({
    v <- c(3, 1, 4, 2, 5)
    plot(v, type = "l", col = input$col, xlab = "Time", ylab = "Snowfall", main = "Snowfall During the Day", lwd = 2)
  })
  
}

shinyApp(ui = my.ui, server = my.server)

