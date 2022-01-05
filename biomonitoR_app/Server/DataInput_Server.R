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
  
  if(input$toBin != 1){
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