
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
  

  plot<-reactive({
    ordered<-inFile[order(as.Date(inFile$Date.Of.Procedure,"%Y-%m-%d")),]
    aug<-subset(ordered,format.Date(Date.Of.Procedure,"%m")=="08")
    augcount<-as.data.frame(table(aug$Doctor.Name))
    aug<-group_by(aug,Doctor.Name)
    umm<-summed[with(summed,order(-summed$x)),]
    umm<-top_n(umm,10,x)
    umm$Category<-factor(umm$Category, levels = rev(levels(umm$Category)))
    
  })
}


# Run the application 
shinyApp(ui = ui, server = server)

