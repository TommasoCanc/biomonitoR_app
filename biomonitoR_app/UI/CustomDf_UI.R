fluidRow(
  column(width = 4 ,
         box(width = NULL, solidHeader = TRUE,
             HTML("<h3> <b>Custom Reference Datset</b> </h3> 
                          To import your dataset in the biomonitoR-app, it is important to follow two simple rules: <br><br>
                       <b>1)</b> The first column of your dataset has to contain the taxa names, and it has to be named <i><b>'Taxa'</b></i>; <br><br>
                       <b>2)</b> The other columns of your dataset can contain abundance or presence/absence data, and they have to 
                          be named with the sampling point stations. <br> <br>
                       
                       <h5> Note: biomonitoR-app can use three pre-setted reference datasets: 
                       macroinvertebrates, macrophytes, and fish.
                       If you want to import your custom reference dataset, please follow the 
                       instructions present in the <b>Help</b>. </h3>")),
         # Import dataset and set main parameters
         box(title = "Load file - Select your data format", solidHeader = FALSE, width = NULL,
             radioButtons("filetypeCRD", "", choices = c("xlsx","csv","txt"), inline = TRUE),
             tags$br(),
             HTML("Select your Custom reference dataset"),
             fileInput("fileCRD", label = NULL),
             tags$hr(),
             HTML("Select your reference community"),
             radioButtons("communitytypeCRD", "", choiceNames = c("macroinvertebrates", "macrophytes", "fish", "none") , choiceValues = c( "mi", "mf", "fi", "none"), inline = FALSE, selected = "none")),
         
         box(title = "Dou you want to download your Custom Reference Dataset?", solidHeader = FALSE, width = NULL,
             checkboxInput("downloadCRD", label = "Download", value = FALSE)
         )
  ),
  
  column(width = 8,
         uiOutput("boxCRD"),
         #box(DTOutput("tblCRD"), width = NULL),
         conditionalPanel("input.downloadCRD == 1",
                          box(downloadButton("download_CRD", label = "Download Table"), width = NULL))
  )
)