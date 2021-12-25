library( shiny )
library( shinydashboard )
library( DT )
library( readxl )
library( purrr )
library( hunspell )
library( biomonitoR )
library( ggplot2 )
library( biomonitorweb )
library( tidyr )
library( ade4 )
library( plotly )


header <- dashboardHeader( title = "biomonitoR-web" )

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem( "dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem( "taxonomy check" , tabName = "tassonomia" , icon = icon( "check" ) ) ,
    menuItem( "diversity indices" , tabName = "sinonimi" , icon = icon( "calculator" ) ) ,
    menuItem( "biomonitoring indices" , tabName = "biom" , icon = icon( "calculator" ) ) ,
    menuItem( "import traits table" , tabName = "mtraits" , icon = icon( "file-import" ) ) ,
    menuItem( "manage traits table" , tabName = "tdist" , icon = icon( "calculator" ) ) ,
    menuItem( "functional indices" , tabName = "func" , icon = icon( "calculator" ) ) ,
    menuItem( "more indices" , tabName = "more" , icon = icon( "calculator" ) ) ,
    menuItem( "indices correlation" , tabName = "corr" , icon = icon( "calculator" ) ) ,
    menuItem( "environmental variables" , tabName = "env" , icon = icon( "layer-group" ) ) ,
    menuItem( "map" , tabName = "map" , icon = icon( "map" ) ) ,
    menuItem( "credits" , tabName = "info" , icon = icon( "info" ) )
  )
)

