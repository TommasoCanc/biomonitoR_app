fluidRow(
  column(width = 4 ,
         box(width = NULL, solidHeader = TRUE,
             HTML("<h3> <b>Data Input</b> </h3> 
                          To import your dataset in the biomonitoR-app, it is important to follow two simple rules: <br><br>
                       <b>1)</b> The first column of your dataset has to contain the taxa names, and it has to be named <i><b>'Taxa'</b></i>; <br><br>
                       <b>2)</b> The other columns of your dataset can contain abundance or presence/absence data, and they have to 
                          be named with the sampling point stations. <br> <br>
                       
                       <h5> Note: biomonitoR-app can use three pre-setted reference datasets: 
                       macroinvertebrates, macrophytes, and fish.
                       If you want to import your custom reference dataset, please follow the 
                       instructions present in the <b>Help</b>. </h3>")),
         # Import dataset and set main parameters
         box(title = "Load file - Community data", solidHeader = FALSE, width = NULL,
             #radioButtons("filetype", "", choices = c("xlsx","csv","txt"), inline = TRUE),
             HTML("Select your data"),
             fileInput("file1", label = NULL),
             HTML("<h5> Data can be loaded in <b>xlsx</b>, <b>csv</b>, or <b>txt</b> formats.</h5>"),
             tags$hr(),
             HTML("Select your reference community"),
             radioButtons("communitytype", "", choiceNames = c("macroinvertebrates", "macrophytes", "fish", "custom") , choiceValues = c( "mi", "mf", "fi", "cu"), inline = FALSE),
             tags$hr(),
             HTML("Select your data type"),
             radioButtons("abutype", "", choiceNames = c("Abundance", "Presence/Absence"), choiceValues = c("sum","bin"), inline = TRUE),
             checkboxInput("toBin", label = "Do you want transforms abundance to presence-absence?", value = FALSE), # <- Transforms abundance to presence-absence.
         ),
         
         # Import Custom reference dataframe                 
         conditionalPanel("input.communitytype == 'cu'", 
                          box(title = "Load file - Custom reference dataframe", solidHeader = FALSE, width = NULL,
                              #radioButtons("filetypeCustom", "", choices = c("xlsx","csv","txt"), inline = TRUE),
                              HTML("Select your data"),
                              fileInput("file2", label = NULL)
                          )
         )
  ),
  
  column(width = 8,
         uiOutput("tbl")
  )
)