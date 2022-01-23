fluidRow(
  column(width = 4,
         box(width = NULL, solidHeader = TRUE,
             HTML("<h3> <b>Biomonitoring Indices</b> </h3> 
                          This panel ...")),
         box(width = NULL, solidHeader = TRUE,
             HTML("What do you want to calculate?"),
             checkboxInput("biocoIndex", label = "Biocontamination (SBCI), abundance contamination (ACI), and richness contamination index (RCI)", value = FALSE), # <- BIOCO
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
         
         # bioco ----
         conditionalPanel("input.biocoIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              HTML("<h3> Biocontamination (SBCI), abundance contamination (ACI), and richness contamination index (RCI) </h3>"),
                              HTML("This function provides site-specific biocontamination index (SBCI), 
                                   abundance contamination index (ACI) and richness contamination index (RCI) 
                                   at family rank according to those proposed by Arbaciauskas et al. (2008)."),
                              tags$hr(),
                              selectizeInput("biocoAlien", "Select alien species to calculate the index", 
                                             choices = NULL, multiple = TRUE),
                              radioButtons("biocoRefdf", "", choiceNames = c("Macroinvertebrate", "Macrophyte", "Custom"), 
                                           choiceValues = c("mi", "mf", "cu"), selected = "mi", inline = TRUE),
                              DTOutput("tbl_bioco"),
                              uiOutput("download_bioco")
                          )
         ),
         
         # bwmp ----
         conditionalPanel("input.bmwpIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              HTML("<h3> Biological Monitoring Working Party (BMWP) </h3>"),
                              HTML("This function calculates the Biological Monitoring Working Party index 
                                           following Armitage et al. (1983), Davy-Bowker et al. (2007) and 
                                           Alba-Tercedor & Sanchez-Ortega (1988) implementations."),
                              tags$hr(),
                              column(6,
                              radioButtons("bmwp_method", "To calculate diversity indices, please select the implementation method.", choiceNames = c("Armitage", "UK-davy-bowker", "ES-magrama", "IT-buffagni"), 
                                           choiceValues = c("a", "uk", "spa", "ita"), selected = "a", inline = TRUE),
                              HTML("<b> Taxa aggregation </b>"),
                              checkboxInput("bmwpAgg", label = "Aggregation", value = FALSE)), # <- agg parameter of BWMP
                              
                              column(6,HTML("<b> BMWP score </b>"),
                              checkboxInput("bmwpScore", "Show the BMWP score", value = FALSE),
                              radioButtons("bmwp_methodScore", "Method", choiceNames = c("Armitage", "UK-davy-bowker", "ES-magrama", "IT-buffagni"), 
                                           choiceValues = c("armitage", "uk", "spa", "ita"), selected = NULL, inline = TRUE)),
                              #checkboxInput("bmwpTrace", label = "Trace", value = FALSE), # <- traceB parameter of BWMP
                              selectizeInput("bmwpExceptions", "Select taxa to exclude from the index calculation", 
                                             choices = NULL, multiple = TRUE),
                              DTOutput("tbl_bmwp"),
                              uiOutput("download_bmwp"),
                              DTOutput("tbl_bmwpScore")
                          )
         ),
         
         # aspt ----
         conditionalPanel("input.asptIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              HTML("<h3> Average Score Per Taxon (ASPT) </h3>"),
                              HTML("This function calculates the Average Score Per Taxon index following Armitage et al. (1983), 
                                           Davy-Bowker et al. (2007) and Alba-Tercedor & Sanchez-Ortega (1988) implementations."),
                              tags$hr(),
                              
                              column(6,
                                     HTML("To calculate diversity indices, please select the implementation method."),
                                     radioButtons("aspt_method", "", choiceNames = c("Armitage", "UK-davy-bowker", "ES-magrama", "IT-buffagni"), 
                                                  choiceValues = c("a", "uk", "spa", "ita"), 
                                                  selected = "a", inline = TRUE),
                                     HTML("<b> Taxa aggregation </b>"),
                                     checkboxInput("asptAgg", label = "Aggregation", value = FALSE)
                                     ),
                              #checkboxInput("bmwpTrace", label = "Trace", value = FALSE), 
                              
                              column(6,HTML("<b> ASPT score </b>"),
                                     checkboxInput("asptScore", "Show the ASPT score", value = FALSE),
                                     radioButtons("aspt_methodScore", "Method", choiceNames = c("Armitage", "UK-davy-bowker", "ES-magrama", "IT-buffagni"), 
                                                  choiceValues = c("armitage", "uk", "spa", "ita"), selected = NULL, inline = TRUE)
                                     ),
                              selectizeInput("asptExceptions", "Select taxa to exclude from the index calculation", 
                                             choices = NULL, multiple = TRUE),
                              DTOutput("tbl_aspt"),
                              uiOutput("download_aspt"),
                              DTOutput("tbl_asptScore")
                              # downloadButton("download_aspt", label = "Download Table")
                          )
         ),
         
         # psi ----
         conditionalPanel("input.psiIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              HTML("<h3> Proportion of Sediment-sensitive Invertebrates index (PSI) </h3>"),
                              HTML("This function calculates the Proportion of Sediment-sensitive Invertebrates index 
                                           (PSI) according to the most recent version used in UK."),
                              tags$hr(),
                              column(6,
                                     HTML("<b> Taxa aggregation </b>"),
                                     checkboxInput("psiAgg", label = "Aggregation", value = FALSE)),
                              
                              column(6,
                                     HTML("<b> PSI score </b>"),
                                     checkboxInput("psiScore", "Show the PSI score", value = FALSE)),
                              
                              # HTML("Log abundance categories (Extence et al., 2013)."),
                              # radioButtons("psi_abucl", "", choiceNames = c("1", "9", "99", "999"), 
                              #              choiceValues = c(1, 9, 99, 999), 
                              #              selected = "a", inline = TRUE),
                               
                              #checkboxInput("bmwpTrace", label = "Trace", value = FALSE), 
                              selectizeInput("psiExceptions", "Select taxa to exclude from the index calculation", 
                                             choices = NULL, multiple = TRUE),
                              DTOutput("tbl_psi"),
                              uiOutput("download_psi"),
                              DTOutput("tbl_psiScore")
                          )
         ),
         
         # epsi ----
         conditionalPanel("input.epsiIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              HTML("<h3> Empyrically-weighted Proportion of Sediment-sensitive Invertebrates (ePSI) </h3>"),
                              HTML("This function calculates the Empyrically-weighted Proportion of Sediment-sensitive Invertebrates index 
                                           (ePSI) according to the most recent version used in UK."),
                              tags$hr(),
                              column(6,
                                     HTML("<b> Taxa aggregation </b>"),
                                     checkboxInput("epsiAgg", label = "Aggregation", value = FALSE)),
                              column(6,
                                     HTML("<b> ePSI score </b>"),
                                     checkboxInput("epsiScore", "Show the ePSI score", value = FALSE)
                                     ),
                              
                              # HTML("Log abundance categories (Extence et al., 2013)."),
                              # radioButtons("psi_abucl", "", choiceNames = c("1", "9", "99", "999"), 
                              #              choiceValues = c(1, 9, 99, 999), 
                              #              selected = "a", inline = TRUE),
                              
                              #checkboxInput("bmwpTrace", label = "Trace", value = FALSE), 
                              selectizeInput("epsiExceptions", "Select taxa to exclude from the index calculation", 
                                             choices = NULL, multiple = TRUE),
                              DTOutput("tbl_epsi"),
                              uiOutput("download_epsi"),
                              DTOutput("tbl_epsiScore")
                          )
         ),
         
         # ept ----
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
         
         # epdt ----
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
         
         # gold ----
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
         
         # life ----
         conditionalPanel("input.lifeIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              HTML("<h3> LIFE Index </h3>"),
                              HTML("This function calculates LIFE index according to most recent version used in UK."),
                              tags$hr(),
                              column(6,
                                    radioButtons("life_method", "To calculate diversity indices, please select the implementation method.", choiceNames = c("extence", "life_2017"),
                                                  choiceValues = c("extence", "life_2017"),
                                                  selected = "extence", inline = TRUE),
                                     HTML("<b> Taxa aggregation </b>"),
                                     checkboxInput("lifeAgg", label = "Aggregation", value = FALSE)
                                     ),
                              
                              column(6,
                                     HTML("<b> LIFE score </b>"),
                                     checkboxInput("lifeScore", "Show the LIFE score", value = FALSE),
                                     radioButtons("life_methodScore", "Method", choiceNames = c("Extence", "Life 2017"), 
                                                  choiceValues = c("extence", "life_2017"), selected = NULL, inline = TRUE)
                                     ),
                              
                              # HTML("Log abundance categories (Extence et al., 2013)."),
                              # radioButtons("psi_abucl", "", choiceNames = c("1", "9", "99", "999"),
                              #              choiceValues = c(1, 9, 99, 999),
                              #              selected = "a", inline = TRUE),
                              selectizeInput("lifeExceptions", "Select taxa to exclude from the index calculation",
                                             choices = NULL, multiple = TRUE),
                              # fs_scores
                              DTOutput("tbl_life"),
                              uiOutput("download_life"),
                              DTOutput("tbl_lifeScore")
                          )
         ),
         
         # whpt ----
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