# Functional dispersion --------------------------------------------------------
f_disp_reactive <- reactive({
  req(x_reactive())
  req(avgTraits_reactive())
  if(input$funDisp == 1){
    f_disp.df <- f_disp(x_reactive(),
                       trait_db = avgTraits_reactive(),
                       tax_lev = input$f_disp.tax_lev,
                       type = input$f_disp.type,
                       traitSel = input$f_disp.traitSel,
                       col_blocks = as.numeric(unlist(strsplit(input$colBlockFuzzy,","))),
                       nbdim = input$f_disp.nbdim,
                       distance = input$f_disp.distance,
                       zerodist_rm = input$f_disp.zerodist_rm,
                       correction = input$f_disp.correction,
                       traceB = input$f_disp.traceB,
                       set_param = list(max_nbdim = input$f_disp.max_nbdim,
                                        prec = input$f_disp.prec,
                                        tol = input$f_disp.tol,
                                        cor.zero = input$f_disp.cor.zero)
                       )
  }
  
  f_disp.df <- round(as.data.frame(t(f_disp.df)), digits = 3)
  
  })


output$tbl_f_disp <- renderDT({ # table with functional dispersion index
  req(f_disp_reactive())  
  datatable(f_disp_reactive(), rownames = TRUE,
            options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                           scrollX = TRUE, lengthChange = FALSE))
})

output$download_f_disp <- downloadHandler( # set the download CSV button for downloading the table diversity index table
  filename = function() {
    paste("functional_dispersion_", input$f_disp.tax_lev, "_",  Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    write.csv(f_disp_reactive(), file, row.names = FALSE)
  }
)

# Functional diversity ---------------------------------------------------------
f_divs_reactive <- reactive({
  req(x_reactive())
  req(avgTraits_reactive())
  if(input$funDisp == 1){
    f_divs.df <- f_divs(x = x_reactive(),
                        trait_db = avgTraits_reactive(),
                        tax_lev = input$f_divs.tax_lev,
                        type = input$f_divs.type,
                        traitSel = input$f_divs.traitSel,
                        col_blocks = as.numeric(unlist(strsplit(input$colBlockFuzzy,","))),
                        distance = input$f_divs.distance,
                        zerodist_rm = input$f_divs.zerodist_rm,
                        correction = input$f_divs.correction,
                        traceB = input$f_divs.traceB,
                        set_param = list(max_nbdim = input$f_divs.max_nbdim,
                                         prec = input$f_divs.prec,
                                         tol = input$f_divs.tol,
                                         cor.zero = input$f_divs.cor.zero)
    )
  }
  
  f_divs.df <- round(as.data.frame(t(f_divs.df)), digits = 3)
  
})

output$tbl_f_divs <- renderDT({ # table with functional dispersion index
  req(f_divs_reactive())  
  datatable(f_divs_reactive(), rownames = TRUE,
            options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                           scrollX = TRUE, lengthChange = FALSE))
})

output$download_f_divs <- downloadHandler( # set the download button for downloading the table diversity index table
  filename = function() {
    paste("functional_diversity_", input$f_divs.tax_lev, "_",  Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    write.csv(f_divs_reactive(), file, row.names = FALSE)
  }
)

# Functional evenness ----------------------------------------------------------
f_eve_reactive <- reactive({
  req(x_reactive())
  req(avgTraits_reactive())
  if(input$funEve == 1){
    f_eve.df <- f_eve(x = x_reactive(),
                      trait_db = avgTraits_reactive(),
                      tax_lev = input$f_eve.tax_lev,
                      type = input$f_eve.type,
                      traitSel = input$f_eve.traitSel,
                      col_blocks = as.numeric(unlist(strsplit(input$colBlockFuzzy,","))),
                      nbdim = input$f_eve.nbdim,
                      distance = input$f_eve.distance,
                      zerodist_rm = input$f_eve.zerodist_rm,
                      correction = input$f_eve.correction,
                      traceB = input$f_eve.traceB,
                      set_param = list(max_nbdim = input$f_eve.max_nbdim,
                                       prec = input$f_eve.prec,
                                       tol = input$f_eve.tol,
                                       cor.zero = input$f_eve.cor.zero)
    )
  }
  
  f_eve.df <- round(as.data.frame(t(f_eve.df)), digits = 3)
  
})

output$tbl_f_eve <- renderDT({ # table with functional dispersion index
  req(f_eve_reactive())  
  datatable(f_eve_reactive(), rownames = TRUE,
            options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                           scrollX = TRUE, lengthChange = FALSE))
})

