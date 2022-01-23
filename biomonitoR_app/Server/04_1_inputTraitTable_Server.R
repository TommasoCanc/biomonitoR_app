readInputTrait <- reactive({
  #input$fileTrait <- input$fileTrait
  if (is.null(input$fileTrait))
    return(NULL)
  if(tools::file_ext(input$fileTrait$datapath) == "xlsx"){
    traidDf <- data.frame(read_excel(input$fileTrait$datapath, sheet = 1))
  }
  if(tools::file_ext(input$fileTrait$datapath) == "csv"){
    traidDf <- read.csv(input$fileTrait$datapath, header = TRUE, sep = ",")
  }
  if(tools::file_ext(input$fileTrait$datapath) == "txt"){
    traidDf <- read.table(input$fileTrait$datapath, header = TRUE)
  }
  
  if(any(colnames(traidDf) %in% "Taxa")){ # Check if into the dataset is present the Taxa column
    return(traidDf)
  } else {
    showNotification("No Taxa column is present in your dataset ", duration = 5, type = "error", closeButton = TRUE)
  }
  
})

output[["tbl_inTrait"]] <- renderUI({
  if(is.null(input$fileTrait)){
    showNotification("Data do not upload", duration = 5, type = "warning", closeButton = TRUE)
  }
  if(!is.null(input$fileTrait)){
    box(width = NULL, solidHeader = FALSE,
        datatable(readInputTrait(), rownames = FALSE, options = list(lengthChange = FALSE, scrollX = FALSE))
    )}
})