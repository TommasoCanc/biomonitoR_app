fluidRow(
  column(width = 4,
         box(width = NULL, solidHeader = TRUE,
             HTML("<h3> <b>Diversity Indices</b> </h3> 
                          This panel ...")),
         box(width = NULL, solidHeader = TRUE,
             HTML("What do you want to calculate?"),
             checkboxInput("diverityIndex", label = "Diversity Index", value = FALSE), # <- Diversity index
             checkboxInput("diverityPCA", label = "Principal component analysis", value = FALSE), # <-  PCA
             checkboxInput("diverityScatter", label = "Scatter plot", value = FALSE))
  ),
  
  column(width = 8,
         
         conditionalPanel("input.diverityIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              HTML("<h3> Diversity Indices </h3>"),
                              HTML("To calculate diversity indices, please select between the four taxonomic levels below."),
                              tags$hr(),
                              radioButtons("div_taxlev", "", choiceNames = c("Taxa"),choiceValues = c("Taxa"), selected = "Taxa", inline = TRUE),
                              DTOutput("tbl_div"),
                              HTML("<h5> Note: If richness is below 3, the indices can not be calculated. </h5>"),
                              downloadButton("download_div", label = "Download Table")
                          ),
                          tags$hr()),
         
         conditionalPanel("input.diverityPCA == 1",
                          box(width = NULL, solidHeader = TRUE,           
                              HTML("<h3> Diversity Indices PCA </h3>
                                 Dare info sulla pca e come usarla"),
                              tags$hr(),
                              checkboxGroupInput("div_taxPCA", "", choiceNames = c("Family", "Genus", "Species", "Taxa"), 
                                                 choiceValues = c("Family", "Genus", "Species", "Taxa"), selected = "Taxa", inline = TRUE),
                              uiOutput("div_taxlev_pca")),
                          plotlyOutput("div_pca")),
         
         conditionalPanel("input.diverityScatter == 1",
                          box(width = NULL, solidHeader = TRUE,
                              HTML("<h3> Diversity Indices Scatter plot </h3>
                                 Dare info sulla scatter plot e come interpretarlo"),
                              tags$hr(),
                              selectizeInput("var_div_pairs", "Select an index for the scatter plot", choices = character(), multiple = FALSE),
                              column(4,style=list("padding-right: 5px;"),
                                     HTML("<b>Taxonomic correlation levels</b> <br>
                               Please select two taxonomy levels to plot the graph."),
                               checkboxGroupInput("div_taxlev_pair", "", choiceNames = c("Family", "Genus", "Species", "Taxa"), 
                                                  choiceValues = c("Family", "Genus", "Species", "Taxa"), selected = NULL, inline = TRUE),
                               uiOutput("div_taxlev_pair")),
                              column(8, style=list("padding-right: 5px;"),
                                     HTML("<b>Correlation type</b>"),
                                     radioButtons("corr_div", "", choices = c("pearson", "spearman"), inline = TRUE)
                              ),
                              tags$hr(),
                              verbatimTextOutput("console"),
                              plotlyOutput("ggpairs_div")
                          ))
  )
)