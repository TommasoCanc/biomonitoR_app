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
    menuItem("Data Input & Management", tabName = "dataInput", icon = icon("folder-open", lib = "glyphicon")), # <- Input data
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
body <- dashboardBody(tags$head(tags$style(source("./UI/css.R")$value)), # color as the rest of the header.

# Panel content ---------------------------------------------------------------
tabItems(tabItem(tabName = "about", source("./UI/about.R")$value), # about
  
# Data Input & Management ------------------------------------------------------
tabItem(tabName = "dataInput", source("./UI/DataInput_UI.R")$value),

# Taxonomy ---------------------------------------------------------------------
tabItem(tabName = "taxonomy", source("./UI/Taxonomy_UI.R")$value),

# Ecological Index -------------------------------------------------------------
tabItem(tabName = "ecoIndex", source("./UI/EcologicalIndex_UI.R")$value),

# Biomonitoring indices --------------------------------------------------------
tabItem(tabName = "biomIndex", source("./UI/BiomonitoringIndex_UI.R")$value),

# Reference custom dataset -----------------------------------------------------
tabItem(tabName = "cusData", source("./UI/CustomDf_UI.R")$value)

)
)

ui <- dashboardPage(header, sidebar, body, skin = "black")