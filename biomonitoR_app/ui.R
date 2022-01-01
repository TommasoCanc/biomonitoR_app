##n################################
# Shiny App biomonitoR v 0.1 - UI #
###################################

# Load libraries
library(shiny)
library(shinydashboard)
library(DT)
library(readxl)
library(purrr)
library(hunspell)
library(biomonitoR)
library(ggplot2)
library(biomonitorweb)
library(tidyr)
library(ade4)
library(plotly)
library(tools)

# Functions
source("default_val.R")

header <- dashboardHeader(title = "biomonitoR-app")

# Main panels on the left ------------------------------------------------------ 
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("About biomonitoR", tabName = "about"), # <- Main information abou biomonitor
    menuItem("Data Input", tabName = "dataInput", icon = icon("folder-open", lib = "glyphicon")), # <- Input data
    menuItem("Taxonomy check", tabName = "taxonomy", icon = icon("check")), # <- Check taxonomy
    menuItem("Diversity indices", tabName = "ecoIndex", icon = icon("calculator")), # Questo non é sinonimi...
    menuItem("Biomonitoring indices", tabName = "biomIndex", icon = icon("calculator")),
    # menuItem("import traits table", tabName = "mtraits", icon = icon("file-import")),
    # menuItem("manage traits table", tabName = "tdist", icon = icon("calculator")),
    # menuItem("functional indices", tabName = "func", icon = icon("calculator")),
    # menuItem("more indices", tabName = "more", icon = icon("calculator")),
    # menuItem("indices correlation", tabName = "corr", icon = icon("calculator")),
    # menuItem("environmental variables", tabName = "env", icon = icon("layer-group")),
    # menuItem("map", tabName = "map", icon = icon("map")),
    # menuItem("credits", tabName = "info", icon = icon("info")),
    menuItem("Custom reference dataset", tabName = "cusData", icon = icon("pencil", lib = "glyphicon")),
    menuItem("help", tabName = "help", icon = icon("question-sign", lib = "glyphicon"))
  )
)


# Color definition -------------------------------------------------------------
body <- dashboardBody(
  # color as the rest of the header.
  tags$head(tags$style(HTML(
        ".skin-blue .main-header .logo {
          background-color: #3c8dbc;
        }
        .skin-blue .main-header .logo:hover {
          background-color: #3c8dbc;
        }
        
        .col-sm-4 .box{
        background-color: #1e282c;
        font-size: 18px;
        color: #FFFFFF;
        }

        .col-sm-5 .box{
        background-color: #1e282c;
        font-size: 18px;
        color: #FFFFFF;
        }

        .col-sm-4 .box-header{
        color: #FFFFFF;
        }

        .shiny-notification {
              position:fixed;
              top: calc(90%);
              left: calc(90%);
              font-size: 20 px;
              height: 100 px;
              width: 400 px
              }"
       )
    )
),

