# BIOCO ----
observeEvent(DF_def(), {
  req(DF_def())
  updateSelectizeInput(session, "biocoAlien", choices = DF_def()$Taxa)
})

bioco_reactive <- reactive({
  if(input$biocoIndex == 1 & !is.null(input$biocoAlien)){

    if(input$biocoRefdf != "cu"){
    biocoIndex <- bioco(asb_obj(),
                        alien = input$biocoAlien, 
                        dfref = input$biocoRefdf, 
                        digits = 2)
    } else {
      biocoIndex <- bioco(asb_obj(),
                          alien = input$biocoAlien, 
                          dfref = readInput()$DF_cust, 
                          digits = 2)
    }
  
    biocoIndex
    
  } 
  })

output$tbl_bioco <- renderDT({ # table with bioco index
  req(bioco_reactive())  
  datatable(bioco_reactive(), rownames = TRUE,
              options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                             scrollX = TRUE, lengthChange = FALSE))
  
})

output$download_bioco <- renderUI({
  req(bioco_reactive())
  downloadButton("download_bioco.1", "Download Table")
})

output$download_bioco.1 <- downloadHandler( # set the download button for downloading BMWP index table
  filename = function() {
    paste("BIOCO_",  Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    write.csv(bioco_reactive(), file, row.names = TRUE)
  }
)

# BMWP ----
observeEvent(DF_def(), {
  req(DF_def())
  updateSelectizeInput(session, "bmwpExceptions", choices = DF_def()$Taxa)
})

bwmp_reactive <- reactive({
  if(input$bmwpIndex == 1){
    bwmpIndex <- as.data.frame(bmwp(asb_obj(),
                                    method = input$bmwp_method,
                                    agg = input$bmwpAgg,
                                    exceptions = input$bmwpExceptions,
                                    traceB = FALSE))
    colnames(bwmpIndex) <- "BMWP"
    bwmpIndex
  }
})

output$tbl_bmwp <- renderDT({ # table with bmwp index
  datatable(bwmp_reactive(), rownames = TRUE,
            options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                           scrollX = TRUE, lengthChange = FALSE))
})

output$tbl_bmwpScore <- renderDT({ # table with bmwp score
  if(input$bmwpScore == 1){
  datatable(show_scores(index = "bmwp", method = input$bmwp_methodScore)$scores, rownames = TRUE,
            options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                           scrollX = TRUE, lengthChange = FALSE))
  }
})

output$download_bmwp <- renderUI({
  req(bwmp_reactive())
  downloadButton("download_bmwp.1", "Download Table")
})

output$download_bmwp.1 <- downloadHandler( # set the download button for downloading BMWP index table
  filename = function() {
    paste("BMWP_",  Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    write.csv(bwmp_reactive(), file, row.names = TRUE)
  }
)

# ASPT ----
observeEvent(readInput()$DF, {
  updateSelectizeInput(session, "asptExceptions", choices = readInput()$DF$Taxa)
})

aspt_reactive <- reactive({
  if(input$asptIndex == 1){
    asptIndex <- as.data.frame(aspt(asb_obj(),
                                    method = input$aspt_method,
                                    agg = input$asptAgg,
                                    exceptions = input$asptExceptions,
                                    traceB = FALSE))
    asptIndex <- round(asptIndex, digits = 3)
    colnames(asptIndex) <- "ASPT"
    asptIndex
  }
  
})

output$tbl_aspt <- renderDT({ # table with aspt index
  datatable(aspt_reactive(), rownames = TRUE,
            options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                           scrollX = TRUE, lengthChange = FALSE))
})

output$tbl_asptScore <- renderDT({ # table with aspt score
  if(input$asptScore == 1){
    datatable(show_scores(index = "aspt", method = input$aspt_methodScore)$scores, rownames = TRUE,
              options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                             scrollX = TRUE, lengthChange = FALSE))
  }
})

output$download_aspt <- renderUI({
  req(aspt_reactive())
  downloadButton("download_aspt.1", "Download Table")
})

