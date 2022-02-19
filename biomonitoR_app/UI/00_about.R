fluidRow(
  div(style="display: inline-block;vertical-align:top; margin-left:30px",
      column(width = 7,
             
             HTML("<h1>biomonitoR App</h1>
<h3>What is biomonitoR</h3>
<br>


<b><i>biomonitoR</i></b> is a package for the R programming language that fills a gap in the range of informatic tools for calculating and managing biological and ecological data. <br>
To date, <i><b>biomonitoR</i></b> implements most of the biological indices (both taxonomic and functional based) currently used, tested, or just proposed in different fields of ecology and freshwater science. 
Its easy-to-use design favors the flow of information that is currently often fragmented in specific country methods, national protocols and informatic programs. <br>
<br>
<i><b>biomonitoR </i></b> represents a flexible toolbox that allows to: <br>
<b>i)</b> check taxonomy, sensitivity, and biological and ecological traits against updated reference datasets; <br>
<b>ii)</b> manage datasets composed by a heterogeneous taxonomic resolution simplifying the calculation of wide set of biological indices using different taxonomic levels; <br>
<b>iii)</b> calculate metrics for broad and stressor-specific ecological assessment; <br>
<b>iv)</b> provide several data visualization options helping decision-making processes and result dissemination. <br>
<br>
<h3>Contacts</h3>
<i>
  <b>biomonitoR App</b>
</i> is created and maintained by <i><b>Alex Laini</i></b>, <i><b>Tommaso Cancellario</i></b>, and <i><b>Simone Guareschi</i></b> <br>
<br> To comunicate bug report and feature requests please contact: 
<a href=\"mailto:alex.laini@gmail.com\">A. Laini</a> or <a href=\"mailto:tommaso.canellario@gmail.com\">T. Cancellario</a>

<br> To asks for changes concerning <b>biomonitoR</b> package, please send a pull request on GitHub at: <a href=\"https://github.com/alexology\"> GitHub-biomonitoR </a>
<br>
To asks for changes concerning <b>biomonitoR App</b> package, please send a pull request on GitHub at: <a href=\"https://github.com/TommasoCanc/biomonitoR_app\"> GitHub-biomonitoR App </a>
<br>

<h3>Citation</h3>
Please to cite <i><b>biomonitoR</i></b> ..."
             )
             )
  ),

tags$br(),
tags$br(),
tags$br(),
div(style="display: inline-block;vertical-align:top; margin-left:30px",
img(src = "biomonitor_300px.png", height = '100px')),

tags$br(),
tags$br(),

column(width = 7,
div(style="display: inline-block;vertical-align:top; margin-left:30px",
HTML("<h3>Contributors</h3>
Alex Laini, Simone Guareschi, Rossano Bolpagni, Gemma Burgazzi, Daniel Bruno 
Cayetano Gutiérrez-Cánovas, Rafael Miranda, Cédric Mondy, Gábor Várbíró,
Tommaso Cancellario")
)
),

tags$br(),
tags$br(),
column(width = 7,
img(src = "unipr_300px.png", height = "50px", hspace="10"),
img(src = "unito_300px.png", height = "50px", hspace="10"),
img(src = "alpstream_300px.png", height = "50px", hspace="10"),
img(src = "donana_300px.png", height = "50px", hspace="10"),
img(src = "koblenz_300px.png", height = "30px", hspace="10"),
img(src = "ipe_300px.png", height = "50px", hspace="10"),
img(src = "unav_300px.png", height = "50px", hspace="10"),
img(src = "ofb_300px.png", height = "50px", hspace="10"),
img(src = "elkh_300px.png", height = "30px", hspace="10"),

tags$hr(),
div(style="display: inline-block;vertical-align:top; margin-left:30px",
HTML("<h3>Acknowledgements</h3>
This package is based upon work from COST Action CA15113 (SMIRES, Science and 
Management of Intermittent Rivers and Ephemeral Streams,www.smires.eu), 
supported by COST (European Cooperation in Science and Technology).")),
tags$br(),
tags$br(),
img(src = "smires_300px.png", height = "50px", hspace="20"),
img(src = "cost_300px.png", height = "50px", hspace="10")
)

)
