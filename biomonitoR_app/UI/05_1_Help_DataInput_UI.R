fluidRow(
  div(style="display: inline-block;vertical-align:top; margin-left:30px",
      column(width = 4 ,
  HTML(" 
       
<h1>Data Input</h1> 

<br>
       
<h3>The panel <b>Data Input</b> allows you to import your dataset and manage it efficiently.</h3>

<br>
<br>

The first step to working with the <b>biomonitoR App</b> is to load your dataset. 
To do that, you need to open the panel <i><b>'Load File - Community data'</b></i> and click on <i><b>'Browser'</b></i> <b>[1]</b>. 
Now you can choose your file, and once it has been loaded, it will be shown in the main panel. Shuch table is entirely editable.
<b>biomonitoR App</b> accepts three different file format for the upload .xlsx, .csv, or .txt. 

<br>
<br>

Once load your dataset, you need to select your reference community through the dedicated drop-down menu <b>[2]</b>. 
You can choose among four reference communities: Macroinvertebrate, Macrophyte, Fish, and Custom. The latter allows 
you to import a personal dataset and use it as a reference community (see Create CustRef dataset). 
Finally, you can specify the data type between abundance or presence/absence <b>[3]</b>.
You can activate the specific checkbox if you want to convert your data type from abundance to presence/absence format.

<br>
<br>

<b>biomonitoR App</b> offers you also the opportunity to convert your dataset to 
<b>vegan</b> and <b>biotic</b> format <b>[4;5]</b>.
<br>
<b>vegan</b> is an R package widely used in community ecology studies. The difference between the dataset 
structure between <b>biomonitoR App</b> and <b>vegan</b> is the content of the rows and columns. 
In the <b>biomonitoR App</b>, the rows indicate the taxa and the columns sampling sites. 
Whereas, in <b>vegan</b>, the rows indicate the sampling site and the columns the taxa.
You can also select the taxonomic level you need to convert your data by the proper drop-down menu. 
Selecting high taxonomic ranks, the <b>biomonitoR App</b> groups all the taxa 
belonging to the selected taxonomic level.
<br>
<b>biotic</b> is an R package for calculating several UK freshwater invertebrate biotic indices. 
In this case, the conversion from <b>biomonitoR App</b> to <b>biotic</b> format consists of 
standardizing your taxa to the family level.

<br>
<br>

<b>Note</b>: To work correctly, <b>biomonitoR App</b> requires a specific dataset configuration. 
Specifically, the first column has to be named <i><b>'Taxa'</b></i>, in which are stored the taxa names. 
The others have to be named with the sample points (e.g., localities), 
and they need to contain abundance or presence/absence data."

)
), 

column(width = 8,
       img(src = "./Help_img/01_Data_Input_&_Management.png", vspace="10px"),
       img(src = "./Help_img/02_convert_to_vegan_biotic.png")
        )
)
)
