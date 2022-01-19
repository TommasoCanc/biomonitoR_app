readInputCRD <- reactive({
  
  # Dataset to create custom reference dataset   
  if (is.null(input$fileCRD))
    return(NULL)
  if(tools::file_ext(input$fileCRD$datapath) == "xlsx"){
    tree <- data.frame(read_excel(input$fileCRD$datapath, sheet = 1))
  }
  if(tools::file_ext(input$fileCRD$datapath) == "csv"){
    tree <- read.csv(input$fileCRD$datapath, header = TRUE, sep = ",")
  }
  if(tools::file_ext(input$fileCRD$datapath) == "txt"){
    tree <- read.table(input$fileCRD$datapath, header = TRUE)
  }
  
  if(input$runCRD == 1){
  CRD <- ref_from_tree(tree, group = input$communitytypeCRD)
  } else {
    CRD <- NULL
  }
  
  list(tree = tree, CRD = CRD)
  
})


output[["tbl_boxInputTree"]] <- renderUI({
  if(is.null(input$fileCRD)){
    showNotification("Data do not upload", duration = 5, type = "warning", closeButton = TRUE)
  }
  if(!is.null(input$fileCRD)){
    box(width = NULL, solidHeader = FALSE,
        datatable(readInputCRD()$tree, rownames = FALSE, options = list(lengthChange = FALSE, scrollX = FALSE))
    )
  }
  
})


output[["tbl_boxCRD"]] <- renderUI({
  if(!is.null(readInputCRD()$CRD)){
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