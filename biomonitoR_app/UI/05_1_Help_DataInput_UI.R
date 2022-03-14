fluidRow(
  div(style="display: inline-block;vertical-align:top; margin-left:30px",
      column(width = 4 ,
  HTML(" 
       
<h1>Data Input</h1> 

<br>
       
<h3>The panel Data Input allows the user to import their dataset and manage it efficiently.</h3>

<br>
<br>

The first step when working with the <b>biomonitoR App</b> is loading the user’s data. To do that, open the panel <i><b>'Load File - Community data'</b></i> and click on <i><b>'Browser'</b></i> <b>[1]</b>. Now a file can be selected, and once loaded, it will appear in the main panel. Such table is editable. 

<br>

<b>biomonitoR App</b> accepts three different file format for the upload .xlsx, .csv, or .txt. 

<br>
<br>

Once the data are loaded, the user needs to select the reference community through the dedicated drop-down menu <b>[2]</b>. Four reference communities are available: Macroinvertebrates, Macrophytes, Fish, and Custom (CRD). The latter allows to import a personal dataset and use it as a reference community (see <i><b>Custom Reference Dataset</b></i>). Finally, the data type can be specified by selecting either abundance or presence/absence <b>[3]</b>. A specific checkbox allows to convert data from abundance to presence/absence format. 

<br>
<br>

<b>biomonitoR App</b> also offers the opportunity to convert datasets to <b>“vegan”</b> and <b>“biotic”</b> format <b>[4;5]</b>. 

<br>

<b>vegan</b> (Oksanen et al., 2020) is an R package widely used in community ecology studies. The difference of the dataset structure between <b>biomonitoR App</b> and <b>vegan</b> is the content of the rows and columns. In <b>biomonitoR App</b>, the rows indicate the taxa and the columns sampling sites. Whereas, in <b>vegan</b>, the rows indicate the sampling site and the columns the taxa. The taxonomic level needed to convert the data can be selected by the proper drop-down menu. If a high taxonomic rank is selected (e.g., family), <b>biomonitoR App</b> groups all the taxa belonging to the selected taxonomic level. 

<br>

<b>biotic</b> (Briers, 2016) is an R package for calculating several UK freshwater invertebrate biotic indices. In this case, the conversion from biomonitoR App to biotic format consists of standardizing taxa to the family level. 

<br>
<br>

<b>Please Note</b>: <b>biomonitoR App</b> requires a specific dataset configuration to work properly. As mentioned before (Data Input & Management section), the first column needs to be named 'Taxa'. This column needs to contain the nomenclature of your taxa. The others need to be named with the sample points (e.g., localities), and they need to contain abundance or presence/absence data.
"
)
), 

column(width = 8,
       img(src = "./Help_img/01_Data_Input_&_Management.png", vspace="10px"),
       img(src = "./Help_img/02_convert_to_vegan_biotic.png")
        )
)
)
