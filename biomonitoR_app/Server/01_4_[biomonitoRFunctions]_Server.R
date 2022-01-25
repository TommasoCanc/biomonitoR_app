# create the biomonitoR object
# this will be used for all the calculations

asb_obj <- reactive({
  validate(need(DF_def(), ""))
  if(input$communitytype != "cu"){
    aggregate_taxa(as_biomonitor(DF_def(), group = input$communitytype, FUN = get(input$abutype))) # Convert to biomonitoR format
  } else {
    aggregate_taxa(as_biomonitor(DF_def(), dfref = readInput()$DF_cust, FUN = get(input$abutype))) # Convert to biomonitoR format
  }
  
  })

asb_obj.rm <- reactive({
  validate(need(DF_def(), ""))
  if(!is.null(input$removeTaxa)){
    if(input$communitytype != "cu"){
      aggregate_taxa(as_biomonitor(rmTaxa.rec(), group = input$communitytype, FUN = get(input$abutype))) # Convert to biomonitoR format
    } else {
      aggregate_taxa(as_biomonitor(rmTaxa.rec(), dfref = readInput()$DF_cust, FUN = get(input$abutype))) # Convert to biomonitoR format
    }
  }
})

# Create MAIN variable checking for removed taxa ----
x_reactive <- reactive({
  if(is.null(input$removeTaxa)){
    asb_obj()
  } else {
    asb_obj.rm()
  }
})


# calculate richness for family, genus, species and taxa. Useful to set the elements of radioButtons.
# Richness below 3 will not be taken into account

tax_lev_list <- reactive({
  validate(need(DF_def(), ""))
  temp.tot <- general_info(asb_obj()) # number of taxonomic ranks and abundance
  temp.tot <- temp.tot[names(temp.tot) %in% c("Family", "Genus", "Species", "Taxa")] # Subset only the four taxon rank
  names(temp.tot[temp.tot > 3])
})