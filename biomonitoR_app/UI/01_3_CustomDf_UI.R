fluidRow(
  
  ##############
  # Right Side #
  ##############
  
  column(width = 4 ,
         box(width = NULL, solidHeader = TRUE,
             HTML("<h3>Custom Reference Datset</h3> 
                  
                  To create a <i><b>Custom Reference Dataset</b></i>, users can import their own personal dataset in which each column represents a taxonomic rank (e.g., Phylum, Family, Genus, Species) selecting the option 'Create your Custom reference dataset'. In this way, the dataset will be converted into a Reference dataset functional for biomonitoR. Please see the Help panel for further details.

                  <br>
                  <br>
                                           
<b>Please Note</b>: If a community-type reference dataset (e.g., macroinvertebrates dataset, already present in <i><b>biomonitoR</b></i>) is also selected, it will be added to the new Custom Reference Dataset."
                  )
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