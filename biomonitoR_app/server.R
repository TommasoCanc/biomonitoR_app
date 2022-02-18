##n####################################
# Shiny App biomonitoR v 0.1 - SERVER #
#######################################

server <- function(input, output , session) {
  
  # initialize the object where store all the results of the indices
  # this allow to remove all the previous calculation if a new dataset is provided

# biomonitoR functions ---------------------------------------------------------
source("./Server/01_4_[biomonitoRFunctions]_Server.R", local = T)  
  
# Data Input & Management ------------------------------------------------------
source("./Server/01_1_DataInput_Server.R", local = T) # Data Input
source("./Server/01_2_Taxonomy_Server.R", local = T) # Taxonomy
source("./Server/01_3_CustomDF_Server.R", local = T) # Create reference custom dataset

# Diversity indices ------------------------------------------------------------
source("./Server/02_DiversityIndex_Server.R", local = T)
  
# Biomonitoring indices --------------------------------------------------------
source("./Server/03_BiomonitoringIndex_Server.R", local = T)
  
# Traits -----------------------------------------------------------------------
source("./Server/04_1_inputTraitTable_Server.R", local = T) # Input trait table
source("./Server/04_2_manageTraitTable_Server.R", local = T) # Manage trait table
source("./Server/04_3_functionalIndex_Server.R", local = T) # Functional indices
  
# Bibliography -----------------------------------------------------------------
source("./Server/06_Bibliography_Server.R", local = T)

   }