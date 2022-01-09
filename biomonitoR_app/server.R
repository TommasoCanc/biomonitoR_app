##n####################################
# Shiny App biomonitoR v 0.1 - SERVER #
#######################################

server <- function(input, output , session) {
  
  # initialize the object where store all the results of the indices
  # this allow to remove all the previous calculation if a new dataset is provided
  
# Data input -------------------------------------------------------------------
source("./Server/DataInput_Server.R", local = T)

# Taxonomy check ---------------------------------------------------------------
source("./Server/Taxonomy_Server.R", local = T)
  
# biomonitoR functions ---------------------------------------------------------
source("./Server/biomonitoRFunctions.R", local = T)

# Diversity indices ------------------------------------------------------------
source("./Server/DiversityIndex_Server.R", local = T)
  
# Traits -----------------------------------------------------------------------
# Manage trait table ----
source("./Server/ManageTraitTable_Server.R", local = T)

# Biomonitoring indices --------------------------------------------------------
source("./Server/BiomonitoringIndex_Server.R", local = T)

# Custom Reference Dataset -----------------------------------------------------
source("./Server/CustomRefDataset.R", local = T)

   }