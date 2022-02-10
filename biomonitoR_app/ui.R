##n################################
# Shiny App biomonitoR v 0.1 - UI #
###################################

# Load libraries
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(DT)
library(readxl)
#library(xlsx)
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
    menuItem("Data Input & Management", tabName = "dataIn&Man", icon = icon("folder-open", lib = "glyphicon"),
             menuSubItem("Data Input", tabName = "dataInput"), # <- Input data
             menuSubItem("Taxonomy check", tabName = "taxonomy"), # <- Taxonomy check
             menuSubItem("Create CusRef dataset", tabName = "cusData") # <- Create custom reference dataset
             ), 
    #menuItem("Taxonomy check", tabName = "taxonomy", icon = icon("check")), # <- Check taxonomy
    menuItem("Diversity indices", tabName = "ecoIndex", icon = icon("calculator")), # <-  DIversity indices
    menuItem("Biomonitoring indices", tabName = "biomIndex", icon = icon("calculator")), # <- Biomonitor Indices
    menuItem("Traits Input & Management", tabName = "inputTraits", icon = icon("file-import"), # <-  Traits table
             menuSubItem("Input trait table", tabName = "inTrait"),
             menuSubItem("Manage trait table", tabName = "manageTrait"),
             menuSubItem("Functional indices ", tabName = "funIndices")),
    # menuItem("manage traits table", tabName = "tdist", icon = icon("calculator")),
    # menuItem("functional indices", tabName = "func", icon = icon("calculator")),
    # menuItem("more indices", tabName = "more", icon = icon("calculator")),
    # menuItem("indices correlation", tabName = "corr", icon = icon("calculator")),
    # menuItem("environmental variables", tabName = "env", icon = icon("layer-group")),
    # menuItem("map", tabName = "map", icon = icon("map")),
    # menuItem("credits", tabName = "info", icon = icon("info")),
    #menuItem("Create CusRef dataset", tabName = "cusData", icon = icon("pencil", lib = "glyphicon")), # <- Create custom reference dataset
    menuItem("Help", tabName = "help", icon = icon("question-sign", lib = "glyphicon"), # Help
             menuSubItem("Data Input & Management", tabName = "dataInput_help"),
             menuSubItem("Taxonomy check", tabName = "taxonomy_help"),
             menuSubItem("Diversity indices", tabName = "ecoIndex_help"), 
             menuSubItem("Biomonitoring indices", tabName = "biomIndex_help")),
    menuItem("References", tabName = "biblioRef", icon = icon("info-sign", lib = "glyphicon")) # <- Bibliographic reference
  )
)


# Color definition -------------------------------------------------------------
body <- dashboardBody(tags$head(tags$style(source("./UI/css.R")$value)), # color as the rest of the header.

# Panel content ---------------------------------------------------------------
tabItems(tabItem(tabName = "about", source("./UI/00_about.R")$value), # about
  
# Data Input & Management ------------------------------------------------------
tabItem(tabName = "dataInput", source("./UI/01_1_DataInput_UI.R")$value), # Data Input
tabItem(tabName = "taxonomy", source("./UI/01_2_Taxonomy_UI.R")$value), # Taxonomy 
tabItem(tabName = "cusData", source("./UI/01_3_CustomDf_UI.R")$value), # Create reference custom dataset

# Ecological Index -------------------------------------------------------------
tabItem(tabName = "ecoIndex", source("./UI/02_DiversityIndex_UI.R")$value),

# Biomonitoring indices --------------------------------------------------------
tabItem(tabName = "biomIndex", source("./UI/03_BiomonitoringIndex_UI.R")$value),

# Traits -----------------------------------------------------------------------
tabItem(tabName = "inTrait", source("./UI/04_1_inputTraitTable_UI.R")$value), # Input trait table
tabItem(tabName = "manageTrait", source("./UI/04_2_manageTraitTable_UI.R")$value), # Manage trait table
tabItem(tabName = "funIndices", source("./UI/04_3_functionalIndex_UI.R")$value), # Functional indices

# Bibliography -----------------------------------------------------
tabItem(tabName = "biblioRef", source("./UI/05_Bibliography_UI.R")$value)

)
)

ui <- dashboardPage(header, sidebar, body, skin = "black")
