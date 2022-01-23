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
        datatable(DF_def(), rownames = FALSE, options = list(lengthChange = FALSE, scrollX = TRUE)),
        uiOutput("downloadNomenclature")
    )}
})

# Download button
output$downloadNomenclature <- renderUI({
  req(DF_def())
  downloadButton("downloadNomenclature.1", "Download Table")
})

output$downloadNomenclature.1 <- downloadHandler(
  filename = function() {
    paste("taxa_corrected_nomenclature_", Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    write.csv(DF_def(), file, row.names = FALSE)
  }
)