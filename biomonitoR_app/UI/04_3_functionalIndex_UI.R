fluidRow(
  
  ##############
  # Right side #
  ##############
  
  column(width = 4,
         box(width = NULL, solidHeader = TRUE,
             HTML("<h3> <b>Functional Indices</b> </h3> 
                          This panel ...")),
         
         # Functional dispersion ----
         box(title = "Functional dispersion", width = NULL, solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
             checkboxInput("funDisp", label = "Functional dispersion", value = FALSE), # Functional dispersion
             selectInput("funDispLev", "Taxa level", 
                         choices = c("Family" = "Family", 
                                     "Genus" = "Genus", 
                                     "Species" = "Species", 
                                     "Taxa" = "Taxa"), 
                         selected = "Taxa", multiple = FALSE),
             selectInput("funDispType", "Variable type", 
                         choices = c("Fuzzy" = "F",
                                     "Continuous" = "C"), 
                         selected = "F", multiple = FALSE),
             checkboxInput("traitSelDisp", label = "Trait selection", value = FALSE), 
             # col_blocks
             numericInput("nbdimDisp", "Multispace dimension", 2),
             selectInput("distanceDisp", "Functional distance", 
                         choices = c("Euclidean" = "euclidean",
                                     "Gower" = "gower"), 
                         selected = "euclidean", multiple = FALSE),
             checkboxInput("traitSelDisp", label = "Trait selection", value = FALSE), 
             checkboxInput("zerodist_rmDisp", label = "Zero distance", value = FALSE),
             selectInput("correctionDisp", "Correction method", 
                         choices = c("None" = "none",
                                     "Lingoes" = "lingoes", 
                                     "Cailliez" = "cailliez", 
                                     "Square Root" = "sqrt", 
                                     "Quasi" = "quasi"), 
                         selected = "none", multiple = FALSE),
             checkboxInput("traceBDisp", label = "trace B", value = FALSE),
             HTML("Fine tuning parameters"),
             numericInput("max_nbdimDisp", "Max n. dimensions", 15),
             selectInput("precDisp", "Prec",choices = c("Qt" = "Qt",
                                                        "Qj" = "Qj"), 
                         selected = "Qj", multiple = FALSE),
             numericInput("tolDisp", "Tolerance", .0000001),
             checkboxInput("corZeroDisp", label = "cor.zero", value = TRUE)
             ),
         
         # Functional eveness ----
         box(title = "Functional evenness", width = NULL, solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
             checkboxInput("funEve", label = "Functional evenness", value = FALSE), # Functional evenness
             selectInput("funEveLev", "Taxa level", 
                         choices = c("Family" = "Family", 
                                     "Genus" = "Genus", 
                                     "Species" = "Species", 
                                     "Taxa" = "Taxa"), 
                         selected = "Taxa", multiple = FALSE),
             selectInput("funEveType", "Variable type", 
                         choices = c("Fuzzy" = "F",
                                     "Continuous" = "C"), 
                         selected = "F", multiple = FALSE),
             checkboxInput("traitSelDisp", label = "Trait selection", value = FALSE), 
             # col_blocks
             numericInput("nbdimEve", "Multispace dimension", 2),
             selectInput("distanceEve", "Functional distance", 
                         choices = c("Euclidean" = "euclidean",
                                     "Gower" = "gower"), 
                         selected = "euclidean", multiple = FALSE),
             checkboxInput("zerodist_rmEve", label = "Zero distance", value = FALSE),
             selectInput("correctionEve", "Correction method", 
                         choices = c("None" = "none",
                                     "Lingoes" = "lingoes", 
                                     "Cailliez" = "cailliez", 
                                     "Square Root" = "sqrt", 
                                     "Quasi" = "quasi"), 
                         selected = "none", multiple = FALSE),
             checkboxInput("traceBEve", label = "trace B", value = FALSE),
             HTML("Fine tuning parameters"),
             numericInput("max_nbdimEve", "Max n. dimensions", 15),
             selectInput("precEve", "Prec",choices = c("Qt" = "Qt",
                                                        "Qj" = "Qj"), 
                         selected = "Qj", multiple = FALSE),
             numericInput("tolEve", "Tolerance", .0000001),
             checkboxInput("corZeroEve", label = "cor.zero", value = TRUE)
             ),
         
         # Functional redundancy ----
         box(title = "Functional redundancy", width = NULL, solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
             checkboxInput("funRed", label = "Functional redundancy", value = FALSE), # Functional redundancy
             ),
         
         # Functional richness ----
         box(title = "Functional richness", width = NULL, solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
             checkboxInput("funRich", label = "Functional richness", value = FALSE), # Functional richness
             )
         
  ),
  
  #############
  # Left side #
  #############
  column(width = 8,
         conditionalPanel("input.funDisp == 1",
                          box(width = NULL, solidHeader = TRUE,
                              HTML("<h3> Functional dispersion </h3>"), 
                              DTOutput("tbl_f_disp"),
                              downloadButton("download_f_disp", label = "Download Table")
                              )
                          ),
         
         conditionalPanel("input.funEve == 1",
                          box(width = NULL, solidHeader = TRUE,
                              HTML("<h3> Functional evenness </h3>"), 
                              DTOutput("tbl_f_eve"),
                              downloadButton("download_f_eve", label = "Download Table")
                              )
                          )
         
         )
  
)