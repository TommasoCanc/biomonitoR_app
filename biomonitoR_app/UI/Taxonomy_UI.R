fluidRow(
  column(width = 4 ,
         box(width = NULL, solidHeader = TRUE,
             HTML("<h3>
  <b>Taxonomy check</b>
</h3> This panel can help you to checking the nomenclature of your taxa. <br> 
Taxa names are checked against the community type reference datasets or your custom 
dataset if loaded. <br> If there are potentially erroneus names, you can find possible 
suggestions into the in the space provided below. <br>
<br> Non-identfied taxa will be discarded.")),
uiOutput("correctNames"), # Open the box with correct names suggestions
  ),

column(width = 8,
       uiOutput("tblTaxonomy")
       #uiOutput("tblVegan")
)

)