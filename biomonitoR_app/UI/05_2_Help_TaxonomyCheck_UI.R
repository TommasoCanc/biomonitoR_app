fluidRow(
  div(style = "display: inline-block;vertical-align:top; margin-left:30px",
      column(
        width = 4 ,
        HTML(
          "

<h1>Taxonomy check</h1>

<br>

<h3>The panel Taxonomy check allows to check and standardize the nomenclature of the input dataset and remove taxa that users wish/need to exclude from the analysis.</h3>

<br>
<br>

Among the main differences distinguishing <b>biomonitoR App</b> to other R packages, is the possibility to use community-type reference datasets useful to improve and standardize the quality of input data.

<br>
<br>

<b>biomonitoR App</b> allows the use of three community-type reference datasets (Macroinvertebrates, Macrophytes, and Fish) or custom reference nomenclature datasets. The three community-type reference datasets were built upon information provided in
<a href='https://www.freshwaterecology.info' target='_blank'> freshwatercology.info </a>,
<a href='https://www.algaebase.org' target='_blank'> algaebase </a>,
<a href='https://www.fishbase.in/search.php' target='_blank'> fishbase </a>.

<br>
<br>

If taxa nomenclature does not match those included in the <b>biomonitor App</b> community-type reference datasets, a box containing the wrong/undetected names will open. There, the names of the undetected taxa appear as well as some possible suggestions to help the users.

<br>
<br>

If users prefer to use a custom community-type reference dataset they can do so by loading it, using the panel <i><b>'Input Data'</b></i> and selecting 'Custom' in the reference community drop-down menu.

<br>
<br>

To remove taxa, users can use the bottom <b>'Remove taxa'</b> from the drop-down menu.
"
        )
      ),

column(
  width = 8,
  img(src = "./Help_img/03_wrong_names_remove_taxa.png", vspace = "5px")
))
)
