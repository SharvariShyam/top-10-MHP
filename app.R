
library(gdata)
library(dplyr)
library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
   titlePanel(
     h1("Top 10 HCP", align = "center")
    ),
   sidebarLayout(
    
     sidebarPanel(
       
           
     fileInput("file1", "Choose CSV File",
                multiple = TRUE,
                 accept = c("text/csv",
                          "text/comma-separated-values,text/plain",
                        ".csv")),
      # fileInput("file1", label = h3("File input")),
       
       tags$hr(),
       
           sliderInput("range", 
                       label = "Month:",
                       min = 1, max = 12, value = 5)
        
     ),
     mainPanel(
       h1("Hello!!"),
       tags$hr(),
       textOutput("min_max"),
       textOutput("contents"),
       verbatimTextOutput("value")
     )
   )
  
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$min_max <- renderText({ 
    mth<- input$range[1]
    paste("You have chosen a month",mth)
  })
  
  
  output$contents <- renderText({    
    if(is.null(input$file1))return()
    inFile <- input$file1
    data<-read.csv(inFile$datapath)
    print(summary(data))
    
  })
  
  #output$contents <- renderTable({
    
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, head of that data file by default,
    # or all rows if selected, will be shown.
    
   #req(input$file1)
   
    #fn<-input$file1
  #df<-read.csv(fn)
  #head(df)
    
  #})
  
 # output$value <- renderPrint({
  #  str(input$file)
  #})
  
}

# Run the application 
shinyApp(ui = ui, server = server)

