fluidRow(
  column(width = 4,
         box(width = NULL, solidHeader = TRUE,
             HTML("<h3> <b>Diversity Indices</b> </h3> 
                          This panel provides useful functions for data exploration analyses.")),
         
         # Richness ----
         box(title = "Taxa richness", width = NULL, solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
             HTML("<h4> Taxa richness is the measure of the number of taxa in a given sample. 
                  In this panel you can calculate this measure at diferent taxonomic levels. <br> 
                  Once you select the taxonomic level desired, click to <b>Run</b>.</h4>"),
             selectInput("richness.tax_lev", "Taxa level", 
                         choices = c("Family" = "Family", 
                                     "Genus" = "Genus", 
                                     "Species" = "Species", 
                                     "Taxa" = "Taxa"), 
                         selected = "Taxa", multiple = FALSE),
             checkboxInput("richIndex", label = "Run", value = FALSE) # <- Taxa richness
             ),
         
         # Diversity indices ----
         box(title = "Diversity Index", width = NULL, solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
             HTML("<h4>A diversity index is a helpful measure to quantify how many differences exist between two or more datasets.
                  In this panel, you can calculate several diversity indices at different taxonomic levels simultaneously. <br>
                  Once you select the taxonomic level desired, click to <b>Run</b>.</h4>
                  <h5> <b>shannon</b>: Shannon; <b>berpar</b>: Berger-Parker; <b>brill</b>: Brillouin; <b>invberpar</b>: Inverse Berger-Parker;
                  <b>invsimpson</b>: Inverse Simpson; <b>margalef</b>: Margalef diversity; <b>mcintosh</b>: McIntosh dominance;
                  <b>menhinick</b>: Menhinick; <b>pielou</b>: Pielou's evenness; <b>simpson</b>: Simpson's Index of Diversity;
                  <b>esimpson</b>: Simpson's evenness; <b>fisher</b>: Fisher alpha</h5>"),
             HTML("<h5> Note: If richness is below 3, the indices can not be calculated. </h5>"),
             selectInput("div.tax_lev", "Taxa level", choices = c("Taxa"), 
                         selected = "Taxa", multiple = FALSE),
             checkboxInput("diverityIndex", label = "Run", value = FALSE) # <- Run diversity indices
         ),
         
         # PCA ----
         box(title = "Principal component analysis", width = NULL, solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
             HTML("<h4> Principal Component Analysis (PCA) is a statistical technique 
                  that reduces the dimensionality of a dataset, projecting the data into a Cartesian system 
                  with the lowest number of the axis as possible (principal components), minimizing at the 
                  same time the information loss. <br>
                  In this panel, you can calculate the PCA of a set of diversity indices. 
                  The nearest points in the space indicate a higher correlation. 
                  In contrast, opposite points indicate an inverse relationship.
                  PCA can be calculated for different taxonomic levels. <br>
                  Once you select the taxonomic level desired, click to <b>Run</b>. </h4>"),
             selectInput("div.taxPCA", "Taxa level", choices = c("Taxa"), 
                         selected = "Taxa", multiple = TRUE),
             checkboxInput("diverityPCA", label = "Run", value = FALSE) # <- Run PCA
         ),
         
         # Scatter plot ----
         box(title = "Scatter plot & correlation", width = NULL, solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
             HTML("<h4> This panel allow us to visualize the relationship between the index results and two taxonomic levels. <br>
High correlation indicates....</h4>"),
             selectizeInput("var_div_pairs", "Select an index", choices = character(), multiple = FALSE),
             selectInput("div_taxlev_pair", "Taxa level", choices = c("Taxa"), 
                         selected = "Taxa", multiple = TRUE),
             radioButtons("corr_div", "Select correlation type", choices = c("pearson", "spearman"), inline = TRUE),
             checkboxInput("diverityScatter", label = "Run", value = FALSE) # <- Run Scatter
         )
  ),
  
  column(width = 8,
         
         # Richness ----
         conditionalPanel("input.richIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              HTML("<h3> Taxa richness </h3>"),
                              DTOutput("tbl_richness"),
                              uiOutput("download_richness")
                              )
                          ),
         
         # Diversity indies ----
         conditionalPanel("input.diverityIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              HTML("<h3> Diversity Indices </h3>"),
                              DTOutput("tbl_div"),
                              downloadButton("download_div", label = "Download Table")
                              )
                          ),
         
         # PCA ----
         conditionalPanel("input.diverityPCA == 1",
                          box(width = NULL, solidHeader = TRUE,
                              HTML("<h3> Principal Component Analysis </h3>"),
                              uiOutput("div_taxlev_pca"),
                              plotlyOutput("div_pca")
                              )
                          ),
         
         # Scatter plot ----
         conditionalPanel("input.diverityScatter == 1",
                          box(width = NULL, solidHeader = TRUE,
                              verbatimTextOutput("console"),
                              plotlyOutput("ggpairs_div")
                          ))
  )
)