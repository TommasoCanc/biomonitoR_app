##n####################################
# Shiny App biomonitoR v 0.1 - SERVER #
#######################################

server <- function(input, output , session) {
  
  # initialize the object where store all the results of the indices
  # this allow to remove all the previous calculation if a new dataset is provided
  
# Data input -------------------------------------------------------------------
 
# indices <- reactiveValues(df_data = NULL)

readInput <- reactive({
  
# Dataset with taxa and sampling site    
inFile <- input$file1
  if (is.null(inFile))
    return(NULL)
  if(input$filetype == "xlsx"){
     DF_init <- data.frame(read_excel(inFile$datapath, sheet = 1))
    }
  if(input$filetype == "csv"){
     DF_init <- read.csv(inFile$datapath, header = TRUE, sep = ",")
    }
  if(input$filetype == "txt"){
     DF_init <- read.table(inFile$datapath, header = TRUE)
  }


if(input$communitytype == "cu"){
  inFile2 <- input$file2
  if (is.null(inFile2))
    return(NULL)
  if(input$filetypeCustom == "xlsx"){
    DF_cust <- data.frame(read_excel(inFile2$datapath, sheet = 1))
  }
  if(input$filetypeCustom == "csv"){
    DF_cust <- read.csv(inFile2$datapath, header = TRUE, sep = ",")
  }
  if(input$filetypeCustom == "txt"){
    DF_cust <- read.table(inFile2$datapath, header = TRUE)
  }

# ADD validity consitions  
  
  }

# validate user input a column called Taxa is needed
# only one non-numeric column is allowed
# database needs to have more than 1 column
    
cond1 <- any(colnames(DF_init) %in% "Taxa") # Check if exist the column named taxa.
cond2 <- sum(unlist(lapply(DF_init, is.factor))) # Check if there are columns as factor
cond3 <- sum(unlist(lapply(DF_init, is.character))) # Check if there are columns as character. Only the taxa column have to be character
cond4 <- ncol(DF_init) > 1 # Check if there are more than 1 column

# Verify conditions 1 Dataset taxonomy
if(cond1 & ((cond2 + cond3) == 1) & cond4){
   DF <- DF_init
    } else { DF <- NULL }

# Verify conditions 2 Dataset taxonomy
if(!cond1 | ((cond2 + cond3) != 1) | !cond4){
  (showNotification("Your file does not match with the biomonitoR-app format.", type = "error", duration = NULL))
   req(DF , cancelOutput = FALSE)
}


if(input$communitytype != "cu"){
  bioImp <- bioImport(DF, group = input$communitytype) # communitytype: "macroinvertebrates", "macrophytes", "fish". Import the dataframe with the community reference
  bioImp_w <- as.character(unlist(lapply(bioImp , function(x) (x[1]))))
  names(bioImp) <- bioImp_w
  DF[ ,"Taxa"] <- as.character(DF[ ,"Taxa"])
} else {
  bioImp <- bioImport(DF, group = NULL, dfref = DF_cust) # communitytype: "macroinvertebrates", "macrophytes", "fish". Import the dataframe with the community reference
  bioImp_w <- as.character(unlist(lapply(bioImp , function(x) (x[1]))))
  names(bioImp) <- bioImp_w
  DF[ ,"Taxa"] <- as.character(DF[ ,"Taxa"])
}

  list(DF = DF , bioImp = bioImp , bioImp_w = bioImp_w)
    
})

# observeEvent(input$file1, {
#    indices$df_data <- NULL
#  })

output[["tbl"]] <- renderUI({
  if(is.null(input$file1)){
         showNotification("Data do not upload", duration = 5, type = "warning", closeButton = TRUE)
      } 
  if(!is.null(input$file1)){
      box(width = NULL, solidHeader = FALSE,
       datatable(readInput()$DF, rownames = FALSE, options = list(lengthChange = FALSE, scrollX = FALSE))
       )}
})

# Taxonomy check ---------------------------------------------------------------
DF_def <- reactive({

  if(length(readInput()$bioImp_w) == 0){
    readInput()$DF
  } else {
    get.char <- map_chr(readInput()$bioImp_w, ~ default_val(input[[.x]], NA))
    modTaxa <- data.frame(Taxa = readInput()$bioImp_w, Taxa_w = get.char, stringsAsFactors = FALSE)
    temp <- data.frame(readInput()$DF)
    if(any( modTaxa[ ,2] %in% "none")){
      temp <- temp[!temp$Taxa %in% modTaxa[modTaxa[ ,2] == "none", "Taxa"], drop = FALSE, ]
    }

    temp$Taxa[temp$Taxa %in% modTaxa[ ,1]] <- modTaxa[modTaxa[ ,1] %in% temp$Taxa, 2]
    temp <- temp[!is.na(temp$Taxa), ]
    temp
  }
})


output[["correctNames"]] <- renderUI({ # Show box with nomenclature suggestions
  temp <- readInput()$bioImp
  if(length(readInput()$bioImp_w) == 0 & exists("readInput()$bioImp_w")){
    showNotification("All names are correct!", duration = 5, type = "message", closeButton = TRUE)
  }
  if(length(readInput()$bioImp_w) != 0){
    box(width = NULL, solidHeader = FALSE,
    map(readInput()$bioImp_w, ~ selectInput(.x, label = .x, choices = c("none" , as.character(unlist(temp[.x]))[-1]))
        ))  
  }

})

output[["tblTaxonomy"]] <- renderUI({ # Show nomenclature table
  if(is.null(readInput()$DF)){
    showNotification("Data do not upload", duration = 5, type = "warning", closeButton = TRUE)
  } 
  if(!is.null(readInput()$DF)){
    box(width = NULL, solidHeader = FALSE,
        datatable(DF_def(), rownames = FALSE, options = list(lengthChange = FALSE, scrollX = TRUE))
    )}
})

# Download button
  output$downloadNomenclature <- downloadHandler(
    filename = function() {
      paste("taxa_corrected_nomenclature_", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      write.csv(DF_def(), file, row.names = FALSE)
    }
  )

# biomonitoR functions ---------------------------------------------------------
   
# create the biomonitoR object
# this will be used for all the calculations

asb_obj <- reactive({

    commtype <- input$communitytype
    abutype <- input$abutype
    validate(need(DF_def(), ""))
    
    if(input$communitytype != "cu"){
    aggregate_taxa(as_biomonitor(DF_def(), group = input$communitytype, FUN = get(abutype))) # Convert to biomonitoR format
    } else {
      aggregate_taxa(as_biomonitor(DF_def(), group = "mi", dfref = readInput()$DF_cust, FUN = get(abutype))) # Convert to biomonitoR format
    }
    } )

# calculate richness for family, genus, species and taxa. Useful to set the elements of radioButtons.
# Richness below 3 will not be taken into account

  tax_lev_list <- reactive({
    validate(need(DF_def(), ""))
    temp.tot <- general_info(asb_obj()) # number of taxonomic ranks and abundance
    temp.tot <- temp.tot[names(temp.tot) %in% c("Family", "Genus", "Species", "Taxa")] # Subset only the four taxon rank
    names(temp.tot[temp.tot > 3])
  })

# Diversity indices ----

observe({ # Create a RadioButtons with the results of tax_lev_list()
    updateRadioButtons(session, "div_taxlev", choices = tax_lev_list(), inline = TRUE)
  })
  
# create a reactive list containing diversity indices calculated at different taxonomic levels
div_ind_reactive <- reactive({
  validate(need(!is.null(input$div_taxlev), ""))
  res_div <- lapply(as.list(tax_lev_list()), function(x) apply(allindices(asb_obj(), x), 2, function(x) round(x, 2)))
  names(res_div) <- tax_lev_list()
  res_div
})
  
output$tbl_div <- renderDT({ # table with diversity indices
    datatable(div_ind_reactive()[[input$div_taxlev]], rownames = TRUE,
              options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                             scrollX = TRUE, lengthChange = FALSE))
  })

output$download_div <- downloadHandler( # set the download button for downloading the table diversity index table
  filename = function() {
    paste("diversity_indices_", input$div_taxlev, "_",  Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    write.csv(div_ind_reactive()[[input$div_taxlev]], file, row.names = FALSE)
  }
)

# PCA ----
observeEvent(div_ind_reactive(), {
  updateSelectizeInput(session, "var_div_pairs", choices = names(as.data.frame(div_ind_reactive()[["Taxa"]])))
})

observe({ # Create a RadioButtons with the results of tax_lev_list()
  updateCheckboxGroupInput(session, "div_taxPCA", choices = tax_lev_list(), selected = "Taxa", inline = TRUE)
})

all_tax_div <- reactive({
  #validate(need(!is.null(tax_lev_list()), ""))
  all.ind.taxl <- lapply(as.list(input$div_taxPCA) , FUN = function(x) data.frame(Site = colnames(asb_obj()[[x]])[-1], Tax_lev = rep(x, ncol(asb_obj()[[ x ]]) - 1), allindices(asb_obj(), x)))
  names(all.ind.taxl) <- input$div_taxPCA
  all.ind.taxl <- all.ind.taxl[names(all.ind.taxl) %in% input$div_taxPCA]
  all.ind.taxl
})

output$div_pca <- renderPlotly({
  #validate(need(length(input$div_taxPCA) > 0 , "Waiting for user choice"))
  div.pca.var <- do.call(cbind, all_tax_div())
  div.pca <- dudi.pca(div.pca.var[ ,-c( grep("Site|Tax_lev", colnames(div.pca.var)))], scale = TRUE, center = TRUE, nf = 2, scannf = FALSE)
  div.eigen <- round(div.pca$eig / sum(div.pca$eig), 3) * 100
  div.pca <- div.pca$c1
  div.pca.text <- colnames(div.pca.var[ , -c( grep("Site|Tax_lev", colnames(div.pca.var)))])
  div.pca.text <- gsub( "\\." , "_" , div.pca.text)
  div.pca.text.col <- sub( "_.*", "", div.pca.text)
  
  p <- plot_ly(div.pca, x = ~ CS1, y = ~ CS2, text = div.pca.text,
               mode = "markers", color = ~div.pca.text.col, marker = list(size = 10), type = "scatter", colors = "Set1")
  p <- layout(p, title="PCA of Indices",
              xaxis=list(title= paste("PC1 (", div.eigen[1], " %)", sep = "")),
              yaxis=list(title=paste("PC2 (", div.eigen[2], " %)", sep = "")))
  p
} )

# Scatter plot ----







output$div_taxlev_pair<- renderUI({
  selectizeInput(inputId = 'div_id',
                 label = 'Select the taxonomic levels to plot',
                 choices = input$div_taxlev,
                 multiple = TRUE ,
                 options = list(maxItems = 2))
})

  div_cor_plot <- reactive({
    choices_div_tax <- input$div_id
    validate(need(!is.null(choices_div_tax), ""))
    validate(need(length(choices_div_tax) == 2, ""))

    temp <- div_ind_reactive()[names(div_ind_reactive()) %in% choices_div_tax]
    pairs_div <- as.data.frame(do.call(cbind, lapply(temp, function(x) x[ ,input$var_div_pairs, drop = FALSE])))
    names(pairs_div) <- choices_div_tax
    rownames(pairs_div) <- rownames(div_ind_reactive()[["Taxa"]])
    list(pairs_div, choices_div_tax)
  })

  output$ggpairs_div <- renderPlotly({
    pairs_div <- div_cor_plot()[[1]]
    choices_div_tax <- div_cor_plot()[[2]]
    div_pairs <- plot_ly(data = pairs_div, x = ~ .data[[choices_div_tax[1]]], y = ~ .data[[choices_div_tax[2]]], type = "scatter",
                         text = rownames(pairs_div), mode = "markers", size = 14)
    div_pairs <- add_lines(div_pairs, y = ~fitted(loess(.data[[choices_div_tax[2]]] ~ .data[[choices_div_tax[1]]])), name = "Loess Smoother",
                            size = 0.5, showlegend = TRUE, alpha = 0.5)
    div_pairs <- div_pairs %>% layout(xaxis = list(title = choices_div_tax[1]), yaxis = list(title = choices_div_tax[2]),
                                       legend = list(orientation = "h"))
    div_pairs
  })

 
output$console <- renderPrint({
  pairs_div <- div_cor_plot()[[1]]
  choices_div_tax <- div_cor_plot()[[2]]
  div_formula <- as.formula(paste("~" , choices_div_tax[1], "+", choices_div_tax[2]))
  cor.test(div_formula, data = pairs_div, method = input$corr_div)
  })

# output$div_taxlev_pca<- renderUI({
#   checkboxGroupInput(inputId = "div_pca_id",
#                     label = HTML("Select the taxonomic levels for the PCA. <br>
#                                   Remember PCA can be run with a minimum of three sampling points."),
#                     choices = tax_lev_list(), inline = TRUE, selected = "Taxa")
#   })

#-------------------------------------------------------------------------------
# PCA
# all_tax_div <- reactive({
#   validate(need(!is.null(tax_lev_list()), ""))
#   all.ind.taxl <- lapply(as.list(tax_lev_list()) , FUN = function(x) data.frame(Site = colnames(asb_obj()[[x]])[-1], Tax_lev = rep(x, ncol(asb_obj()[[ x ]]) - 1), allindices(asb_obj(), x)))
#   names(all.ind.taxl) <- tax_lev_list()
#   all.ind.taxl <- all.ind.taxl[names(all.ind.taxl) %in% input$div_pca_id]
#   all.ind.taxl
#   })
# 
# 
# output$div_pca <- renderPlotly({
#   validate(need(length(input$div_pca_id) > 0 , "Waiting for user choice"))
#   div.pca.var <- do.call(cbind, all_tax_div())
#   div.pca <- dudi.pca(div.pca.var[ ,-c( grep("Site|Tax_lev", colnames(div.pca.var)))], scale = TRUE, center = TRUE, nf = 2, scannf = FALSE)
#   div.eigen <- round(div.pca$eig / sum(div.pca$eig), 3) * 100
#   div.pca <- div.pca$c1
#   div.pca.text <- colnames(div.pca.var[ , -c( grep("Site|Tax_lev", colnames(div.pca.var)))])
#   div.pca.text <- gsub( "\\." , "_" , div.pca.text)
#   div.pca.text.col <- sub( "_.*", "", div.pca.text)
# 
#   p <- plot_ly(div.pca, x = ~ CS1, y = ~ CS2, text = div.pca.text,
#                 mode = "markers", color = ~div.pca.text.col, marker = list(size = 10), type = "scatter", colors = "Set1")
#   p <- layout(p, title="PCA of Indices",
#               xaxis=list(title= paste("PC1 (", div.eigen[1], " %)", sep = "")),
#               yaxis=list(title=paste("PC2 (", div.eigen[2], " %)", sep = "")))
#   p
# } )

# Custom Reference Dataset -----------------------------------------------------
readInputCRD <- reactive({
  
  # Dataset with taxa and sampling site    
  inFileCRD <- input$fileCRD
  if (is.null(inFileCRD))
    return(NULL)
  if(input$filetypeCRD == "xlsx"){
    Tree <- data.frame(read_excel(inFileCRD$datapath, sheet = 1))
  }
  if(input$filetypeCRD == "csv"){
    Tree <- read.csv(inFileCRD$datapath, header = TRUE, sep = ",")
  }
  if(input$filetypeCRD == "txt"){
    Tree <- read.table(inFileCRD$datapath, header = TRUE)
  }
  
  if(input$communitytypeCRD != "none"){
    CRD <- ref_from_tree(Tree, group = input$communitytypeCRD)

  } else {
    CRD <- ref_from_tree(Tree, group = "none")
  }
  
  list(CRD = CRD)
  
})


output[["boxCRD"]] <- renderUI({
  if(is.null(input$fileCRD)){
    showNotification("Data do not upload", duration = 5, type = "warning", closeButton = TRUE)
  }
  if(!is.null(input$fileCRD)){
  box(width = NULL, solidHeader = FALSE,
      datatable(readInputCRD()$CRD, rownames = FALSE, options = list(lengthChange = FALSE, scrollX = FALSE))
  )
  }
  
})

# set the download button for downloading the table output$tbl_div
output$download_CRD <- downloadHandler(
  filename = function() {
    paste("custom_reference_database",  Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    write.csv(readInputCRD()$CRD, file, row.names = FALSE)
  }
)

   }