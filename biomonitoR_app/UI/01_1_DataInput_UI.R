##############
# Right side #
##############

fluidRow(
  column(width = 4 ,
         box(width = NULL, solidHeader = TRUE,
             HTML("<h3> <b>Data Input & Management</b> </h3> 
                          To import your dataset into biomonitoR-app, it is important to follow two simple steps: <br>
<br>
<b>1)</b> The first column of your dataset needs to be titled <i>
  <b>'Taxa'</b>
</i> and it has to contain the nomenclature of your taxa; <br>
<br>
<b>2)</b> The other columns of your dataset need to contain abundance or presence/absence data, and they have to be named with the sampling point localities. <br>
<br>
<h5> Note: biomonitoR-app can use three pre-setted reference datasets: macroinvertebrates, macrophytes, and fish. If you want to import your custom reference dataset, please follow the instructions present in the <b>Help</b>. </h3>")),
         # Import dataset and set main parameters
         box(title = "Load file - Community data", solidHeader = FALSE, width = NULL, collapsible = TRUE, collapsed = TRUE,
             #radioButtons("filetype", "", choices = c("xlsx","csv","txt"), inline = TRUE),
             HTML("Select your data <h5> Data can be loaded in <b>.xlsx</b>, <b>.csv</b>, or <b>.txt</b> formats.</h5>"),
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
                         checkboxInput("toBin", label = "Do you want transforms abundance to presence-absence?", value = FALSE) # <- Transforms abundance to presence-absence.
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
             
             HTML("<h5> <b>vegan</b> is an R package widely used in community ecological studies (see bibliography). <br><br>
To convert your dataset from <b>biomonitoR</b> format (<i>long</i>) to <b>vegan</b> format (<i>wide</i>), you can set the taxonomic level to operate the transformation and check the box Run.
                  </h5>"),

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
             checkboxInput("veganFormat", label = HTML("Run"), value = FALSE),
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
         #uiOutput("tblRmTaxa")
  )
)