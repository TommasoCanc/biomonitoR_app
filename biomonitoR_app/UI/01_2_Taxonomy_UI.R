fluidRow(
  
  ##############
  # Right side #
  ##############
  
  column(width = 4 ,
         box(width = NULL, solidHeader = TRUE,
             HTML("<h3>Taxonomy check</h3> 
                  
                  This panel helps to check the nomenclature of the users’ taxa and eventually remove or correct controversial names (e.g., due to typographic errors, nomenclature changes, obsolete format).
                  
                  <br>
                  <br>
                  
                  Taxa names are checked and compared against the <i><b>community-type reference dataset</b></i> or using a personal-user dataset (see <i><b>Custom Reference Dataset</b></i> section), if loaded. 
                  
                  <br> 
                  <br>
                  
                  If potentially erroneous names are detected, suggestions are provided to help the user. 
                  
                  <br>
                  <br>
                  
                  Non-identfied taxa will be discarded."
                  )
             ),
uiOutput("correctNames"), # Open the box with correct names suggestions
  
# Remove taxa ----
# Which taxon/a do you u want to remove from your dataset?
box(title = "Remove taxa", solidHeader = FALSE, width = NULL, collapsible = TRUE, collapsed = TRUE,
    selectizeInput("removeTaxa", "Select the taxa to exclude from your dataset",
                   choices = NULL, multiple = TRUE)
)

),


#############
# Left side #
#############

column(width = 8,
       uiOutput("tblTaxonomy"),
       uiOutput("tblRmTaxa")
)

)