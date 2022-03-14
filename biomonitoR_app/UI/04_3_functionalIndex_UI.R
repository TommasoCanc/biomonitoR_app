fluidRow(
  ##############
  # Right side #
  ##############
  
  column(
    width = 4,
    box(
      width = NULL,
      solidHeader = TRUE,
      HTML(
        "<h3>Functional Indices</h3>
        
           This panel provides several functions to functional indices. Please see the <i><b>Help</b></i> panel for further details about each index."
      )
    ),
    
    # Functional dispersion ----
    box(
      title = "Functional dispersion",
      width = NULL,
      solidHeader = TRUE,
      collapsible = TRUE,
      collapsed = TRUE,
      HTML("<h5>R function in biomonitoR: <b>f_disp</b></h5>"),
      checkboxInput("funDisp", label = "Functional dispersion", value = FALSE),
      # Functional dispersion
      selectInput(
        "f_disp.tax_lev",
        "Taxa level",
        choices = c(
          "Family" = "Family",
          "Genus" = "Genus",
          "Species" = "Species",
          "Taxa" = "Taxa"
        ),
        selected = "Taxa",
        multiple = FALSE
      ),
      selectInput(
        "f_disp.type",
        "Variable type",
        choices = c("Fuzzy" = "F",
                    "Continuous" = "C"),
        selected = "F",
        multiple = FALSE
      ),
      checkboxInput("f_disp.traitSel", label = "Trait selection", value = FALSE),
      # col_blocks
      numericInput("f_disp.nbdim", "Multispace dimension", 2),
      selectInput(
        "f_disp.distance",
        "Functional distance",
        choices = c("Euclidean" = "euclidean",
                    "Gower" = "gower"),
        selected = "euclidean",
        multiple = FALSE
      ),
      checkboxInput("f_disp.zerodist_rm", label = "Zero distance", value = FALSE),
      selectInput(
        "f_disp.correction",
        "Correction method",
        choices = c(
          "None" = "none",
          "Lingoes" = "lingoes",
          "Cailliez" = "cailliez",
          "Square Root" = "sqrt",
          "Quasi" = "quasi"
        ),
        selected = "none",
        multiple = FALSE
      ),
      checkboxInput("f_disp.traceB", label = "trace B", value = FALSE),
      HTML("Fine tuning parameters"),
      numericInput("f_disp.max_nbdim", "Max n. dimensions", 15),
      selectInput(
        "f_disp.prec",
        "Prec",
        choices = c("Qt" = "Qt",
                    "Qj" = "Qj"),
        selected = "Qj",
        multiple = FALSE
      ),
      numericInput("f_disp.tol", "Tolerance", .0000001),
      checkboxInput("f_disp.cor.zero", label = "cor.zero", value = TRUE)
    ),
    
    # Functional diversity ----
    box(
      title = "Functional diversity",
      width = NULL,
      solidHeader = TRUE,
      collapsible = TRUE,
      collapsed = TRUE,
      HTML("<h5>R function in biomonitoR: <b>f_divs</b></h5>"),
      checkboxInput("funDivs", label = "Functional diversity", value = FALSE),
      # Functional diversity
      selectInput(
        "f_divs.tax_lev",
        "Taxa level",
        choices = c(
          "Family" = "Family",
          "Genus" = "Genus",
          "Species" = "Species",
          "Taxa" = "Taxa"
        ),
        selected = "Taxa",
        multiple = FALSE
      ),
      selectInput(
        "f_divs.type",
        "Variable type",
        choices = c("Fuzzy" = "F",
                    "Continuous" = "C"),
        selected = "F",
        multiple = FALSE
      ),
      checkboxInput("f_divs.traitSel", label = "Trait selection", value = FALSE),
      # col_blocks
      selectInput(
        "f_divs.distance",
        "Functional distance",
        choices = c("Euclidean" = "euclidean",
                    "Gower" = "gower"),
        selected = "euclidean",
        multiple = FALSE
      ),
      checkboxInput("f_divs.zerodist_rm", label = "Zero distance", value = FALSE),
      selectInput(
        "f_divs.correction",
        "Correction method",
        choices = c(
          "None" = "none",
          "Lingoes" = "lingoes",
          "Cailliez" = "cailliez",
          "Square Root" = "sqrt",
          "Quasi" = "quasi"
        ),
        selected = "none",
        multiple = FALSE
      ),
      checkboxInput("f_divs.traceB", label = "trace B", value = FALSE),
      HTML("Fine tuning parameters"),
      numericInput("f_divs.max_nbdim", "Max n. dimensions", 15),
      selectInput(
        "f_divs.prec",
        "Prec",
        choices = c("Qt" = "Qt",
                    "Qj" = "Qj"),
        selected = "Qj",
        multiple = FALSE
      ),
      numericInput("f_divs.tol", "Tolerance", .0000001),
      checkboxInput("f_divs.cor.zero", label = "cor.zero", value = TRUE)
    ),
    
    # Functional evenness ----
    box(
      title = "Functional evenness",
      width = NULL,
      solidHeader = TRUE,
      collapsible = TRUE,
      collapsed = TRUE,
      HTML("<h5>R function in biomonitoR: <b>f_eve</b></h5>"),
      checkboxInput("funEve", label = "Functional evenness", value = FALSE),
      # Functional evenness
      selectInput(
        "f_eve.tax_lev",
        "Taxa level",
        choices = c(
          "Family" = "Family",
          "Genus" = "Genus",
          "Species" = "Species",
          "Taxa" = "Taxa"
        ),
        selected = "Taxa",
        multiple = FALSE
      ),
      selectInput(
        "f_eve.type",
        "Variable type",
        choices = c("Fuzzy" = "F",
                    "Continuous" = "C"),
        selected = "F",
        multiple = FALSE
      ),
      checkboxInput("f_eve.traitSel", label = "Trait selection", value = FALSE),
      # col_blocks
      numericInput("f_eve.nbdim", "Multispace dimension", 2),
      selectInput(
        "f_eve.distance",
        "Functional distance",
        choices = c("Euclidean" = "euclidean",
                    "Gower" = "gower"),
        selected = "euclidean",
        multiple = FALSE
      ),
      checkboxInput("f_eve.zerodist_rm", label = "Zero distance", value = FALSE),
      selectInput(
        "f_eve.correction",
        "Correction method",
        choices = c(
          "None" = "none",
          "Lingoes" = "lingoes",
          "Cailliez" = "cailliez",
          "Square Root" = "sqrt",
          "Quasi" = "quasi"
        ),
        selected = "none",
        multiple = FALSE
      ),
      checkboxInput("f_eve.traceB", label = "trace B", value = FALSE),
      HTML("Fine tuning parameters"),
      numericInput("f_eve.max_nbdim", "Max n. dimensions", 15),
      selectInput(
        "f_eve.prec",
        "Prec",
        choices = c("Qt" = "Qt",
                    "Qj" = "Qj"),
        selected = "Qj",
        multiple = FALSE
      ),
      numericInput("f_eve.tol", "Tolerance", .0000001),
      checkboxInput("f_eve.cor.zero", label = "cor.zero", value = TRUE)
    ),
    
    # Functional redundancy ----
    box(
      title = "Functional redundancy",
      width = NULL,
      solidHeader = TRUE,
      collapsible = TRUE,
      collapsed = TRUE,
      HTML("<h5>R function in biomonitoR: <b>f_red</b></h5>"),
      checkboxInput("funRed", label = "Functional redundancy", value = FALSE),
      # Functional redundancy
      selectInput(
        "f_red.tax_lev",
        "Taxa level",
        choices = c(
          "Family" = "Family",
          "Genus" = "Genus",
          "Species" = "Species",
          "Taxa" = "Taxa"
        ),
        selected = "Taxa",
        multiple = FALSE
      ),
      selectInput(
        "f_red.type",
        "Variable type",
        choices = c("Fuzzy" = "F",
                    "Continuous" = "C"),
        selected = "F",
        multiple = FALSE
      ),
      checkboxInput("f_red.traitSel", label = "Trait selection", value = FALSE),
      # col_blocks
      selectInput(
        "f_red.distance",
        "Functional distance",
        choices = c("Euclidean" = "euclidean",
                    "Gower" = "gower"),
        selected = "euclidean",
        multiple = FALSE
      ),
      checkboxInput("f_red.zerodist_rm", label = "Zero distance", value = FALSE),
      selectInput(
        "f_red.correction",
        "Correction method",
        choices = c(
          "None" = "none",
          "Lingoes" = "lingoes",
          "Cailliez" = "cailliez",
          "Square Root" = "sqrt",
          "Quasi" = "quasi"
        ),
        selected = "none",
        multiple = FALSE
      ),
      checkboxInput("f_red.traceB", label = "trace B", value = FALSE),
      HTML("Fine tuning parameters"),
      numericInput("f_red.max_nbdim", "Max n. dimensions", 15),
      selectInput(
        "f_red.prec",
        "Prec",
        choices = c("Qt" = "Qt",
                    "Qj" = "Qj"),
        selected = "Qj",
        multiple = FALSE
      ),
      numericInput("f_red.tol", "Tolerance", .0000001),
      checkboxInput("f_red.cor.zero", label = "cor.zero", value = TRUE)
    ),
    
    # Functional richness ----
    box(
      title = "Functional richness",
      width = NULL,
      solidHeader = TRUE,
      collapsible = TRUE,
      collapsed = TRUE,
      HTML("<h5>R function in biomonitoR: <b>f_rich</b></h5>"),
      checkboxInput("funRich", label = "Functional richness", value = FALSE),
      # Functional richness
      selectInput(
        "f_rich.tax_lev",
        "Taxa level",
        choices = c(
          "Family" = "Family",
          "Genus" = "Genus",
          "Species" = "Species",
          "Taxa" = "Taxa"
        ),
        selected = "Taxa",
        multiple = FALSE
      ),
      selectInput(
        "f_rich.type",
        "Variable type",
        choices = c("Fuzzy" = "F",
                    "Continuous" = "C"),
        selected = "F",
        multiple = FALSE
      ),
      checkboxInput("f_rich.traitSel", label = "Trait selection", value = FALSE),
      # col_blocks
      numericInput("f_rich.nbdim", "Multispace dimension", 2),
      selectInput(
        "f_rich.distance",
        "Functional distance",
        choices = c("Euclidean" = "euclidean",
                    "Gower" = "gower"),
        selected = "euclidean",
        multiple = FALSE
      ),
      checkboxInput("f_rich.zerodist_rm", label = "Zero distance", value = FALSE),
      selectInput(
        "f_rich.correction",
        "Correction method",
        choices = c(
          "None" = "none",
          "Lingoes" = "lingoes",
          "Cailliez" = "cailliez",
          "Square Root" = "sqrt",
          "Quasi" = "quasi"
        ),
        selected = "none",
        multiple = FALSE
      ),
      checkboxInput("f_rich.traceB", label = "trace B", value = FALSE),
      HTML("Fine tuning parameters"),
      numericInput("f_rich.max_nbdim", "Max n. dimensions", 15),
      selectInput(
        "f_rich.prec",
        "Prec",
        choices = c("Qt" = "Qt",
                    "Qj" = "Qj"),
        selected = "Qj",
        multiple = FALSE
      ),
      numericInput("f_rich.tol", "Tolerance", .0000001),
      checkboxInput("f_rich.cor.zero", label = "cor.zero", value = TRUE)
    )
    
  ),
  
  #############
  # Left side #
  #############
  column(
    width = 8,
    conditionalPanel(
      "input.funDisp == 1",
      box(
        width = NULL,
        solidHeader = TRUE,
        HTML("<h3> Functional dispersion </h3>"),
        DTOutput("tbl_f_disp"),
        downloadButton("download_f_disp", label = "Download Table")
      )
    ),
    
    conditionalPanel(
      "input.funDivs == 1",
      box(
        width = NULL,
        solidHeader = TRUE,
        HTML("<h3> Functional dispersion </h3>"),
        DTOutput("tbl_f_divs"),
        downloadButton("download_f_divs", label = "Download Table")
      )
    ),
    
    conditionalPanel(
      "input.funEve == 1",
      box(
        width = NULL,
        solidHeader = TRUE,
        HTML("<h3> Functional evenness </h3>"),
        DTOutput("tbl_f_eve"),
        downloadButton("download_f_eve", label = "Download Table")
      )
    ),
    
    conditionalPanel(
      "input.funRed == 1",
      box(
        width = NULL,
        solidHeader = TRUE,
        HTML("<h3> Functional redundancy </h3>"),
        DTOutput("tbl_f_red"),
        downloadButton("download_f_red", label = "Download Table")
      )
    ),
    
    conditionalPanel(
      "input.funRich == 1",
      box(
        width = NULL,
        solidHeader = TRUE,
        HTML("<h3> Functional richness </h3>"),
        DTOutput("tbl_f_rich"),
        downloadButton("download_f_rich", label = "Download Table")
      )
    )
  )
)