output$download_aspt.1 <- downloadHandler( # set the download button for downloading ASPT index table
  filename = function() {
    paste("ASPT_",  Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    write.csv(aspt_reactive(), file, row.names = TRUE)
  }
)

# PSI ----

observeEvent(readInput()$DF, {
  updateSelectizeInput(session, "psiExceptions", choices = readInput()$DF$Taxa)
})

psi_reactive <- reactive({
  if(input$psiIndex == 1){
    psiIndex <- as.data.frame(psi(asb_obj(),
                                  method = "extence",
                                  abucl = c(1, 9, 99, 999),
                                  agg = input$psiAgg,
                                  fssr_scores = NULL,
                                  exceptions = input$psiExceptions,
                                  traceB = FALSE))
    psiIndex <- round(psiIndex, digits = 3)
    colnames(psiIndex) <- "PSI"
    psiIndex
  }
  
})

output$tbl_psi <- renderDT({ # table with aspt index
  datatable(psi_reactive(), rownames = TRUE,
            options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                           scrollX = TRUE, lengthChange = FALSE))
})

output$tbl_psiScore <- renderDT({ # table with psi score
  if(input$psiScore == 1){
    datatable(show_scores(index = "psi", method = "extence")$scores, rownames = TRUE,
              options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                             scrollX = TRUE, lengthChange = FALSE))
  }
})

output$download_psi <- renderUI({
  req(psi_reactive())
  downloadButton("download_psi.1", "Download Table")
})

output$download_psi.1 <- downloadHandler( # set the download button for downloading ASPT index table
  filename = function() {
    paste("PSI_",  Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    write.csv(psi_reactive(), file, row.names = TRUE)
  }
)

# EPSI ----

observeEvent(readInput()$DF, {
  updateSelectizeInput(session, "epsiExceptions", choices = readInput()$DF$Taxa)
})

epsi_reactive <- reactive({
  if(input$epsiIndex == 1){
    epsiIndex <- as.data.frame(epsi(asb_obj(),
                                    method = "uk",
                                    agg = input$epsiAgg,
                                    abucl = c(1, 9, 99, 999),
                                    exceptions = input$epsiExceptions,
                                    traceB = FALSE))
    epsiIndex <- round(epsiIndex, digits = 3)
    colnames(epsiIndex) <- "PSI"
    epsiIndex
  }
})

output$tbl_epsi <- renderDT({ # table with aspt index
  datatable(epsi_reactive(), rownames = TRUE,
            options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                           scrollX = TRUE, lengthChange = FALSE))
})

output$tbl_epsiScore <- renderDT({ # table with epsi score
  if(input$epsiScore == 1){
    datatable(show_scores(index = "epsi", method = "uk")$scores, rownames = TRUE,
              options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                             scrollX = TRUE, lengthChange = FALSE))
  }
})

output$download_epsi <- renderUI({
  req(epsi_reactive())
  downloadButton("download_epsi.1", "Download Table")
})

output$download_epsi.1 <- downloadHandler( # set the download button for downloading ASPT index table
  filename = function() {
    paste("EPSI_",  Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    write.csv(epsi_reactive(), file, row.names = TRUE)
  }
)

# EPT ----

ept_reactive <- reactive({
  if(input$eptIndex == 1){
    eptIndex <- as.data.frame(ept(asb_obj(),
                                  tax_lev = input$ept_taxLev))
    colnames(eptIndex) <- "EPT"
    eptIndex
  }
  
})

output$tbl_ept <- renderDT({ # table with aspt index
  datatable(ept_reactive(), rownames = TRUE,
            options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                           scrollX = TRUE, lengthChange = FALSE))
})

output$download_ept <- renderUI({
  req(ept_reactive())
  downloadButton("download_ept.1", "Download Table")
})

output$download_ept.1 <- downloadHandler( # set the download button for downloading ASPT index table
  filename = function() {
    paste("EPT_",  Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    write.csv(ept_reactive(), file, row.names = TRUE)
  }
)

# EPTD ----

eptd_reactive <- reactive({
  if(input$eptdIndex == 1){
    eptdIndex <- as.data.frame(eptd(asb_obj(),
                                    base = input$epdt_logBase,
                                    eptd_families = NULL,
                                    traceB = FALSE))
    colnames(eptdIndex) <- "EPTD"
    eptdIndex
  }
})

output$tbl_eptd <- renderDT({ # table with aspt index
  datatable(eptd_reactive(), rownames = TRUE,
            options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                           scrollX = TRUE, lengthChange = FALSE))
})

