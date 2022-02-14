fluidRow(
  column(width = 4,
         box(width = NULL, solidHeader = TRUE,
             HTML("<h3> <b>Biomonitoring Indices</b> </h3> 
                          This panel provide several function to calculate tested biomonitoring indices.")
             ),
  
         # bioco index ----
         box(title = "BIO.CO.", width = NULL, solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
             HTML("<h4><b>Biocontamination (SBCI), abundance contamination (ACI), and richness contamination index (RCI)</b> <br><br>
                  This function provides site-specific biocontamination index (SBCI), 
                  abundance contamination index (ACI) and richness contamination index (RCI) 
                  at family rank according to those proposed by Arbaciauskas et al. (2008).</h4>"),
             selectizeInput("biocoAlien", "Select alien species to calculate the index", 
                            choices = NULL, multiple = TRUE),
             selectInput("biocoRefdf", "Reference community", 
                         choices = c("Macroinvertebrate" = "mi", 
                                     "Macrophyte" = "mf", 
                                     "Custom" = "cu"), 
                         selected = "mi", multiple = FALSE),
             checkboxInput("biocoIndex", label = "Run", value = FALSE) # <- Taxa richness
         ),
         
         # bmwp ----
         box(title = "BMWP", width = NULL, solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
             HTML("<h4><b>Biological Monitoring Working Party (BMWP)</b> <br><br>
                  This function calculates the Biological Monitoring Working Party index 
                  following Armitage et al. (1983), Davy-Bowker et al. (2007) and 
                  Alba-Tercedor & Sanchez-Ortega (1988) implementations.</h4>"),
             selectInput("bmwp_method", "Select the implementation method", 
                         choices = c("Armitage" = "a", 
                                     "UK-davy-bowker" = "uk", 
                                     "ES-magrama" = "spa",
                                     "IT-buffagni" = "ita"), 
                         selected = "a", multiple = FALSE),
             selectizeInput("bmwpExceptions", "Select taxa to exclude from the index calculation", 
                            choices = NULL, multiple = TRUE),
             checkboxInput("bmwpAgg", label = "Aggregation", value = FALSE), # <- agg parameter of BWMP
             checkboxInput("bmwpIndex", label = "Run", value = FALSE),
             tags$hr(),
             checkboxInput("bmwpScore", label = "Show BMWP implementation method score", value = FALSE),
             selectInput("bmwp_methodScore", "Select the implementation method", 
                         choices = c("Armitage" = "armitage", 
                                     "UK-davy-bowker" = "uk", 
                                     "ES-magrama" = "spa",
                                     "IT-buffagni" = "ita"), 
                         selected = "armitage", multiple = FALSE)
             ),
         
         # aspt ----
         box(title = "ASPT", width = NULL, solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
             HTML("<h4><b>Average Score Per Taxon (ASPT)</b> <br><br>
                  This function calculates the Average Score Per Taxon index following Armitage et al. (1983), 
                  Davy-Bowker et al. (2007) and Alba-Tercedor & Sanchez-Ortega (1988) implementations.</h4>"),
             selectInput("aspt_method", "Select the implementation method", 
                         choices = c("Armitage" = "a", 
                                     "UK-davy-bowker" = "uk", 
                                     "ES-magrama" = "spa",
                                     "IT-buffagni" = "ita"), 
                         selected = "a", multiple = FALSE),
             selectizeInput("asptExceptions", "Select taxa to exclude from the index calculation", 
                            choices = NULL, multiple = TRUE),
             checkboxInput("asptAgg", label = "Aggregation", value = FALSE), # <- agg parameter of ASPT
             checkboxInput("asptIndex", label = "Run", value = FALSE),
             tags$hr(),
             checkboxInput("asptScore", label = "Show ASPT implementation method score", value = FALSE),
             selectInput("aspt_methodScore", "Select the implementation method", 
                         choices = c("Armitage" = "armitage", 
                                     "UK-davy-bowker" = "uk", 
                                     "ES-magrama" = "spa",
                                     "IT-buffagni" = "ita"), 
                         selected = "armitage", multiple = FALSE)
         ),
         
         # psi ----
         box(title = "PSI", width = NULL, solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
             HTML("<h4><b>Proportion of Sediment-sensitive Invertebrates index (PSI)</b> <br><br>
                  This function calculates the Proportion of Sediment-sensitive Invertebrates index 
                  (PSI) according to the most recent version used in UK.</h4>"),
             selectizeInput("psiExceptions", "Select taxa to exclude from the index calculation", 
                            choices = NULL, multiple = TRUE),
             checkboxInput("psiAgg", label = "Aggregation", value = FALSE), # <- agg parameter of PSI
             checkboxInput("psiIndex", label = "Run", value = FALSE),
             tags$hr(),
             checkboxInput("psiScore", label = "Show PSI score", value = FALSE)
         ),
         
         # epsi ----
         box(title = "ePSI", width = NULL, solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
             HTML("<h4><b>Empyrically-weighted Proportion of Sediment-sensitive Invertebrates (ePSI)</b> <br><br>
                  This function calculates the Empyrically-weighted Proportion of Sediment-sensitive Invertebrates index 
                  (ePSI) according to the most recent version used in UK.</h4>"),
             selectizeInput("epsiExceptions", "Select taxa to exclude from the index calculation", 
                            choices = NULL, multiple = TRUE),
             checkboxInput("epsiAgg", label = "Aggregation", value = FALSE), # <- agg parameter of PSI
             checkboxInput("epsiIndex", label = "Run", value = FALSE),
             tags$hr(),
             checkboxInput("epsiScore", label = "Show ePSI score", value = FALSE)
         ),
         
         # ept index ----
         box(title = "EPT richness", width = NULL, solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
             HTML("<h4><b>EPT richness</b> <br><br>
                  This function calculates the richness of Ephemeroptera, Plecotera and Trichoptera 
                  (EPT) taxa at the desired taxonomic level. </h4>"),
             selectInput("ept_taxLev", "Taxa level", 
                         choices = c("Family" = "Family", 
                                     "Genus" = "Genus", 
                                     "Species" = "Species", 
                                     "Taxa" = "Taxa"), 
                         selected = "Taxa", multiple = FALSE),
             checkboxInput("eptIndex", label = "Run", value = FALSE) 
         ),
         
         # eptdIndex index ----
         box(title = "log of selected EPTD", width = NULL, solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
             HTML("<h4><b>log of selected EPTD</b> <br><br>
                  This function calculates the logx(Sel_EPTD + 1) metric, 
                  where EPTD stands for Ephemeroptera, Plecoptera, Trichoptera and Diptera. </h4>"),
             numericInput("epdt_logBase", "log Base", 10, width = "30%"),
             checkboxInput("eptdIndex", label = "Run", value = FALSE) 
         ),
         
         # GOLD index ----
         box(title = "1 - GOLD", width = NULL, solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
             HTML("<h4><b>1 - GOLD</b> <br><br>
                  This function calculates the 1 - GOLD metric, where GOLD stands for Gastropoda, 
                  Oligochaeta and Diptera. This metric should decrease with increasing 
                  organic pollution (Pinto et al., 2004). </h4>"),
             checkboxInput("goldIndex", label = "Run", value = FALSE) 
         ),
         
         # Life index ----
         box(title = "LIFE Index", width = NULL, solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
             HTML("<h4><b>Life Index</b> <br><br>
                  This function calculates LIFE index according to most recent version used in UK. </h4>"),
             selectInput("life_method", "Select the implementation method", 
                         choices = c("Extence" = "extence", 
                                     "LIFE 2017" = "life_2017"), 
                         selected = "extence", multiple = FALSE),
             selectizeInput("lifeExceptions", "Select taxa to exclude from the index calculation", 
                            choices = NULL, multiple = TRUE),
             checkboxInput("lifeAgg", label = "Aggregation", value = FALSE),
             checkboxInput("lifeIndex", label = "Run", value = FALSE),
             tags$hr(),
             checkboxInput("lifeScore", label = "Show LIFE implementation method score", value = FALSE),
             selectInput("life_methodScore", "Select the implementation method", 
                         choices = c("Extence" = "extence", 
                                     "Life 2017" = "life_2017"), 
                         selected = "extence", multiple = FALSE)
             ),
         
         # whpt index ----
         box(title = "Whalley Hawkes Paisley Trigg", width = NULL, solidHeader = TRUE, collapsible = TRUE, collapsed = TRUE,
             HTML("<h4><b>Whalley Hawkes Paisley Trigg</b> <br><br>
                  This function calculates Whalley Hawkes Paisley Trigg index according to version used in UK in 2017. </h4>"),
             selectInput("whpt_type", "Select the data type", 
                         choices = c("Abundance" = "ab", 
                                     "Presence" = "po"), 
                         selected = "ab", multiple = FALSE),
             selectInput("whpt_metric", "Select the metric", 
                         choices = c("ASPT" = "aspt", 
                                     "BMWP" = "bmwp",
                                     "Number of taxa" = "ntaxa"), 
                         selected = "aspt", multiple = FALSE),
             selectizeInput("whptExceptions", "Select taxa to exclude from the index calculation", 
                            choices = NULL, multiple = TRUE),
             checkboxInput("whptAgg", label = "Aggregation", value = FALSE),
             checkboxInput("whptIndex", label = "Run", value = FALSE)
             )
         ),
  
  column(width = 8,
         
         # bioco ----
         conditionalPanel("input.biocoIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              DTOutput("tbl_bioco"),
                              uiOutput("download_bioco")
                              )
                          ),
         
         # bwmp ----
         conditionalPanel("input.bmwpIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              DTOutput("tbl_bmwp"),
                              uiOutput("download_bmwp"),
                              DTOutput("tbl_bmwpScore")
                              )
                          ),
         
         # aspt ----
         conditionalPanel("input.asptIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              DTOutput("tbl_aspt"),
                              uiOutput("download_aspt"),
                              DTOutput("tbl_asptScore")
                              )
                          ),
         
         # psi ----
         conditionalPanel("input.psiIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              DTOutput("tbl_psi"),
                              uiOutput("download_psi"),
                              DTOutput("tbl_psiScore")
                              )
                          ),
         
         # epsi ----
         conditionalPanel("input.epsiIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              DTOutput("tbl_epsi"),
                              uiOutput("download_epsi"),
                              DTOutput("tbl_epsiScore")
                              )
                          ),
         
         # ept ----
         conditionalPanel("input.eptIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              DTOutput("tbl_ept"),
                              uiOutput("download_ept")
                              )
                          ),
         
         # epdt ----
         conditionalPanel("input.eptdIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              DTOutput("tbl_eptd"),
                              uiOutput("download_eptd")
                              )
                          ),
         
         # gold ----
         conditionalPanel("input.goldIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              DTOutput("tbl_gold"),
                              uiOutput("download_gold")
                              )
                          ),
         
         # life ----
         conditionalPanel("input.lifeIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              DTOutput("tbl_life"),
                              uiOutput("download_life"),
                              DTOutput("tbl_lifeScore")
                              ) 
                          ),
         
         # whpt ----
         conditionalPanel("input.whptIndex == 1",
                          box(width = NULL, solidHeader = TRUE,
                              DTOutput("tbl_whpt"),
                              uiOutput("download_whpt")
                              )
                          )
         
  )
)