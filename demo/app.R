## Only run examples in interactive R sessions
if (interactive()) {
  
  ui <- fluidPage(
    sidebarLayout(
      sidebarPanel(
        fileInput("file1", "Choose CSV File",
                  accept = c(
                    "text/csv",
                    "text/comma-separated-values,text/plain",
                    ".csv")
        ),
        tags$hr(),
        checkboxInput("header", "Header", TRUE)
      ),
      mainPanel(
        tableOutput("contents"),
      )
    )
  )
  
  server <- function(input, output) {
    
    #define reactive variabel 
    v <- reactiveValues(data = NULL)
    mydata<-reactive({
      v$data
    })
    
    
    #makes our csv input into v$data
    observeEvent(input$file1, {
      v$data <- ({
        inData <- input$file1
        if (is.null(inData)){ return(NULL) }
        read.csv(inData$datapath, header = TRUE, sep=",")
      })
      
    }) 
    
    #making the output the head of our data
    output$contents <- renderTable({
      head(v$data)
    })
  }
  shinyApp(ui, server)
}
