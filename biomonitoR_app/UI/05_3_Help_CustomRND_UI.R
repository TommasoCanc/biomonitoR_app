fluidRow(
  div(style="display: inline-block;vertical-align:top; margin-left:30px",
      column(width = 4 ,
  HTML(" 

<h1>Custom RND</h1> 

<br>
       
<h3>The panel <b>Custom RND</b> allows you to create your personal Reference 
Nomenclature Dataset.</h3>

<br>
<br>

To create your Custom RND, you need to upload a dataset containing your taxonomy <b>[1]</b>.

<br>
<br>

Once your dataset is loaded, you can follow two ways to create your Custom RND <b>[2]</b>:

<br>
<br>

<li>Do not select a reference community (<i><b>'None'</b></i>). Whit this strategy, your final dataset 
will contain only the nomenclature of your taxa, structured on <b>biomonitoR App</b> format.</li>

<br>

<li>Select a reference community (<i><b>'Macroinvertebrate'</b></i>, <i><b>'Macrophyte'</b></i>, <i><b>'Fish'</b></i>). 
Whit this strategy will be added to your data the entire reference community 
dataset contained in the <b>biomonitoR App</b>.</li>

<br>
<br>

Finally, your final Custom RND can be downloaded and used as a Custom dataset in the <b>biomonitoR App</b>.
 ")
), 

column(width = 8,
       img(src = "./Help_img/05_Create_Custom_RND.png", vspace="5px")
       )
)
)
