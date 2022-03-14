##n################################
# Shiny App biomonitoR v 0.1 - UI #
###################################

# Load libraries
if (!require("shiny"))
  install.packages("shiny")
require(shiny)
if (!require("shinydashboard"))
  install.packages("shinydashboard")
require(shinydashboard)
if (!require("shinyWidgets"))
  install.packages("shinyWidgets")
require(shinyWidgets)
if (!require("DT"))
  install.packages("DT")
require(DT)
if (!require("readxl"))
  install.packages("readxl")
require(readxl)
if (!require("purrr"))
  install.packages("purrr")
require(purrr)
if (!require("hunspell"))
  install.packages("hunspell")
require(hunspell)
if (!require("ggplot2"))
  install.packages("ggplot2")
require(ggplot2)
if (!require("tidyr"))
  install.packages("tidyr")
require(tidyr)
if (!require("ade4"))
  install.packages("ade4")
require(ade4)
if (!require("plotly"))
  install.packages("plotly")
require(plotly)
if (!require("tools"))
  install.packages("tools")
require(tools)

# biomonitorweb
if (!require("biomonitorweb")) {
  if (!require("devtools"))
    install.packages("devtools")
  require(devtools)
  install_github("alexology/biomonitorweb")
} else{
  require(biomonitorweb)
}

# biomonitor
if (!require("biomonitoR")) {
  if (!require("devtools"))
    install.packages("devtools")
  require(devtools)
  install_github("alexology/biomonitoR",
                 ref = "develop",
                 build_vignettes = FALSE)
} else{
  require(biomonitoR)
}

# Functions
source("default_val.R")

header <- dashboardHeader(title = "biomonitoR App")

# Main panels on the left ------------------------------------------------------
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("About biomonitoR", tabName = "about"),
    # <- Main information abou biomonitor
    menuItem(
      "Data Input & Management",
      tabName = "dataIn&Man",
      icon = icon("folder-open", lib = "glyphicon"),
      menuSubItem("Data Input", tabName = "dataInput"),
      # <- Input data
      menuSubItem("Taxonomy check", tabName = "taxonomy"),
      # <- Taxonomy check
      menuSubItem("Create Custom RND", tabName = "cusData") # <- Create custom reference dataset
    ),
    #menuItem("Taxonomy check", tabName = "taxonomy", icon = icon("check")), # <- Check taxonomy
    menuItem(
      "Diversity indices",
      tabName = "ecoIndex",
      icon = icon("calculator")
    ),
    # <-  DIversity indices
    menuItem(
      "Biomonitoring indices",
      tabName = "biomIndex",
      icon = icon("calculator")
    ),
    # <- Biomonitor Indices
    menuItem(
      "Traits Input & Management",
      tabName = "inputTraits",
      icon = icon("file-import"),
      # <-  Traits table
      menuSubItem("Input trait table", tabName = "inTrait"),
      menuSubItem("Manage trait table", tabName = "manageTrait"),
      menuSubItem("Functional indices ", tabName = "funIndices")
    ),
    # menuItem("manage traits table", tabName = "tdist", icon = icon("calculator")),
    # menuItem("functional indices", tabName = "func", icon = icon("calculator")),
    # menuItem("more indices", tabName = "more", icon = icon("calculator")),
    # menuItem("indices correlation", tabName = "corr", icon = icon("calculator")),
    # menuItem("environmental variables", tabName = "env", icon = icon("layer-group")),
    # menuItem("map", tabName = "map", icon = icon("map")),
    # menuItem("credits", tabName = "info", icon = icon("info")),
    #menuItem("Create CusRef dataset", tabName = "cusData", icon = icon("pencil", lib = "glyphicon")), # <- Create custom reference dataset
    menuItem(
      "Help",
      tabName = "help",
      icon = icon("question-sign", lib = "glyphicon"),
      # Help
      menuSubItem("Data Input", tabName = "help_dataInput"),
      menuSubItem("Taxonomy check", tabName = "help_taxonCheck"),
      menuSubItem("Custom RND", tabName = "help_CustRND"),
      menuSubItem("Diversity indices", tabName = "help_divIndex")
      #menuSubItem("Biomonitoring indices", tabName = "help_bioIndex"),
      #menuSubItem("Functional indices", tabName = "help_funIndex")
    ),
    menuItem(
      "References",
      tabName = "biblioRef",
      icon = icon("info-sign", lib = "glyphicon")
    ) # <- Bibliographic reference
  )
)


# Color definition -------------------------------------------------------------
body <-
  dashboardBody(
    tags$head(tags$style(source("./UI/css.R")$value)),
    # color as the rest of the header.
    
    # Panel content ---------------------------------------------------------------
    tabItems(
      tabItem(tabName = "about", source("./UI/00_about.R")$value),
      # about
      
      # Data Input & Management ------------------------------------------------------
      tabItem(tabName = "dataInput", source("./UI/01_1_DataInput_UI.R")$value),
      # Data Input
      tabItem(tabName = "taxonomy", source("./UI/01_2_Taxonomy_UI.R")$value),
      # Taxonomy
      tabItem(tabName = "cusData", source("./UI/01_3_CustomDf_UI.R")$value),
      # Create reference custom dataset
      
      # Ecological Index -------------------------------------------------------------
      tabItem(tabName = "ecoIndex", source("./UI/02_DiversityIndex_UI.R")$value),
      
      # Biomonitoring indices --------------------------------------------------------
      tabItem(tabName = "biomIndex", source("./UI/03_BiomonitoringIndex_UI.R")$value),
      
      # Traits -----------------------------------------------------------------------
      tabItem(tabName = "inTrait", source("./UI/04_1_inputTraitTable_UI.R")$value),
      # Input trait table
      tabItem(tabName = "manageTrait", source("./UI/04_2_manageTraitTable_UI.R")$value),
      # Manage trait table
      tabItem(tabName = "funIndices", source("./UI/04_3_functionalIndex_UI.R")$value),
      # Functional indices
      
      # Help -------------------------------------------------------------------------
      tabItem(tabName = "help_dataInput", source("./UI/05_1_Help_DataInput_UI.R")$value),
      # Help Data Input
      tabItem(tabName = "help_taxonCheck", source("./UI/05_2_Help_TaxonomyCheck_UI.R")$value),
      # Help Taxonomy check
      tabItem(tabName = "help_CustRND", source("./UI/05_3_Help_CustomRND_UI.R")$value),
      # Help Custom RND
      tabItem(tabName = "help_divIndex", source("./UI/05_4_Help_DiverityIndices_UI.R")$value),
      # Help Diversity indices
      

      
      # Bibliography -----------------------------------------------------------------
      tabItem(tabName = "biblioRef", source("./UI/06_Bibliography_UI.R")$value)
      
    )
  )

ui <- dashboardPage(header, sidebar, body, skin = "black")
