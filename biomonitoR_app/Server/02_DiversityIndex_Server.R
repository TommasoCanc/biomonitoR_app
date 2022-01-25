# Richness ---------------------------------------------------------------------
rich_reactive <- reactive({
  if(input$richIndex == 1){
    richIndex <- as.data.frame(richness(x_reactive(),
                                        tax_lev = input$richness.tax_lev))
    colnames(richIndex) <- "Richness"
    richIndex
  }
})

output$tbl_richness <- renderDT({ # table with richness index
  datatable(rich_reactive(), rownames = TRUE,
            options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                           scrollX = TRUE, lengthChange = FALSE))
})


output$download_richness <- renderUI({
  req(rich_reactive())
  downloadButton("download_rich.1", "Download Table")
})

output$download_rich.1 <- downloadHandler( # set the download button for downloading BMWP index table
  filename = function() {
    paste("Richness_",  Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    write.csv(rich_reactive(), file, row.names = TRUE)
  }
)


# Diversity indices ------------------------------------------------------------

observe({ # Update SelectInput with the results of tax_lev_list()
  updateSelectInput(session, "div.tax_lev", choices = tax_lev_list())
})

# create a reactive list containing diversity indices calculated at different taxonomic levels
div_ind_reactive <- reactive({
  validate(need(!is.null(input$div.tax_lev), ""))
  res_div <- lapply(as.list(tax_lev_list()), function(x) apply(allindices(x_reactive(), x), 2, function(x) round(x, 2)))
  names(res_div) <- tax_lev_list()
  res_div
})

output$tbl_div <- renderDT({ # table with diversity indices
  datatable(div_ind_reactive()[[input$div.tax_lev]], rownames = TRUE,
            options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                           scrollX = TRUE, lengthChange = FALSE))
})

output$download_div <- downloadHandler( # set the download button for downloading the table diversity index table
  filename = function() {
    paste("diversity_indices_", input$div.tax_lev, "_",  Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    write.csv(div_ind_reactive()[[input$div.tax_lev]], file, row.names = FALSE)
  }
)

# PCA ----
observe({ # Create a RadioButtons with the results of tax_lev_list()
  updateSelectInput(session, "div.taxPCA", choices = tax_lev_list())
})

all_tax_div <- reactive({
  validate(need(!is.null(tax_lev_list()), ""))
  all.ind.taxl <- lapply(as.list(input$div.taxPCA) , FUN = function(x) data.frame(Site = colnames(x_reactive()[[x]])[-1], Tax_lev = rep(x, ncol(x_reactive()[[ x ]]) - 1), allindices(x_reactive(), x)))
  names(all.ind.taxl) <- input$div.taxPCA
  all.ind.taxl <- all.ind.taxl[names(all.ind.taxl) %in% input$div.taxPCA]
  all.ind.taxl
})

output$div_pca <- renderPlotly({
  validate(need(length(input$div.taxPCA) > 0 , "Waiting for the taxonomic level selection"))
  div.pca.var <- do.call(cbind, all_tax_div())
  div.pca <- dudi.pca(div.pca.var[ ,-c(grep("Site|Tax_lev", colnames(div.pca.var)))], scale = TRUE, center = TRUE, nf = 2, scannf = FALSE)
  div.eigen <- round(div.pca$eig / sum(div.pca$eig), 3) * 100
  div.pca <- div.pca$c1
  div.pca.text <- colnames(div.pca.var[ , -c(grep("Site|Tax_lev", colnames(div.pca.var)))])
  div.pca.text <- gsub( "\\." , "_" , div.pca.text)
  div.pca.text.col <- sub( "_.*", "", div.pca.text)
  
  p <- plot_ly(div.pca, x = ~ CS1, y = ~ CS2, text = div.pca.text,
               mode = "markers", color = ~div.pca.text.col, marker = list(size = 10), type = "scatter", colors = "Set1")
  p <- layout(p, xaxis=list(title= paste("PC1 (", div.eigen[1], " %)", sep = "")),
              yaxis=list(title=paste("PC2 (", div.eigen[2], " %)", sep = "")))
  p
} )

# Scatter plot ----
observeEvent(div_ind_reactive(), {
  updateSelectizeInput(session, "var_div_pairs", choices = names(as.data.frame(div_ind_reactive()[["Taxa"]])))
})

observe({ # Create a RadioButtons with the results of tax_lev_list()
  updateSelectizeInput(session, "div_taxlev_pair", choices = tax_lev_list())
})

div_cor_plot <- reactive({
  choices_div_tax <- input$div_taxlev_pair
  validate(need(!is.null(input$div_taxlev_pair), ""))
  validate(need(length(input$div_taxlev_pair) == 2, ""))
  
  temp <- div_ind_reactive()[names(div_ind_reactive()) %in% choices_div_tax]
  pairs_div <- as.data.frame(do.call(cbind, lapply(temp, function(x) x[ ,input$var_div_pairs, drop = FALSE])))
  names(pairs_div) <- choices_div_tax
  rownames(pairs_div) <- rownames(div_ind_reactive()[["Taxa"]])
  list(pairs_div, choices_div_tax)
})

output$ggpairs_div <- renderPlotly({
  validate(need(length(input$div_taxlev_pair) == 2, "Please select two taxonomic levels"))
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
