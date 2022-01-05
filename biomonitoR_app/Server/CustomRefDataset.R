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