fluidRow(
  column(width = 4,
         box(width = NULL, solidHeader = TRUE,
             HTML("<h3> <b>Biomonitoring Indices</b> </h3> 
                          This panel ...")),
         box(width = NULL, solidHeader = TRUE,
             HTML("What do you want to calculate?"),
             checkboxInput("bmwpIndex", label = "Biological Monitoring Working Party (BMWP)", value = FALSE), # <- BWMP
             checkboxInput("asptIndex", label = "Average Score Per Taxon (ASPT)", value = FALSE), # <- ASPT
             checkboxInput("psiIndex", label = "Proportion of Sediment-sensitive Invertebrates index (PSI)", value = FALSE), # <- psi
             checkboxInput("epsiIndex", label = "Empyrically-weighted Proportion of Sediment-sensitive Invertebrates (ePSI)", value = FALSE), # <- epsi
             checkboxInput("eptIndex", label = "EPT richness", value = FALSE), # <- ept
             checkboxInput("eptdIndex", label = "log10 of selected EPTD", value = FALSE), # <- eptd
             checkboxInput("goldIndex", label = "1 - GOLD", value = FALSE), # <- gold
             checkboxInput("lifeIndex", label = "Life Index", value = FALSE), # <- life
             checkboxInput("whptIndex", label = "Whalley Hawkes Paisley Trigg", value = FALSE) # <- whpt
         )
  ),
  
  column(width = 8,
         conditionalPanel("input.bmwpIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              HTML("<h3> Biological Monitoring Working Party (BMWP) </h3>"),
                              HTML("This function calculates the Biological Monitoring Working Party index 
                                           following Armitage et al. (1983), Davy-Bowker et al. (2007) and 
                                           Alba-Tercedor & Sanchez-Ortega (1988) implementations."),
                              tags$hr(),
                              HTML("To calculate diversity indices, please select the implementation method."),
                              radioButtons("bmwp_method", "", choiceNames = c("Armitage", "UK-davy-bowker", "ES-magrama", "IT-buffagni"), 
                                           choiceValues = c("a", "uk", "spa", "ita"), 
                                           selected = "a", inline = TRUE),
                              checkboxInput("bmwpAgg", label = "Aggregation", value = FALSE), # <- agg parameter of BWMP
                              #checkboxInput("bmwpTrace", label = "Trace", value = FALSE), # <- traceB parameter of BWMP
                              selectizeInput("bmwpExceptions", "Select taxa to exclude from the index calculation", 
                                             choices = NULL, multiple = TRUE),
                              DTOutput("tbl_bmwp"),
                              uiOutput("download_bmwp")
                          )
         ),
         
         conditionalPanel("input.asptIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              HTML("<h3> Average Score Per Taxon (ASPT) </h3>"),
                              HTML("This function calculates the Average Score Per Taxon index following Armitage et al. (1983), 
                                           Davy-Bowker et al. (2007) and Alba-Tercedor & Sanchez-Ortega (1988) implementations."),
                              tags$hr(),
                              HTML("To calculate diversity indices, please select the implementation method."),
                              radioButtons("aspt_method", "", choiceNames = c("Armitage", "UK-davy-bowker", "ES-magrama", "IT-buffagni"), 
                                           choiceValues = c("a", "uk", "spa", "ita"), 
                                           selected = "a", inline = TRUE),
                              checkboxInput("asptAgg", label = "Aggregation", value = FALSE), 
                              #checkboxInput("bmwpTrace", label = "Trace", value = FALSE), 
                              selectizeInput("asptExceptions", "Select taxa to exclude from the index calculation", 
                                             choices = NULL, multiple = TRUE),
                              DTOutput("tbl_aspt"),
                              uiOutput("download_aspt")
                              # downloadButton("download_aspt", label = "Download Table")
                          )
         ),
         
         conditionalPanel("input.psiIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              HTML("<h3> Proportion of Sediment-sensitive Invertebrates index (PSI) </h3>"),
                              HTML("This function calculates the Proportion of Sediment-sensitive Invertebrates index 
                                           (PSI) according to the most recent version used in UK."),
                              tags$hr(),
                              # HTML("Log abundance categories (Extence et al., 2013)."),
                              # radioButtons("psi_abucl", "", choiceNames = c("1", "9", "99", "999"), 
                              #              choiceValues = c(1, 9, 99, 999), 
                              #              selected = "a", inline = TRUE),
                              checkboxInput("psiAgg", label = "Aggregation", value = FALSE), 
                              #checkboxInput("bmwpTrace", label = "Trace", value = FALSE), 
                              selectizeInput("psiExceptions", "Select taxa to exclude from the index calculation", 
                                             choices = NULL, multiple = TRUE),
                              DTOutput("tbl_psi"),
                              uiOutput("download_psi")
                          )
         ),
         
         conditionalPanel("input.epsiIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              HTML("<h3> Empyrically-weighted Proportion of Sediment-sensitive Invertebrates (ePSI) </h3>"),
                              HTML("This function calculates the Empyrically-weighted Proportion of Sediment-sensitive Invertebrates index 
                                           (ePSI) according to the most recent version used in UK."),
                              tags$hr(),
                              # HTML("Log abundance categories (Extence et al., 2013)."),
                              # radioButtons("psi_abucl", "", choiceNames = c("1", "9", "99", "999"), 
                              #              choiceValues = c(1, 9, 99, 999), 
                              #              selected = "a", inline = TRUE),
                              checkboxInput("epsiAgg", label = "Aggregation", value = FALSE), 
                              #checkboxInput("bmwpTrace", label = "Trace", value = FALSE), 
                              selectizeInput("epsiExceptions", "Select taxa to exclude from the index calculation", 
                                             choices = NULL, multiple = TRUE),
                              DTOutput("tbl_epsi"),
                              uiOutput("download_epsi")
                          )
         ),
         
         conditionalPanel("input.eptIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              HTML("<h3> EPT richness </h3>"),
                              HTML("This function calculates the richness of Ephemeroptera, Plecotera and Trichoptera 
                                           (EPT) taxa at the desired taxonomic level."),
                              tags$hr(),
                              radioButtons("ept_taxLev", "", choiceNames = c("Family", "Genus", "Species", "Taxa"), 
                                           choiceValues = c("Family", "Genus", "Species", "Taxa"), 
                                           selected = "Taxa", inline = TRUE),
                              DTOutput("tbl_ept"),
                              uiOutput("download_ept")
                          )
         ),
         
         conditionalPanel("input.eptdIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              HTML("<h3> log10 of selected EPTD </h3>"),
                              HTML("This function calculates the log10(Sel_EPTD + 1) metric, 
                                           where EPTD stands for Ephemeroptera, Plecoptera, Trichoptera and Diptera."),
                              tags$hr(),
                              # eptd_families = NULL ?
                              numericInput("epdt_logBase", "log Base", 10, width = '10%'),
                              DTOutput("tbl_eptd"),
                              uiOutput("download_eptd")
                          )
         ),
         
         conditionalPanel("input.goldIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              HTML("<h3> 1 - GOLD </h3>"),
                              HTML("This function calculates the 1 - GOLD metric, where GOLD stands for Gastropoda, 
                                           Oligochaeta and Diptera. This metric should decrease with increasing 
                                           organic pollution (Pinto et al., 2004)."),
                              tags$hr(),
                              DTOutput("tbl_gold"),
                              uiOutput("download_gold")
                          )
         ),
         
         conditionalPanel("input.lifeIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              HTML("<h3> LIFE Index </h3>"),
                              HTML("This function calculates LIFE index according to most recent version used in UK."),
                              tags$hr(),
                              HTML("To calculate diversity indices, please select the implementation method."),
                              radioButtons("life_method", "", choiceNames = c("extence", "life_2017"),
                                           choiceValues = c("extence", "life_2017"),
                                           selected = "extence", inline = TRUE),
                              # HTML("Log abundance categories (Extence et al., 2013)."),
                              # radioButtons("psi_abucl", "", choiceNames = c("1", "9", "99", "999"),
                              #              choiceValues = c(1, 9, 99, 999),
                              #              selected = "a", inline = TRUE),
                              checkboxInput("lifeAgg", label = "Aggregation", value = FALSE), 
                              selectizeInput("lifeExceptions", "Select taxa to exclude from the index calculation",
                                             choices = NULL, multiple = TRUE),
                              # fs_scores
                              DTOutput("tbl_life"),
                              uiOutput("download_life")
                          )
         ),
         
         conditionalPanel("input.whptIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              HTML("<h3> Whalley Hawkes Paisley Trigg </h3>"),
                              HTML("This function calculates Whalley Hawkes Paisley Trigg index according to version used in UK in 2017."),
                              tags$hr(),
                              # HTML("Log abundance categories (Extence et al., 2013)."),
                              # radioButtons("psi_abucl", "", choiceNames = c("1", "9", "99", "999"),
                              #              choiceValues = c(1, 9, 99, 999),
                              #              selected = "a", inline = TRUE),
                              column(4,style=list("padding-right: 5px;"),
                                     HTML("Data type"),
                                     radioButtons("whpt_type", "", choiceNames = c("Abundance", "Presence"),
                                                  choiceValues = c("ab", "po"),
                                                  selected = "ab", inline = TRUE)),
                              column(8,style=list("padding-right: 5px;"),
                                     HTML("Metric"),
                                     radioButtons("whpt_metric", "", choiceNames = c("ASPT", "BMWP", "Number of taxa"),
                                                  choiceValues = c("aspt", "bmwp", "ntaxa"),
                                                  selected = "aspt", inline = TRUE)),
                              checkboxInput("whptAgg", label = "Aggregation", value = FALSE), 
                              selectizeInput("whptExceptions", "Select taxa to exclude from the index calculation",
                                             choices = NULL, multiple = TRUE),
                              # fs_scores
                              DTOutput("tbl_whpt"),
                              uiOutput("download_whpt")
                          )
         )
         
  )
)