fluidRow(
  div(style="display: inline-block;vertical-align:top; margin-left:30px",
      column(width = 4 ,
  HTML(" 

<h1>Taxonomy check</h1> 

<br>
       
<h3>The panel <b>Taxonomy check</b> allows you to check and standardize the nomenclature 
of your input dataset and remove taxa that you want to exclude from your analysis.</h3>

<br>
<br>

Among the main differences distinguishing the <b>biomonitoR App</b> to other bio-ecological R packages, 
there is the use of <i><b>Reference Nomenclature Datasets (RND)</b></i> useful to improve and 
standardize the quality of your input data. 

<br>
<br>

<b>biomonitoR App</b> lets you use three RND (Macroinvertebrate, Macrophyte, and Fish) 
or load your custom reference nomenclature dataset.
The three RND are built starting from the information contained in 
<a href='https://www.freshwaterecology.info' target='_blank'> freshwatercology.info </a>,
<a href='https://www.algaebase.org' target='_blank'> algaebase </a>,
<a href='https://www.fishbase.in/search.php' target='_blank'> fishbase </a>.

<br>
<br>

If your nomenclature does not match those included in the <b>biomonitor App</b> RND, 
a specific box containing the wrong/unfindable taxa names will be open. 
In such box, you can find the name of your taxa name not detected by the <b>biomonitoR App</b> 
and some possible suggestions to resolve the nomenclature.

<br>

RND are avaiable clicking on XXX, YYY, ZZZ

<br>
<br>

If you want to use your custom RND, you need to load your dataset in the panel 
<i><b>'Input Data'</b></i> selecting <i><b>'Custom'</b></i> in the reference 
community drop-down menu.

<br>
<br>

To remove taxa from your analysis, you can select the taxa names provided by 
the drop-down menu contained in the box <i><b>'Remove taxa'</b></i>.

       
       ")
), 

column(width = 8,
       img(src = "./Help_img/03_wrong_names_remove_taxa.png", vspace="5px")
       )
)
)
