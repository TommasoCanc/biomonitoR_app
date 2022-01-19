fluidRow(
  
  ##############
  # Right side #
  ##############
  
  column(width = 4,
         box(width = NULL, solidHeader = TRUE,
             HTML("<h3> <b>Custom Trait Table</b> </h3> 
                          This panel ...")),
         
         box(title = "Load file - Custom trait data", solidHeader = FALSE, width = NULL, collapsible = TRUE, collapsed = TRUE,
             HTML("Select your data"),
             fileInput("fileTrait", label = NULL),
             HTML("<h5> Data can be loaded in <b>xlsx</b>, <b>csv</b>, or <b>txt</b> formats.</h5>"),
             checkboxInput("traitCustom", label = "Do you want to use the custom trait dataset as trait reference?", value = FALSE) # <- Transforms abundance to presence-absence.
         )
         ),
  
  #############
  # Left side #
  #############
  
  column(width = 8,
         uiOutput("tbl_inTrait")
         )
  
)

