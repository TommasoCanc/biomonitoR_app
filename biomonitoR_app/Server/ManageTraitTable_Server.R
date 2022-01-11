# Assign traits ----------------------------------------------------------------
assignTrait_reactive <- reactive({
  if(input$assignTrait == 1){
    
    if(input$assFilterDistance == "Null"){
      assTrait <- assign_traits(asb_obj(),
                                trait_db = NULL,
                                group = input$assTraitsGroup,
                                tax_lev = input$assTraitsLevel,
                                dfref = NULL,
                                filter_by_distance = NULL)
    } 
    
    if (input$assFilterDistance == "numeric") {
      assTrait <- assign_traits(asb_obj(),
                                trait_db = NULL,
                                group = input$assTraitsGroup,
                                tax_lev = input$assTraitsLevel,
                                dfref = NULL,
                                filter_by_distance = input$assFilterNumeric)
    }
    
    if (input$assFilterDistance != "Null" & input$assFilterDistance != "numeric") {
      assTrait <- assign_traits(asb_obj(),
                                trait_db = NULL,
                                group = input$assTraitsGroup,
                                tax_lev = input$assTraitsLevel,
                                dfref = NULL,
                                filter_by_distance = input$assFilterDistance)
    }
    
    assTrait <- data.frame(lapply(assTrait, function(y) if(is.numeric(y)) round(y, digits = 3) else y)) 
  }
})

output$tbl_assignTrait <- renderDT({ # table with assign traits results
  datatable(assignTrait_reactive(), rownames = TRUE,
            options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                           scrollX = TRUE, lengthChange = FALSE))
})


# Manage traits ----------------------------------------------------------------

# Select traits ----
observeEvent(assignTrait_reactive(), { # Select trait columns
  req(assignTrait_reactive())
  updateSelectizeInput(session, "traitColumns", choices = colnames(assignTrait_reactive())[6:ncol(assignTrait_reactive())])
})

selColumn_reactive <- reactive({
  
  if(!is.null(input$traitColumns)){
  selColumn <- assignTrait_reactive()[ ,c("Taxa", "Taxa_db", "Traits_taxlev", 
                                          "Traits_real", "Taxonomic_distance",input$traitColumns)]
  } else {
    selColumn <- assignTrait_reactive()
  }
  
  })

output$tbl_selColumn <- renderDT({ # table with selected columns
  datatable(selColumn_reactive(), rownames = TRUE,
            options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                           scrollX = TRUE, lengthChange = FALSE))
})


# Nearest ----
nearTrait_reactive <- reactive({
  
  if(input$traitNear == 1){ # Problemi con neareast-+
    req(selColumn_reactive())
    nrTraits <- manage_traits(selColumn_reactive(), 
                              method = input$manTraitsNear, 
                              traceB = FALSE)
  }
  nrTraits
})

output$tbl_traitNear <- renderDT({ # table with manage traits results
  datatable(nearTrait_reactive(), rownames = TRUE,
            options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                           scrollX = TRUE, lengthChange = FALSE))
})


# Final trait table ----

avgTraits_reactive <- reactive({
  req(nearTrait_reactive())
  
  if(input$colBlockFuzzy != ""){
   # col_blocks <- input$input$colBlockFuzzy
    avrTraits <- average_traits(nearTrait_reactive(),
                                col_blocks = as.numeric(unlist(strsplit(input$colBlockFuzzy,","))) 
                                )
    avrTraits <- data.frame(lapply(avrTraits, function(y) if(is.numeric(y)) round(y, digits = 3) else y)) 
  }
})

sampleTraits_reactive <- reactive({
  req(nearTrait_reactive())
  sampleTraits <- sample_traits(nearTrait_reactive())
  sampleTraits <- data.frame(lapply(sampleTraits, function(y) if(is.numeric(y)) round(y, digits = 3) else y)) 
  
})


output$tbl_avgTraits <- renderDT({ # table with manage traits results
  req(avgTraits_reactive())
  datatable(avgTraits_reactive(), rownames = TRUE,
            options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                           scrollX = TRUE, lengthChange = FALSE))
})


output$tbl_sampleTraits <- renderDT({ # table with manage traits results
  req(sampleTraits_reactive())
  datatable(sampleTraits_reactive(), rownames = TRUE,
            options = list(columnDefs = list(list(className = "dt-center", targets = "all")),
                           scrollX = TRUE, lengthChange = FALSE))
})