body <- dashboardBody(
  # color as the rest of the header.
  tags$head(tags$style(HTML('
        .skin-blue .main-header .logo {
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
             top: calc(20%);
             left: calc(0%);
             font-size: 34px;
             } 

      '))) ,
  tabItems(
    tabItem( tabName = "dashboard" , 
             
             fluidRow( column( width = 4 ,
                               box( textOutput( "welcome" ) , width = NULL, solidHeader = TRUE  ) ,
                               box(  title = "Load file" , solidHeader = FALSE , width = NULL ,
                                     fileInput( "file1" , label = NULL ) ,
                                     tags$hr(),
                                     radioButtons( "filetype", "", choices = c( "xlsx" , "csv" , "txt" ) , inline = TRUE ) ,
                                     tags$hr(),
                                     radioButtons( "communitytype", "", choiceNames = c( "macroinvertebrates" , "macrophytes" , "fish" ) , choiceValues = c( "mi" , "mf" , "fi"  ) , inline = FALSE ) ,
                                     tags$hr(),
                                     #conditionalPanel( "input.communitytype == 'usr' " , fileInput( "file_c_ref" , label = NULL ) ) ,
                                     #conditionalPanel( "input.communitytype == 'usr' " , tags$hr()  ) ,
                                     radioButtons( "abutype", "", choiceNames = c( "abundance" , "presence_absence" ) , choiceValues = c( "sum" , "bin" ) , inline = TRUE )
                                     
                               ) 
                               
             ) ,
             
             column( width = 8 , 
                     box(  DTOutput( 'tbl' ) , width = NULL  ) )
             
             ) 
             
    ) ,
    
    tabItem(  tabName = "tassonomia",
              
              column(width = 4 ,
                     box( textOutput( "intro_tax" ) , width = NULL, solidHeader = TRUE  ) , 
                     box( uiOutput("col") , width = NULL )
                     
              ),
              
              
              column( width = 8 , 
                      box(  DTOutput( 'tbl4' ) , width = NULL  ) ,
                      box( downloadButton( "download_tax_corr", label = "Download Table" ) , width = NULL ) )
    ) ,
    
    tabItem( tabName = "sinonimi",
             
             fluidRow( column( width = 6,
                     box( textOutput( "intro_div" ) ,
                          uiOutput( "div_taxlev" ) ,
                          width = NULL ) ,
                     box( DTOutput( 'tbl_div' ) ,
                          downloadButton( "download_div", label = "Download Table" ) ,
                          width = NULL  )


             ) ,
             column( width = 6,
                     box( uiOutput( 'div_taxlev_pca' ) , width = NULL ) ,
                     box( plotlyOutput( "div_pca" ) , width = NULL ) ,
                     box( selectizeInput( "var_div_pairs", "Select an index for the scatter plot", choices = character() , multiple = FALSE ) , width = NULL ) ,
                     box( uiOutput( 'div_taxlev_pair' ) , width = NULL ) ,
                     box( radioButtons( "corr_div" , "" , choices = c( "pearson" , "spearman" ) , inline = TRUE ) ,
                          tags$hr() ,
                          verbatimTextOutput("console") , width = NULL ) ,
                     box( plotlyOutput( "ggpairs_div" ) , width = NULL )
             )
            ) 
    ) ,  
    
    
    tabItem( tabName = "info",
             textOutput( "credits" )
    )
    
    
  )
  
  
)


ui <- dashboardPage( header , sidebar , body , skin = "black" )


server <- function(input, output , session ) {
  
  # inititialize the object where store all the results of the indices
  # this allow to remove all the previous calculation if a new dataset is provided
  
  indices <- reactiveValues( df_data = NULL)
  
  
  readInput <- reactive( {
    
    inFile <- input$file1
    
    if (is.null( inFile ) )
      return( NULL )
    
    
    if( input$filetype == "xlsx" ){
      DF_init <- data.frame( read_excel( inFile$datapath , sheet = 1 ) )
    }
    
    
    
    if( input$filetype == "csv" ){
      DF_init <- read.csv( inFile$datapath , header = TRUE , sep = "," )
    }
    
    if( input$filetype == "txt" ){
      DF_init <- read.table( inFile$datapath , header = TRUE  )
    }
    
    
    # validate user input a column called Taxa is needed
    # only one non-numeric column is allowed
    # database needs to have more than 1 column
    
    cond1 <- any( colnames( DF_init ) %in% "Taxa" )
    cond2 <- sum( unlist( lapply( DF_init , is.factor ) ) )
    cond3 <- sum( unlist( lapply( DF_init , is.character ) ) )
    cond4 <- ncol( DF_init ) > 1
    
    if( cond1 & ( ( cond2 + cond3 ) == 1 ) & cond4 ){
      DF <- DF_init
    } else { DF <- NULL }
    
    
    if(  ! cond1  | ( ( cond2 + cond3 ) != 1 ) | ! cond4 ) (showNotification( "Your file does not match the format needed by biomonitoR-web" , type = "error" , duration = NULL ) )
    req( DF , cancelOutput = FALSE )
    
    bioImp <- bioImport( DF , group = input$communitytype )
    bioImp_w <- as.character( unlist( lapply( bioImp , function( x ) ( x[ 1 ] ) ) ) )
    names( bioImp ) <- bioImp_w
    DF[ , "Taxa" ] <- as.character( DF[ , "Taxa" ] )
    
    list( DF = DF , bioImp = bioImp , bioImp_w = bioImp_w  )
    
  } )
  
  
  
  
  
  
  observeEvent( input$file1, {
    indices$df_data <- NULL    
  })
  
  output$tbl <- renderDT({ 
    validate( need( ! is.null( readInput()$DF ) , "waiting for user input" ) )
    
    datatable( readInput()$DF , rownames = FALSE , options = list( lengthChange = FALSE , scrollX = TRUE ) ) } )
  output$welcome <- renderText( "Welcome to biomonitoR-web, a tool for calculating biomonitoring indices.")
  
  
  # Taxonomy check
  
  output$intro_tax <- renderText( paste(  "This page is for checking if your taxa name are correct." , 
                                          "Taxa names are checked against a reference database and if wrong names are
                                  present correct names will be suggested. Currently biomonitoR-web does not allow
                                  to use your own reference database." ,
                                          "Non-identfied taxa will be discarded.", sep="\n" ) )
  
  
  
  output$col <- renderUI({
    temp <- readInput()$bioImp
    map( readInput()$bioImp_w , ~ selectInput( .x , label = .x , choices = c( "none" , as.character( unlist( temp[ .x ] ) )[-1] ) ) )
  })
  
  
  
  DF_def <- reactive({
    
    if( length( readInput()$bioImp_w) == 0 ){
      readInput()$DF
    } else {
      get.char <- map_chr( readInput()$bioImp_w , ~ default_val(input[[.x]], NA) )
      modTaxa <- data.frame( Taxa = readInput()$bioImp_w , Taxa_w = get.char , stringsAsFactors = FALSE )
      temp <- data.frame( readInput()$DF )
      if( any( modTaxa[ , 2 ] %in% "none" ) ){
        temp <- temp[ ! temp$Taxa %in% modTaxa[ modTaxa[ , 2 ] == "none" , "Taxa" ], , drop = FALSE ]
      }
      
      temp$Taxa[ temp$Taxa %in% modTaxa[ , 1 ] ] <- modTaxa[ modTaxa[ , 1 ] %in% temp$Taxa , 2 ]
      temp <- temp[ ! is.na( temp$Taxa ) , ]
      temp
      
    }
  })
  
  
  
  output$tbl4 <- renderDT( {
    validate( need( ! is.null( readInput()$DF ) , "waiting for user input" ) )
    
    datatable( DF_def() , rownames = FALSE , options = list( lengthChange = FALSE , scrollX = TRUE ) )  })
  
  
  output$download_tax_corr <- downloadHandler(
    filename = function() {
      paste( "taxa_corrected", Sys.Date() , ".csv", sep = "")
    },
    content = function(file) {
      write.csv( DF_def() , file, row.names = FALSE)
    }
  )  
  
  ### preliminary biomonitoR operations =======
  
  # create the biomonitoR object
  # this will be used for all the calculations
  
  asb_obj <- reactive({
    commtype <- input$communitytype
    abutype <- input$abutype
    validate( need( DF_def() , "" ) )
    aggregatoR( asBiomonitor( DF_def() , group = input$communitytype , FUN = get( abutype )  ) )
    
  } )
  
  
  # calculate richness for family, genus, species and taxa. Useful to set the elements of radioButtons.
  # Richness below 3 will not be taken into account
  
  tax_lev_list <- reactive({
    validate( need( DF_def() , "" ) )
    temp.tot <- totInfo( asb_obj() )
    temp.tot <- temp.tot[ names( temp.tot ) %in% c( "Family" , "Genus" , "Species" , "Taxa" ) ]
    names( temp.tot[ temp.tot > 3] )
  })

  
  
  ### diversity indices =======
  
  # introductory text to let the user know what the page refers to
  output$intro_div <- renderText( paste(  "Several diversity indices are calculated. Please chose the taxonomic level at which you want to calculate the indices", sep="\n" ) )
  
  # set the taxLev choices for radioButtons

  output$div_taxlev <- renderUI({
    radioButtons( "div_taxlev", "" , choices = tax_lev_list() , selected = "Taxa" , inline = TRUE )
  })
  

  # create a reactive list containing diversity indices calculated at different taxonomic levels
  div_ind_reactive <- reactive({ 
    validate( need( ! is.null( input$div_taxlev ) , "" ) )
    res_div <- lapply( as.list( tax_lev_list() ) , function( x ) apply( allindices( asb_obj() , x )  , 2 , function( x ) round( x , 2 ) ) )
    names( res_div ) <-  tax_lev_list()
    res_div
  })
  
  # put in table diversity indices at the desired taxonomic level 
  output$tbl_div <- renderDT({
    datatable( div_ind_reactive()[[ input$div_taxlev ]] , rownames = TRUE , options = list( columnDefs = list(list(className = 'dt-center', targets = "all" ) ) , scrollX = TRUE , lengthChange = FALSE ) )
  })

  # set the download button for downloading the table output$tbl_div
  output$download_div <- downloadHandler(
    filename = function() {
      paste( "diversity_indices_", input$div_taxlev , "_" ,  Sys.Date() , ".csv", sep = "")
    },
    content = function(file) {
      write.csv( div_ind_reactive()[[ input$div_taxlev ]] , file, row.names = FALSE)
    }
  )
  
  
  observeEvent( div_ind_reactive() , {
    updateSelectizeInput( session, "var_div_pairs", choices = names( as.data.frame( div_ind_reactive()[["Taxa"]] ) ) )
  })
  

  output$div_taxlev_pair<- renderUI({
    
    selectizeInput( inputId = 'div_id',
                   label = 'Select the taxonomic levels to plot', 
                   choices = tax_lev_list() ,
                   multiple = TRUE , 
                   options = list( maxItems = 2 ) ) 
  }) 
  
  
  div_cor_plot <- reactive({
    choices_div_tax <- input$div_id
    validate( need( ! is.null( choices_div_tax ) , "" )  )
    validate( need( length( choices_div_tax ) == 2 , "" )  )
    
    temp <- div_ind_reactive( )[ names( div_ind_reactive( ) ) %in% choices_div_tax ]
    pairs_div <- as.data.frame( do.call( cbind , lapply( temp , function( x ) x[ , input$var_div_pairs , drop = FALSE ] ) )  )
    names( pairs_div ) <- choices_div_tax
    rownames( pairs_div ) <- rownames( div_ind_reactive()[["Taxa"]] )
    list( pairs_div , choices_div_tax  )
  })
  
  output$ggpairs_div <- renderPlotly({
    pairs_div <- div_cor_plot()[[ 1 ]]
    choices_div_tax <- div_cor_plot()[[ 2 ]]
    div_pairs <- plot_ly(data = pairs_div, x = ~ .data[[choices_div_tax[1]]] , y = ~ .data[[choices_div_tax[2]]] , type = "scatter" ,
            text = rownames( pairs_div ) , mode   = 'markers' ,size = 14 )
    div_pairs <- add_lines( div_pairs , y = ~fitted(loess( .data[[choices_div_tax[2]]]  ~ .data[[choices_div_tax[1]]] ) ) , name = "Loess Smoother" , 
                            size = 0.5 , showlegend = TRUE , alpha =0.5 )
    div_pairs <- div_pairs %>% layout( xaxis = list( title = choices_div_tax[1] ) , yaxis = list( title = choices_div_tax[ 2 ] ) ,
                                       legend = list(orientation = "h") )
    div_pairs
    
  })
  
  
  output$console <- renderPrint({
    pairs_div <- div_cor_plot()[[ 1 ]]
    choices_div_tax <- div_cor_plot()[[ 2 ]]
    div_formula <- as.formula( paste(  "~" , choices_div_tax[ 1 ] , "+" , choices_div_tax[2] ) )

    cor.test( div_formula , data = pairs_div , method = input$corr_div )


  })

  
  output$div_taxlev_pca<- renderUI({
    
    checkboxGroupInput( inputId = 'div_pca_id',
                    label = 'Select the taxonomic levels for the PCA', 
                    choices = tax_lev_list() , inline = TRUE , selected = "Taxa" ) 
  }) 

  # PCA
  all_tax_div <- reactive({
    validate( need( ! is.null( tax_lev_list() ) , "" ) )
    all.ind.taxl <- lapply( as.list( tax_lev_list() ) , FUN = function( x ) data.frame( Site = colnames( asb_obj()[[ x ]] )[ -1 ] , Tax_lev = rep( x , ncol( asb_obj( )[[ x ]] ) - 1 ) , allindices( asb_obj( ) , x ) )  )
    names( all.ind.taxl ) <- tax_lev_list()
    all.ind.taxl <- all.ind.taxl[ names( all.ind.taxl ) %in% input$div_pca_id ]
    
    all.ind.taxl
    
  })
  
  
  output$div_pca <- renderPlotly({
    validate( need( length( input$div_pca_id ) > 0 , "waiting for user choice" ) )
    div.pca.var <- do.call( cbind , all_tax_div()  )
    div.pca <- dudi.pca( div.pca.var[ , -c( grep( "Site|Tax_lev" , colnames( div.pca.var )  ) ) ] , scale = TRUE , center = TRUE , nf = 2 , scannf = FALSE )
    div.eigen <- round( div.pca$eig / sum( div.pca$eig ) , 3 ) * 100
    div.pca <- div.pca$c1
    div.pca.text <- colnames( div.pca.var[ , -c( grep( "Site|Tax_lev" , colnames( div.pca.var )  ) ) ] )
    div.pca.text <- gsub( "\\." , "_" , div.pca.text )
    div.pca.text.col <- sub( "_.*" , "" , div.pca.text )

    p <- plot_ly( div.pca , x = ~CS1 , y = ~CS2 , text = div.pca.text ,
                  mode = "markers" , color = ~div.pca.text.col ,  marker = list( size = 22 ) , type = "scatter" , colors = "Set1" )
    p <- layout(p,title="PCA of Indices",
                xaxis=list(title= paste( "PC1 (" , div.eigen[ 1 ] , " %)" , sep = ""  ) ),
                yaxis=list(title=paste( "PC2 (" , div.eigen[ 2 ] , " %)" , sep = ""  )) )
    p
    
    
  } )

  
  # credits

  output$credits<- renderText( paste(  "This package is based upon work from COST Action CA15113 (SMIRES, Science and Management of Intermittent Rivers and Ephemeral Streams,www.smires.eu), supported by COST (European Cooperation in Science and Technology).", sep="\n" ) )




  
  
  
  
  
  
}




default_val <- function(x, value) {
  if (isTruthy(x)) {
    x
  } else {
    value
  } 
}


shinyApp( ui, server)