# Panel content ---------------------------------------------------------------
tabItems(

# about
  tabItem(tabName = "about", source("about.R")$value),
  
# dataInput
tabItem(tabName = "dataInput",
        
        fluidRow(
          column(width = 4 ,
                 box(width = NULL, solidHeader = TRUE,
                     HTML("<h3> <b>Data Input</b> </h3> 
                          To import your dataset in the biomonitoR-app, it is important to follow two simple rules: <br><br>
                       <b>1)</b> The first column of your dataset has to contain the taxa names, and it has to be named <i><b>'Taxa'</b></i>; <br><br>
                       <b>2)</b> The other columns of your dataset can contain abundance or presence/absence data, and they have to 
                          be named with the sampling point stations. <br> <br>
                       
                       <h5> Note: biomonitoR-app can use three pre-setted reference datasets: 
                       macroinvertebrates, macrophytes, and fish.
                       If you want to import your custom reference dataset, please follow the 
                       instructions present in the <b>Help</b>. </h3>")),
                # Import dataset and set main parameters
                 box(title = "Load file - Community data", solidHeader = FALSE, width = NULL,
                     #radioButtons("filetype", "", choices = c("xlsx","csv","txt"), inline = TRUE),
                     HTML("Select your data"),
                     fileInput("file1", label = NULL),
                     HTML("<h5> Data can be loaded in <b>xlsx</b>, <b>csv</b>, or <b>txt</b> formats.</h5>"),
                     tags$hr(),
                     HTML("Select your reference community"),
                     radioButtons("communitytype", "", choiceNames = c("macroinvertebrates", "macrophytes", "fish", "custom") , choiceValues = c( "mi", "mf", "fi", "cu"), inline = FALSE),
                     tags$hr(),
                     HTML("Select your data type"),
                     radioButtons("abutype", "", choiceNames = c("abundance", "presence_absence"), choiceValues = c("sum","bin"), inline = TRUE)),

                 # Import Custom reference dataframe                 
                conditionalPanel("input.communitytype == 'cu'", 
                box(title = "Load file - Custom reference dataframe", solidHeader = FALSE, width = NULL,
                     #radioButtons("filetypeCustom", "", choices = c("xlsx","csv","txt"), inline = TRUE),
                     HTML("Select your data"),
                     fileInput("file2", label = NULL)))
                 ) ,
          
          column(width = 8 ,
                 uiOutput("tbl")
                 )
             )
    ),

# Taxonomy ---------------------------------------------------------------------
tabItem(tabName = "taxonomy",
        column(width = 4 ,
               box(width = NULL, solidHeader = TRUE,
                 HTML("<h3>
  <b>Taxonomy check</b>
</h3> This panel can help you to checking the nomenclature of your taxa. <br> 
Taxa names are checked against the community type reference datasets or your custom 
dataset if loaded. <br> If there are potentially erroneus names, you can find possible 
suggestions into the in the space provided below. <br>
<br> Non-identfied taxa will be discarded.")),
               uiOutput("correctNames"), # Open the box with correct names suggestions
box(title = "Dou you want to download the table with reviewed nomenclature?", solidHeader = FALSE, width = NULL,
    checkboxInput("downloadNomenclature", label = "Download", value = FALSE)), # Condition to download the table with reviewed taxonomy
    conditionalPanel("input.downloadNomenclature == 1",
                 box(downloadButton("downloadNomenclature", label = "Download Table"), width = NULL)) # Download button for download table with reviewed taxonomy
              ),

        column(width = 8,
               uiOutput("tblTaxonomy"),
               #box(DTOutput("tbl4"), width = NULL),
               #box(downloadButton("download_tax_corr", label = "Download Table"), width = NULL)
               )
    ) ,


# Ecological Index -------------------------------------------------------------
tabItem(tabName = "ecoIndex",
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
                            radioButtons("div_taxlev", "", choiceNames = c("Taxa"),choiceValues = c("Taxa"), selected = "Taxa", inline = TRUE),
                            DTOutput("tbl_div"),
                            HTML("<h5> Note: If richness is below 3, the indices can not be calculated. </h5>")),
                            downloadButton("download_div", label = "Download Table"),
                            tags$hr()),
                            
                        conditionalPanel("input.diverityPCA == 1",
                            box(width = NULL, solidHeader = TRUE,           
                            HTML("<h3> Diversity Indices PCA </h3>
                                 Dare info sulla pca e come usarla"),
                            checkboxGroupInput("div_taxPCA", "", choiceNames = c("Family", "Genus", "Species", "Taxa"), 
                                         choiceValues = c("Family", "Genus", "Species", "Taxa"), selected = "Taxa", inline = TRUE),
                            uiOutput("div_taxlev_pca")),
                            plotlyOutput("div_pca")),
                        
                        conditionalPanel("input.diverityScatter == 1",
                        box(width = NULL, solidHeader = TRUE,
                          selectizeInput("var_div_pairs", "Select an index for the scatter plot", choices = character(), multiple = FALSE),
                          HTML("<b>Taxonomic correlation levels</b>"),
                          checkboxGroupInput("div_taxlev_pair", "", choiceNames = c("Family", "Genus", "Species", "Taxa"), 
                                             choiceValues = c("Family", "Genus", "Species", "Taxa"), selected = "Taxa", inline = TRUE),
                          uiOutput("div_taxlev_pair"),
                          HTML("<b>Correlation type</b>"),
                          radioButtons("corr_div", "", choices = c("pearson", "spearman"), inline = TRUE),
                          tags$hr(),
                          verbatimTextOutput("console"),
                          plotlyOutput("ggpairs_div")
                          ))
             )
        )
    ),

