fluidRow(
  column(
    width = 4,
    
    # Description panel
    box(
      width = NULL,
      solidHeader = TRUE,
      HTML(
        "<h3>Trait table management</h3>
        
        <h4>This panel provides information and functions to calculate functional indices based on organism trait information. These indices are applied in different ecology fields (freshwaters, marine, terrestrial) and can provide complementary information compared to taxonomic-based measures.</h4>"
      )
    ),
    
    # Assign Traits ----
    box(
      width = NULL,
      solidHeader = TRUE,
      HTML("<b> Assign traits </b>"),
      checkboxInput("assignTrait", label = "Assign traits", value = FALSE),
      
      selectInput(
        "assTraitsGroup",
        "Biotic group of interest",
        choices = c(
          "Macroinvertebrate" = "mi",
          "Macrophyte" = "mf",
          "Fish" = "fi",
          "Custom" = "cu"
        ),
        selected = "mi",
        multiple = FALSE
      ),
      
      selectInput(
        "assTraitsLevel",
        "Taxonomic level",
        choices = c(
          "Family" = "Family",
          "Subfamily" = "Subfamily",
          "Tribus" = "Tribus",
          "Genus" = "Genus",
          "Species" = "Species",
          "Subspecies" = "Subspecies",
          "Taxa" = "Taxa"
        ),
        selected = "Taxa",
        multiple = FALSE
      ),
      
      selectInput(
        "assFilterDistance",
        "Filter by distance",
        choices = c(
          "Null" = "Null",
          "Positive" = "pos",
          "Negative" = "neg",
          "Numeric" = "numeric"
        ),
        selected = "Null",
        multiple = FALSE
      ),
      
      column(
        6,
        numericInput("assFilterNumeric", "Filter by distance numeric", 0) # <-  quali sono i valori max e min?
      )
    ),
    
    # Manage Traits ----
    box(
      width = NULL,
      solidHeader = TRUE,
      HTML("<b> Manage traits </b>"),
      selectizeInput(
        "traitColumns",
        "Select traits columns",
        choices = NULL,
        multiple = TRUE
      ),
      selectInput(
        "manTraitsNear",
        "Nearest taxonomic distance",
        choices = c(
          "None" = "none",
          "Nearest" = "nearest",
          "Nearest+" = "nearest+",
          "Nearest-" = "nearest-",
          "Nearest+-" = "nearest+-",
          "Neareast-+" = "neareast-+"
        ),
        selected = "none",
        multiple = FALSE
      )
      #checkboxInput("traitNear", label = "Select nearest traits based on taxonomic distance", value = FALSE)
      
      # radioButtons("manTraitsNear", "Nearest taxonomic distance", choiceNames = c("nearest", "nearest+", "nearest-", "nearest+-", "neareast-+"),
      #              choiceValues = c("nearest", "nearest+", "nearest-", "nearest+-", "neareast-+"), selected = "nearest", inline = TRUE)
    ),
    
    # Final table ----
    box(
      width = NULL,
      solidHeader = TRUE,
      HTML("<b> Select final trait table </b>"),
      checkboxInput("avgTraits", label = "Average traits values for fuzzy data", value = FALSE),
      HTML("<h4> Select your column blocks for fyuzzy data </h4>"),
      textInput("colBlockFuzzy", label = NULL, value = "8, 7, 3, 9, 4, 3, 6, 2, 5, 3, 9, 8, 8, 5, 7, 5, 4, 4, 2, 3, 8"),
      #OR
      tags$br(),
      checkboxInput("sampleTraits", label = "Random sampling traits", value = FALSE),
    )
    
    
  ),
  
  
  column(
    width = 8,
    conditionalPanel(
      "input.assignTrait == 1",
      HTML("<h2> Assign traits </h2>"),
      DTOutput("tbl_assignTrait")
    ),
    conditionalPanel(
      condition = "input.traitColumns != ''",
      HTML("<h2> Column trait selected </h2>"),
      DTOutput("tbl_selColumn")
    ),
    conditionalPanel(
      "input.traitNear == 1",
      HTML("<h2> Nearest traits </h2>"),
      DTOutput("tbl_traitNear")
    ),
    conditionalPanel(
      "input.avgTraits == 1",
      HTML("<h2> Average traits </h2>"),
      DTOutput("tbl_avgTraits")
    ),
    conditionalPanel(
      "input.sampleTraits == 1",
      HTML("<h2> Random traits </h2>"),
      DTOutput("tbl_sampleTraits")
    )
  )
  
)