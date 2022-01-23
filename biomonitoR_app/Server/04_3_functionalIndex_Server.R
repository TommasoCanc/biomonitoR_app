# Functional dispersion --------------------------------------------------------
f_disp_reactive <- reactive({
  req(asb_obj())
  req(avgTraits_reactive())
  if(input$funDisp == 1){
    f_disp.df <- f_disp(asb_obj(),
                       trait_db = avgTraits_reactive(),
                       tax_lev = input$funDispLev,
                       type = input$funDispType,
                       traitSel = input$traitSelDisp,
                       col_blocks = as.numeric(unlist(strsplit(input$colBlockFuzzy,","))),
                       nbdim = input$nbdimDisp,
                       distance = input$distanceDisp,
                       zerodist_rm = input$zerodist_rmDisp,
                       correction = input$correctionDisp,
                       traceB = input$traceBDisp,
                       set_param = list(max_nbdim = input$max_nbdimDisp,
                                        prec = input$precDisp,
                                        tol = input$tolDisp,
                                        cor.zero = input$corZeroDisp)
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

output$download_f_disp <- downloadHandler( # set the download button for downloading the table diversity index table
  filename = function() {
    paste("functional_dispersion_", input$funDispLev, "_",  Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    write.csv(f_disp_reactive(), file, row.names = FALSE)
  }
)

# Functional evenness ----------------------------------------------------------

f_eve_reactive <- reactive({
  req(asb_obj())
  req(avgTraits_reactive())
  if(input$funEve == 1){
    f_eve.df <- f_disp(asb_obj(),
                       trait_db = avgTraits_reactive(),
                       tax_lev = input$funEveLev,
                       type = input$funEveType,
                       traitSel = input$traitSelEve,
                       col_blocks = as.numeric(unlist(strsplit(input$colBlockFuzzy,","))),
                       nbdim = input$nbdimDisp,
                       distance = input$distanceEve,
                       zerodist_rm = input$zerodist_rmEve,
                       correction = input$correctionEve,
                       traceB = input$traceBEve,
                       set_param = list(max_nbdim = input$max_nbdimEve,
                                        prec = input$precEve,
                                        tol = input$tolEve,
                                        cor.zero = input$corZeroEve)
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
    paste("functional_evenness_", input$funEveLev, "_",  Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    write.csv(f_eve_reactive(), file, row.names = FALSE)
  }
)

# Functional redundancy --------------------------------------------------------

# Functional richness ----------------------------------------------------------