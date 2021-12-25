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

# Functions
source("default_val.R")

header <- dashboardHeader(title = "biomonitoR-app")

# Main panels on the left ------------------------------------------------------ 
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("About biomonitoR", tabName = "about"), # <- Main information abou biomonitor
    menuItem("Data Input", tabName = "dataInput", icon = icon("folder-open", lib = "glyphicon")), # <- Input data
    menuItem("taxonomy check", tabName = "taxonomy", icon = icon("check")), # <- Check taxonomy
    menuItem("diversity indices", tabName = "synonyms", icon = icon("calculator")), # Questo non é sinonimi...
    # menuItem("biomonitoring indices", tabName = "biom", icon = icon("calculator")),
    # menuItem("import traits table", tabName = "mtraits", icon = icon("file-import")),
    # menuItem("manage traits table", tabName = "tdist", icon = icon("calculator")),
    # menuItem("functional indices", tabName = "func", icon = icon("calculator")),
    # menuItem("more indices", tabName = "more", icon = icon("calculator")),
    # menuItem("indices correlation", tabName = "corr", icon = icon("calculator")),
    # menuItem("environmental variables", tabName = "env", icon = icon("layer-group")),
    # menuItem("map", tabName = "map", icon = icon("map")),
    menuItem("credits", tabName = "info", icon = icon("info")),
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
                 box(textOutput("welcome"), width = NULL, solidHeader = TRUE),
                # Import dataset and set main parameters
                 box(title = "Load file - Select your data format", solidHeader = FALSE, width = NULL,
                     radioButtons("filetype", "", choices = c("xlsx","csv","txt"), inline = TRUE),
                     tags$br(),
                     HTML("Select your data"),
                     fileInput("file1", label = NULL),
                     tags$hr(),
                     HTML("Select your reference community"),
                     radioButtons("communitytype", "", choiceNames = c("macroinvertebrates", "macrophytes", "fish", "custom") , choiceValues = c( "mi", "mf", "fi", "cu"), inline = FALSE),
                     tags$hr(),
                     HTML("Select your data type"),
                     radioButtons("abutype", "", choiceNames = c("abundance", "presence_absence"), choiceValues = c("sum","bin"), inline = TRUE)),

                 # Import Custom reference dataframe                 
                conditionalPanel("input.communitytype == 'cu'", 
                box(title = "Load file - Custom reference dataframe", solidHeader = FALSE, width = NULL,
                     radioButtons("filetypeCustom", "", choices = c("xlsx","csv","txt"), inline = TRUE),
                     tags$br(),
                     HTML("Select your data"),
                     fileInput("file2", label = NULL)))
                 ) ,
          
          column(width = 8 ,
                 box(DTOutput('tbl'), width = NULL))
             )
    ),

# taxonomy
tabItem(tabName = "taxonomy",
        column(width = 4 ,
               box(width = NULL, solidHeader = TRUE,
                 HTML("<h3>
  <b>Taxonomy check</b>
</h3> This panel can help you to checking the nomenclature of your taxa. <br> Taxa names are checked against the community type reference datasets or your custom dataset if loaded. <br> If there are potentially erroneus names, you can find possible suggestions into the in the space provided below. <br>
<br> Non-identfied taxa will be discarded.")),
               box(uiOutput("col"), width = NULL)
              ),

        column(width = 8,
               box(DTOutput("tbl4"), width = NULL),
               box(downloadButton("download_tax_corr", label = "Download Table"), width = NULL))
    ) ,


# synonyms
tabItem(tabName = "synonyms",
        fluidRow(column(width = 6,
                        box(textOutput("intro_div"),
                            uiOutput("div_taxlev"),
                            width = NULL),
                        box(DTOutput("tbl_div"),
                            downloadButton("download_div", label = "Download Table"),
                            width = NULL)
             ),
             
                 column(width = 6,
                        box(uiOutput("div_taxlev_pca") , width = NULL),
                        box(plotlyOutput("div_pca"), width = NULL),
                        box(selectizeInput("var_div_pairs", "Select an index for the scatter plot", choices = character() , multiple = FALSE ) , width = NULL ) ,
                        box(uiOutput("div_taxlev_pair"), width = NULL),
                        box(radioButtons("corr_div", "", choices = c("pearson", "spearman"), inline = TRUE),
                            tags$hr(),
                            verbatimTextOutput("console"), width = NULL),
                        box(plotlyOutput("ggpairs_div"), width = NULL)
             )
        )
    ),

# info
tabItem(tabName = "info",
        textOutput("credits")
    )
  )

)

ui <- dashboardPage(header, sidebar, body, skin = "black" )