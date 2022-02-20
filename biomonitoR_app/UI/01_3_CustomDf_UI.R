fluidRow(
  
  ##############
  # Right Side #
  ##############
  
  column(width = 4 ,
         box(width = NULL, solidHeader = TRUE,
             HTML("<h3> <b>Custom Reference Datset</b> </h3> 
                  To create your Custom Reference Dataset, you can import a personal 
                  dataset in which each column represent a taxonomic rank 
                  (e.g., Phylum, Family, Genus, Species) and select the option 
                  'Create your Custom reference dataset'. In this way, your dataset 
                  will be converted into a Reference dataset functional from biomonitoR.
                  See the <b>Help</b> panel for further details.
                         
                  <h5> Note: Selecting a reference community to your data 
                  will be added the entire dataset provided by bomonitoR corresponding 
                  to the reference community chosen. </h3>")
             ),
         # Import dataset and set main parameters
         box(title = "Create your Custom RND", width = NULL, solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
             HTML("Select your data <h5> Data can be loaded in <b>.xlsx</b>, <b>.csv</b>, or <b>.txt</b> formats.</h5>"),
             fileInput("fileCRD", label = NULL),
             tags$hr(),
             HTML("Select your reference community"),
             selectInput("communitytypeCRD", "", choices = c( "None" = "none",
                                                              "Macroinvertebrates" = "mi", 
                                                             "Macrophytes" = "mf", 
                                                             "Fish" = "fi", 
                                                             "Custom" = "cu"), 
                         selected = "none", multiple = FALSE),
             checkboxInput("runCRD", label = "Create your Custom RND", value = FALSE)
             )
         ),
  
  
  #############
  # Left Side #
  #############
  
  column(width = 8,
         uiOutput("tbl_boxInputTree"),
         uiOutput("tbl_boxCRD")
         )
  )