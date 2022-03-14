fluidRow(
  div(style="display: inline-block;vertical-align:top; margin-left:30px",
      column(width = 4 ,
  HTML(" 

<h1>Custom community-type reference dataset</h1> 

<br>
       
<h3>This panel allows users to create a Custom community-type reference dataset.</h3>

<br>
<br>

To create a personal community-type dataset, users need to upload a dataset containing their taxonomy <b>[1]</b>.

<br>
<br>

Once a dataset is loaded, there are two ways to create a community-type dataset <b>[2]</b>:

<br>

<ul>
<li>Without selecting a reference community (<i><b>'None'</b></i>). With this approach, the final dataset will contain only the nomenclature of the taxa loaded , structured according to the <b>biomonitoR App</b> format.</li>

<li>Selecting a community-type reference dataset (<i><b>'Macroinvertebrate'</b></i>, <i><b>'Macrophyte'</b></i>, <i><b>'Fish'</b></i>). With this approach the entire reference community dataset contained in the <b>biomonitoR App</b> will be added to the original uploaded data.</li>
 ")
), 

column(width = 8,
       img(src = "./Help_img/05_Create_Custom_RND.png", vspace="5px")
       )
)
)