output$download_eptd <- renderUI({
  req(eptd_reactive())
  downloadButton("download_eptd.1", "Download Table")
})

output$download_eptd.1 <- downloadHandler( # set the download button for downloading ASPT index table
  filename = function() {
    paste("EPTD_",  Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    write.csv(eptd_reactive(), file, row.names = TRUE)
  }
)

# GOLD ----

gold_reactive <- reactive({
  if(input$goldIndex == 1){
    goldIndex <- as.data.frame(igold(asb_obj(),
                                     traceB = FALSE))
    goldIndex <- round(goldIndex, digits = 3)
    colnames(goldIndex) <- "GOLD"
    goldIndex
  }
  
})

output$tbl_gold <- renderDT({ # table with aspt index
  datatable(gold_reactive(), rownames = TRUE,
            options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                           scrollX = TRUE, lengthChange = FALSE))
})

output$download_gold <- renderUI({
  req(eptd_reactive())
  downloadButton("download_gold.1", "Download Table")
})

output$download_gold.1 <- downloadHandler( # set the download button for downloading ASPT index table
  filename = function() {
    paste("GOLD_",  Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    write.csv(gold_reactive(), file, row.names = TRUE)
  }
)

# LIFE ----

observeEvent(readInput()$DF, {
  updateSelectizeInput(session, "lifeExceptions", choices = readInput()$DF$Taxa)
})

life_reactive <- reactive({
  if(input$lifeIndex == 1){
    lifeIndex <- as.data.frame(life(asb_obj(), method = input$life_method,
                                    abucl = c(1, 9, 99, 999, 9999),
                                    agg = input$lifeAgg,
                                    fs_scores = NULL,
                                    exceptions = input$lifeExceptions,
                                    traceB = FALSE))
    lifeIndex <- round(lifeIndex, digits = 3)
    colnames(lifeIndex) <- "LIFE"
    lifeIndex
  }
  
})

output$tbl_life <- renderDT({ # table with aspt index
  datatable(life_reactive(), rownames = TRUE,
            options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                           scrollX = TRUE, lengthChange = FALSE))
})

output$tbl_lifeScore <- renderDT({ # table with epsi score
  if(input$lifeScore == 1){
    datatable(show_scores(index = "life", method = input$life_methodScore)$scores, rownames = TRUE,
              options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                             scrollX = TRUE, lengthChange = FALSE))
  }
})

output$download_life <- renderUI({
  req(life_reactive())
  downloadButton("download_life.1", "Download Table")
})

output$download_life.1 <- downloadHandler( # set the download button for downloading ASPT index table
  filename = function() {
    paste("LIFE_",  Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    write.csv(life_reactive(), file, row.names = TRUE)
  }
)

# WHPT ----

observeEvent(readInput()$DF, {
  updateSelectizeInput(session, "whptExceptions", choices = readInput()$DF$Taxa)
})

whpt_reactive <- reactive({
  if(input$whptIndex == 1){
    whptIndex <- as.data.frame(whpt(asb_obj(),
                                    method = "uk",
                                    type = input$whpt_type,
                                    metric = input$whpt_metric,
                                    agg = input$whptAgg,
                                    abucl = c(1, 9, 99, 999),
                                    exceptions = input$whptExceptions,
                                    traceB = FALSE))
    whptIndex <- round(whptIndex, digits = 3)
    colnames(whptIndex) <- "WHPT"
    whptIndex
  }
  
})

output$tbl_whpt <- renderDT({ # table with aspt index
  datatable(whpt_reactive(), rownames = TRUE,
            options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                           scrollX = TRUE, lengthChange = FALSE))
})

output$download_whpt <- renderUI({
  req(whpt_reactive())
  downloadButton("download_whpt.1", "Download Table")
})

output$download_whpt.1 <- downloadHandler( # set the download button for downloading ASPT index table
  filename = function() {
    paste("WHPT_",  Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    write.csv(whpt_reactive(), file, row.names = TRUE)
  }
)