# Biomonitoring indices --------------------------------------------------------
tabItem(tabName = "biomIndex",
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
                                      HTML("To calculate diversity indices, please select the implementation method."),
                                      radioButtons("bmwp_method", "", choiceNames = c("armitage", "UK-davy-bowker", "ES-magrama", "IT-buffagni"), 
                                                   choiceValues = c("a", "uk", "spa", "ita"), 
                                                   selected = "a", inline = TRUE),
                                      checkboxInput("bmwpAgg", label = "Aggregation", value = FALSE), # <- agg parameter of BWMP
                                      #checkboxInput("bmwpTrace", label = "Trace", value = FALSE), # <- traceB parameter of BWMP
                                      selectizeInput("bmwpExceptions", "Select taxa to exclude from the index calculation", 
                                                     choices = NULL, multiple = TRUE),
                                      DTOutput("tbl_bmwp"),
                                      uiOutput("download_bmwp")
                                      #downloadButton("download_bmwp", label = "Download Table")
                                      )
                                  ),
                 
                 conditionalPanel("input.asptIndex == 1",
                                  box(width = NULL, solidHeader = TRUE,
                                      HTML("<h3> Average Score Per Taxon (ASPT) </h3>"),
                                      HTML("This function calculates the Average Score Per Taxon index following Armitage et al. (1983), 
                                           Davy-Bowker et al. (2007) and Alba-Tercedor & Sanchez-Ortega (1988) implementations."),
                                      HTML("To calculate diversity indices, please select the implementation method."),
                                      radioButtons("aspt_method", "", choiceNames = c("armitage", "UK-davy-bowker", "ES-magrama", "IT-buffagni"), 
                                                   choiceValues = c("a", "uk", "spa", "ita"), 
                                                   selected = "a", inline = TRUE),
                                      checkboxInput("asptAgg", label = "Aggregation", value = FALSE), # <- agg parameter of BWMP
                                      #checkboxInput("bmwpTrace", label = "Trace", value = FALSE), # <- traceB parameter of BWMP
                                      selectizeInput("asptExceptions", "Select taxa to exclude from the index calculation", 
                                                     choices = NULL, multiple = TRUE),
                                      DTOutput("tbl_aspt"),
                                      downloadButton("download_aspt", label = "Download Table"))
                 ),
                 
                 conditionalPanel("input.psiIndex == 1",
                                  box(width = NULL, solidHeader = TRUE,
                                      HTML("<h3> Proportion of Sediment-sensitive Invertebrates index (PSI) </h3>"),
                                      HTML("This function calculates the Proportion of Sediment-sensitive Invertebrates index 
                                           (PSI) according to the most recent version used in UK."),
                                      # HTML("Log abundance categories (Extence et al., 2013)."),
                                      # radioButtons("psi_abucl", "", choiceNames = c("1", "9", "99", "999"), 
                                      #              choiceValues = c(1, 9, 99, 999), 
                                      #              selected = "a", inline = TRUE),
                                      checkboxInput("psiAgg", label = "Aggregation", value = FALSE), # <- agg parameter of BWMP
                                      #checkboxInput("bmwpTrace", label = "Trace", value = FALSE), # <- traceB parameter of BWMP
                                      selectizeInput("psiExceptions", "Select taxa to exclude from the index calculation", 
                                                     choices = NULL, multiple = TRUE),
                                      DTOutput("tbl_psi"),
                                      downloadButton("download_psi", label = "Download Table"))
                 ),
                 
                 conditionalPanel("input.epsiIndex == 1",
                                  box(width = NULL, solidHeader = TRUE,
                                      HTML("<h3> Empyrically-weighted Proportion of Sediment-sensitive Invertebrates (ePSI) </h3>"),
                                      HTML("This function calculates the Empyrically-weighted Proportion of Sediment-sensitive Invertebrates index 
                                           (ePSI) according to the most recent version used in UK."),
                                      # HTML("Log abundance categories (Extence et al., 2013)."),
                                      # radioButtons("psi_abucl", "", choiceNames = c("1", "9", "99", "999"), 
                                      #              choiceValues = c(1, 9, 99, 999), 
                                      #              selected = "a", inline = TRUE),
                                      checkboxInput("epsiAgg", label = "Aggregation", value = FALSE), # <- agg parameter of BWMP
                                      #checkboxInput("bmwpTrace", label = "Trace", value = FALSE), # <- traceB parameter of BWMP
                                      selectizeInput("epsiExceptions", "Select taxa to exclude from the index calculation", 
                                                     choices = NULL, multiple = TRUE),
                                      DTOutput("tbl_epsi"),
                                      downloadButton("download_epsi", label = "Download Table"))
                 ),
                 
                 conditionalPanel("input.eptIndex == 1",
                                  box(width = NULL, solidHeader = TRUE,
                                      HTML("<h3> EPT richness </h3>"),
                                      HTML("This function calculates the richness of Ephemeroptera, Plecotera and Trichoptera 
                                           (EPT) taxa at the desired taxonomic level."),
                                      radioButtons("ept_taxLev", "", choiceNames = c("Family", "Genus", "Species", "Taxa"), 
                                                   choiceValues = c("Family", "Genus", "Species", "Taxa"), 
                                                   selected = "Taxa", inline = TRUE),
                                      DTOutput("tbl_ept"),
                                      downloadButton("download_ept", label = "Download Table"))
                 ),
                 
                 conditionalPanel("input.eptdIndex == 1",
                                  box(width = NULL, solidHeader = TRUE,
                                      HTML("<h3> log10 of selected EPTD </h3>"),
                                      HTML("This function calculates the log10(Sel_EPTD + 1) metric, 
                                           where EPTD stands for Ephemeroptera, Plecoptera, Trichoptera and Diptera."),
                                      # eptd_families = NULL ?
                                      numericInput("epdt_logBase", "log Base", 10, width = '10%'),
                                      DTOutput("tbl_eptd"),
                                      downloadButton("download_eptd", label = "Download Table"))
                 ),
                 
                 conditionalPanel("input.goldIndex == 1",
                                  box(width = NULL, solidHeader = TRUE,
                                      HTML("<h3> 1 - GOLD </h3>"),
                                      HTML("This function calculates the 1 - GOLD metric, where GOLD stands for Gastropoda, 
                                           Oligochaeta and Diptera. This metric should decrease with increasing 
                                           organic pollution (Pinto et al., 2004)."),
                                      DTOutput("tbl_gold"),
                                      downloadButton("download_gold", label = "Download Table"))
                 ),
                 
                 conditionalPanel("input.lifeIndex == 1",
                                  box(width = NULL, solidHeader = TRUE,
                                      HTML("<h3> LIFE Index </h3>"),
                                      HTML("This function calculates LIFE index according to most recent version used in UK."),
                                      HTML("To calculate diversity indices, please select the implementation method."),
                                      radioButtons("life_method", "", choiceNames = c("extence", "life_2017"),
                                                   choiceValues = c("extence", "life_2017"),
                                                   selected = "extence", inline = TRUE),
                                      # HTML("Log abundance categories (Extence et al., 2013)."),
                                      # radioButtons("psi_abucl", "", choiceNames = c("1", "9", "99", "999"),
                                      #              choiceValues = c(1, 9, 99, 999),
                                      #              selected = "a", inline = TRUE),
                                      checkboxInput("lifeAgg", label = "Aggregation", value = FALSE), # <- agg parameter of BWMP
                                      selectizeInput("lifeExceptions", "Select taxa to exclude from the index calculation",
                                                     choices = NULL, multiple = TRUE),
                                      # fs_scores
                                      DTOutput("tbl_life"),
                                      downloadButton("download_life", label = "Download Table"))
                 ),
                
                 conditionalPanel("input.whptIndex == 1",
                                  box(width = NULL, solidHeader = TRUE,
                                      HTML("<h3> Whalley Hawkes Paisley Trigg </h3>"),
                                      HTML("This function calculates Whalley Hawkes Paisley Trigg index according to version used in UK in 2017."),
                                      # HTML("Log abundance categories (Extence et al., 2013)."),
                                      # radioButtons("psi_abucl", "", choiceNames = c("1", "9", "99", "999"),
                                      #              choiceValues = c(1, 9, 99, 999),
                                      #              selected = "a", inline = TRUE),
                                      column(4,style=list("padding-right: 5px;"),
                                      HTML("Data type"),
                                      radioButtons("whpt_type", "", choiceNames = c("Abundance", "Presence"),
                                                   choiceValues = c("ab", "po"),
                                                   selected = "ab", inline = TRUE)),
                                      column(4,style=list("padding-right: 5px;"),
                                      HTML("Metric"),
                                      radioButtons("whpt_metric", "", choiceNames = c("ASPT", "BMWP", "Number of taxa"),
                                                   choiceValues = c("aspt", "bmwp", "ntaxa"),
                                                   selected = "aspt", inline = TRUE)),
                                      checkboxInput("whptAgg", label = "Aggregation", value = FALSE), # <- agg parameter of BWMP
                                      selectizeInput("whptExceptions", "Select taxa to exclude from the index calculation",
                                                     choices = NULL, multiple = TRUE),
                                      # fs_scores
                                      DTOutput("tbl_whpt"),
                                      downloadButton("download_whpt", label = "Download Table"))
                 )

                 
          )
        )
),



# Reference custom dataset -----------------------------------------------------
tabItem(tabName = "cusData",
        
        fluidRow(
          column(width = 4 ,
                 box(width = NULL, solidHeader = TRUE,
                     HTML("<h3> <b>Custom Reference Datset</b> </h3> 
                          To import your dataset in the biomonitoR-app, it is important to follow two simple rules: <br><br>
                       <b>1)</b> The first column of your dataset has to contain the taxa names, and it has to be named <i><b>'Taxa'</b></i>; <br><br>
                       <b>2)</b> The other columns of your dataset can contain abundance or presence/absence data, and they have to 
                          be named with the sampling point stations. <br> <br>
                       
                       <h5> Note: biomonitoR-app can use three pre-setted reference datasets: 
                       macroinvertebrates, macrophytes, and fish.
                       If you want to import your custom reference dataset, please follow the 
                       instructions present in the <b>Help</b>. </h3>")),
                 # Import dataset and set main parameters
                 box(title = "Load file - Select your data format", solidHeader = FALSE, width = NULL,
                     radioButtons("filetypeCRD", "", choices = c("xlsx","csv","txt"), inline = TRUE),
                     tags$br(),
                     HTML("Select your Custom reference dataset"),
                     fileInput("fileCRD", label = NULL),
                     tags$hr(),
                     HTML("Select your reference community"),
                     radioButtons("communitytypeCRD", "", choiceNames = c("macroinvertebrates", "macrophytes", "fish", "none") , choiceValues = c( "mi", "mf", "fi", "none"), inline = FALSE, selected = "none")),
          
                 box(title = "Dou you want to download your Custom Reference Dataset?", solidHeader = FALSE, width = NULL,
                     checkboxInput("downloadCRD", label = "Download", value = FALSE)
                 )
                 ),
          
          column(width = 8,
                 uiOutput("boxCRD"),
                 #box(DTOutput("tblCRD"), width = NULL),
                 conditionalPanel("input.downloadCRD == 1",
                 box(downloadButton("download_CRD", label = "Download Table"), width = NULL))
                 )
                 )
)
  
)
)

ui <- dashboardPage(header, sidebar, body, skin = "black")