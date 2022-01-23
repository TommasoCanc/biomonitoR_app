fluidRow(
  
  ##############
  # Right Side #
  ##############
  
  column(width = 4 ,
         box(width = NULL, solidHeader = TRUE,
             HTML("<h3> <b>Custom Reference Datset</b> </h3> 
                          To import your dataset in the biomonitoR-app, it is important to follow two simple rules: <br><br>
                       
                       <h5> Note: biomonitoR-app can use three pre-setted reference datasets: 
                       macroinvertebrates, macrophytes, and fish.
                       If you want to import your custom reference dataset, please follow the 
                       instructions present in the <b>Help</b>. </h3>")),
         # Import dataset and set main parameters
         box(width = NULL, solidHeader = TRUE,
             HTML("Create your Custom reference dataset"),
             fileInput("fileCRD", label = NULL),
             tags$hr(),
             checkboxInput("runCRD", label = "Do you want to create your Custom reference dataset?", value = FALSE),
             #HTML("Select your reference community"),
             radioButtons("communitytypeCRD", "Select your reference community", choiceNames = c("Macroinvertebrates", "Macrophytes", "Fish", "None") , 
                          choiceValues = c( "mi", "mf", "fi", "none"), inline = FALSE, selected = "none")),
         
         box(title = "Dou you want to download your Custom Reference Dataset?", solidHeader = FALSE, width = NULL,
             checkboxInput("downloadCRD", label = "Download", value = FALSE)
         )
  ),
  
  
  #############
  # Left Side #
  #############
  
  column(width = 8,
         uiOutput("tbl_boxInputTree"),
         uiOutput("tbl_boxCRD"),
         #box(DTOutput("tblCRD"), width = NULL),
         conditionalPanel("input.downloadCRD == 1",
                          box(downloadButton("download_CRD", label = "Download Table"), width = NULL))
  )
)