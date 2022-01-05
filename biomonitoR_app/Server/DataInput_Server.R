readInput <- reactive({
  
  # Dataset with taxa and sampling site
  # tools::file_ext(inFile$datapath) <- automatically identify the format
  inFile <- input$file1
  if (is.null(inFile))
    return(NULL)
  if(tools::file_ext(inFile$datapath) == "xlsx"){
    DF_init <- data.frame(read_excel(inFile$datapath, sheet = 1))
  }
  if(tools::file_ext(inFile$datapath) == "csv"){
    DF_init <- read.csv(inFile$datapath, header = TRUE, sep = ",")
  }
  if(tools::file_ext(inFile$datapath) == "txt"){
    DF_init <- read.table(inFile$datapath, header = TRUE)
  }
  
  if(input$communitytype == "cu"){
    inFile2 <- input$file2
    if (is.null(inFile2))
      return(NULL)
    if(tools::file_ext(inFile$datapath) == "xlsx"){
      DF_cust <- data.frame(read_excel(inFile2$datapath, sheet = 1))
    }
    if(tools::file_ext(inFile$datapath) == "csv"){
      DF_cust <- read.csv(inFile2$datapath, header = TRUE, sep = ",")
    }
    if(tools::file_ext(inFile$datapath) == "txt"){
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
  
  if(input$toBin != 1){ # Convert to binary format
    if(input$communitytype != "cu"){
      list(DF = DF , bioImp = bioImp , bioImp_w = bioImp_w)
    } else{
      list(DF = DF , bioImp = bioImp , bioImp_w = bioImp_w, DF_cust = DF_cust)
    }
  } else {
    if(input$communitytype != "cu"){
      list(DF = to_bin(DF) , bioImp = bioImp , bioImp_w = bioImp_w)
    } else{
      list(DF = to_bin(DF) , bioImp = bioImp , bioImp_w = bioImp_w, DF_cust = DF_cust)
    }
  }
  
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

# Convert to vegan -------------------------------------------------------------
vegan.rec <- reactive({
  if(input$veganFormat == 1){
    vegan.format <- convert_to_vegan(asb_obj(), tax_lev = input$taxLeVegan) # Convert to vegan format
  }
})

output[["tblVegan"]] <- renderUI({
  if(input$veganFormat == 1){
    box(width = NULL, solidHeader = FALSE,
        datatable(vegan.rec(), rownames = TRUE, options = list(lengthChange = TRUE, scrollX = TRUE)),
        uiOutput("downloadVegan")
    )
  }
})

# Download button vegan
output$downloadVegan <- renderUI({
  req(vegan.rec())
  downloadButton("downloadVegan.1", "Download Table")
})

output$downloadVegan.1 <- downloadHandler(
  filename = function() {
    paste("vegan_format_", Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    write.csv(vegan.rec(), file, row.names = FALSE)
  }
)

# Remove Taxa ------------------------------------------------------------------
observeEvent(readInput()$DF, {
  updateSelectizeInput(session, "removeTaxa", choices = readInput()$DF$Taxa)
})

rmTaxa.rec <- reactive({
  if(!is.null(input$removeTaxa)){
    rmTaxa <- remove_taxa(asb_obj(), taxa = c(input$removeTaxa)) # Convert to vegan format
}
    })

output[["tblRmTaxa"]] <- renderUI({
  if(!is.null(input$removeTaxa)){
    box(width = NULL, solidHeader = FALSE,
        datatable(rmTaxa.rec(), rownames = TRUE, options = list(lengthChange = TRUE, scrollX = TRUE)),
        uiOutput("downloadrmTaxa")
    )
  }
})

# Download button vegan
output$downloadrmTaxa <- renderUI({
  req(rmTaxa.rec())
  downloadButton("downloadrmTaxa.1", "Download Table")
})

output$downloadrmTaxa.1 <- downloadHandler(
  filename = function() {
    paste("taxa_removed_", Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    write.csv(rmTaxa.rec(), file, row.names = FALSE)
  }
)
