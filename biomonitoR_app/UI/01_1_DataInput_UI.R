fluidRow(
  
  ##############
  # Right side #
  ##############
  
  column(width = 4 ,
         box(width = NULL, solidHeader = TRUE,
             HTML("<h3> <b>Data Input & Management</b> </h3> 
                  To import your dataset it is important: <br><br>
<li>
Name the first column 'Taxa'. This column has to be contain the nomenclature of your taxa; 
</li>

<li>
Name the other columns with the sample name (e.g. locality). These columns have to be contain abundance or presence/absence data.        
</li>                  
<br>
<h5> Note: biomonitoR-app can use three pre-setted reference datasets: macroinvertebrates, macrophytes, and fish. If you want to import your custom reference dataset, please follow the instructions present in the <b>Help</b>. </h3>")),
         # Import dataset and set main parameters
         box(title = "Load file - Community data", solidHeader = FALSE, width = NULL, collapsible = TRUE, collapsed = TRUE,
             #radioButtons("filetype", "", choices = c("xlsx","csv","txt"), inline = TRUE),
             HTML("Select your data"),
             HTML("<h5> Data can be loaded in <b>.xlsx</b>, <b>.csv</b>, or <b>.txt</b> formats.</h5>"),
             fileInput("file1", label = ""),
             tags$hr(),
             HTML("Select your reference community"),
             selectInput("communitytype", "", choices = c("Macroinvertebrates" = "mi", 
                                                          "Macrophytes" = "mf", 
                                                          "Fish" = "fi", 
                                                          "Custom" = "cu"), 
                         selected = "mi", multiple = FALSE),    
             tags$hr(),
             HTML("Select your data type"),
             selectInput("abutype", "", choices = c("Abundance" = "sum", 
                                                    "Presence/Absence" = "bin"), 
                         selected = "sum", multiple = FALSE),
                         checkboxInput("toBin", label = "Convert abundance to presence-absence data", value = FALSE) # <- Transforms abundance to presence-absence.
         ),
         
         # Import Custom reference dataframe                 
         conditionalPanel("input.communitytype == 'cu'", 
                          box(title = "Load file - Custom reference dataframe", solidHeader = FALSE, width = NULL,
                              #radioButtons("filetypeCustom", "", choices = c("xlsx","csv","txt"), inline = TRUE),
                              HTML("Select your data"),
                              fileInput("file2", label = NULL)
                          )
         ),
         
         # Data Management --------------------------------------------------------------
         
         # Convert to Vegan format ----
         box(title = "Convert to vegan format", solidHeader = FALSE, width = NULL, collapsible = TRUE, collapsed = TRUE,
             
             HTML("<h4> <b>vegan</b> is an R package provides several functions for descriptive community ecology. </h4> 
                  <h5>To convert your dataset from <b>biomonitoR App</b> to <b>vegan</b> format, 
                  you need to select the taxonomic level and then activate Run.
                  <br>
                  <br> 
                  More information about the <b>vegan</b> package is available at
         <a href='https://cran.r-project.org/web/packages/vegan/vegan.pdf' target='_blank'> R CRAN pdf </a>
         or at <a href='https://github.com/vegandevs/vegan' target='_blank'> GitHub </a> </h5>"),
             
             HTML("Select the taxonomic level"),
             selectInput("taxLeVegan", "", choices = c("Phylum" = "Phylum", 
                                                       "Class" = "Class", 
                                                       "Subclass" = "Subclass", 
                                                       "Order" = "Order", 
                                                       "Family" = "Family", 
                                                       "Subfamily" = "Subfamily", 
                                                       "Tribus" = "Tribus", 
                                                       "Genus" = "Genus", 
                                                       "Species" = "Species", 
                                                       "Subspecies" = "Subspecies", 
                                                       "Taxa" = "Taxa"), 
                         selected = "Taxa", multiple = FALSE),
             # actionButton("veganFormat", "Run")
             checkboxInput("veganFormat", label = HTML("Run"), value = FALSE),
         ),

box(title = "Convert to biotic format", solidHeader = FALSE, width = NULL, collapsible = TRUE, collapsed = TRUE,
    
    HTML("<h4> <b>biotic</b> is an R package for calculating a range of UK freshwater invertebrate biotic indices. </h4>
         <h5> To convert your dataset from <b>biomonitoR App</b> to <b>biotic</b> format, activate Run. 
         <br> 
         <br> 
         More information about the <b>biotic</b> package is available at
         <a href='https://cran.r-project.org/web/packages/biotic/biotic.pdf' target='_blank'> R CRAN pdf </a>
         or at <a href='https://github.com/robbriers/biotic' target='_blank'> GitHub </a> </h5>"),

    checkboxInput("bioticFormat", label = HTML("Run"), value = FALSE),
),



         
         # # Remove taxa ----
         # # Which taxon/a do you u want to remove from your dataset?
         # box(title = "Remove taxa", solidHeader = FALSE, width = NULL, collapsible = TRUE, collapsed = TRUE,
         #     selectizeInput("removeTaxa", "Select taxa to exclude from your dataset", 
         #                    choices = NULL, multiple = TRUE)
         # )
         
  ),
  
  
  #############
  # Left side #
  #############
  
  column(width = 8,
         uiOutput("tbl"),
         uiOutput("tblVegan"),
         uiOutput("tblBiotic")
         #uiOutput("tblRmTaxa")
  )
)