output$download_f_eve <- downloadHandler( # set the download button for downloading the table diversity index table
  filename = function() {
    paste("functional_evenness_", input$f_eve.tax_lev, "_",  Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    write.csv(f_eve_reactive(), file, row.names = FALSE)
  }
)

# Functional redundancy --------------------------------------------------------
f_red_reactive <- reactive({
  req(x_reactive())
  req(avgTraits_reactive())
  if(input$funRed == 1){
    f_red.df <- f_red(x = x_reactive(),
                      trait_db = avgTraits_reactive(),
                      tax_lev = input$f_red.tax_lev,
                      type = input$f_red.type,
                      traitSel = input$f_red.traitSel,
                      col_blocks = as.numeric(unlist(strsplit(input$colBlockFuzzy,","))),
                      distance = input$f_red.distance,
                      zerodist_rm = input$f_red.zerodist_rm,
                      correction = input$f_red.correction,
                      traceB = input$f_red.traceB,
                      set_param = list(max_nbdim = input$f_red.max_nbdim,
                                       prec = input$f_red.prec,
                                       tol = input$f_red.tol,
                                       cor.zero = input$f_red.cor.zero)
    )
  }
  
  f_red.df <- round(as.data.frame(t(f_red.df)), digits = 3)
  
})

output$tbl_f_red <- renderDT({ # table with functional dispersion index
  req(f_red_reactive())  
  datatable(f_red_reactive(), rownames = TRUE,
            options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                           scrollX = TRUE, lengthChange = FALSE))
})

output$download_f_red <- downloadHandler( # set the download button for downloading the table diversity index table
  filename = function() {
    paste("functional_redundancy_", input$f_red.tax_lev, "_",  Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    write.csv(f_red_reactive(), file, row.names = FALSE)
  }
)

# Functional richness ----------------------------------------------------------
f_rich_reactive <- reactive({
  req(x_reactive())
  req(avgTraits_reactive())
  if(input$funRich == 1){
    f_rich.df <- f_rich(x = x_reactive(),
                       trait_db = avgTraits_reactive(),
                       tax_lev = input$f_rich.tax_lev,
                       type = input$f_rich.type,
                       traitSel = input$f_rich.traitSel,
                       col_blocks = as.numeric(unlist(strsplit(input$colBlockFuzzy,","))),
                       nbdim = input$f_rich.nbdim,
                       distance = input$f_rich.distance,
                       zerodist_rm = input$f_rich.zerodist_rm,
                       correction = input$f_rich.correction,
                       traceB = input$f_rich.traceB,
                       set_param = list(max_nbdim = input$f_rich.max_nbdim,
                                        prec = input$f_rich.prec,
                                        tol = input$f_rich.tol,
                                        cor.zero = input$f_rich.cor.zero)
    )
  }
  
  f_rich.df <- round(as.data.frame(t(f_rich.df)), digits = 3)
  
})

output$tbl_f_rich <- renderDT({ # table with functional dispersion index
  req(f_rich_reactive())  
  datatable(f_rich_reactive(), rownames = TRUE,
            options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                           scrollX = TRUE, lengthChange = FALSE))
})

output$download_f_rich <- downloadHandler( # set the download button for downloading the table diversity index table
  filename = function() {
    paste("functional_richness_", input$f_rich.tax_lev, "_",  Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    write.csv(f_rich_reactive(), file, row.names = FALSE)
  }
)
