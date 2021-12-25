fluidRow(
  div(style="display: inline-block;vertical-align:top; margin-left:30px",
      
  HTML("<h1>biomonitoR-web</h1>
<h3>What is biomonitoR</h3>
<br>
<b>
  <i>biomonitoR</i>
</b> is a package for the R programming language that fills a gap in the range of informatic tools for managing and visualising biomonitoring data. <br>
<i>
  <b>biomonitoR </i>
</b> implements most of the biological indices currently used, tested, or just proposed in different fields of ecology and freshwater resource management. <br> Its easy-to-use design favours the flow of information that is currently often fragmented in specific country methods, national protocols and informatic programs. <br>
<br>
<i>
  <b>biomonitoR </i>
</b> represents a flexible toolbox that allows the user to: <br>
<b>i)</b> check taxonomy, sensitivity, and biological and ecological traits against updated reference datasets; <br>
<b>ii)</b> manage datasets composed by a heterogeneous taxonomic resolution simplifying the the calculation of wide set of biological indices using different taxonomic levels; <br>
<b>iii)</b> estimate metrics for broad and stressor-specific ecological assessment; <br>
<b>iv)</b> provide several data visualisation options to help decision-making processes and result publication. <br>
<br>
<h3>Contacts</h3>
<i>
  <b>biomonitoR-web</b>
</i> is created and maintained by <i><b>Alex Laini</i></b> and <i><b>Tommaso Cancellario</i></b> <br>
<br> To comunicate bug report and feature requests please contact: <a href=\"mailto:alex.laini@gmail.com\">A. Laini</a> or <a href=\"mailto:tommaso.canellario@gmail.com\">T. Cancellario</a>

<br> To send pull request on GitHub: <a href=\"https://github.com/alexology\"> alexology GitHub</a>
<br>

<h3>Citation</h3>
Please to cite <i><b>biomonitoR</i></b> ...


"
)),
tags$br(),
tags$br(),
tags$br(),
img(src = "biomonitor_300px.png", height = '100px'),

tags$br(),
tags$br(),

div(style="display: inline-block;vertical-align:top; margin-left:30px",
HTML("<h3>Contributors</h3>
Alex Laini, Simone Guareschi, Rossano Bolpagni, Gemma Burgazzi, Daniel Bruno 
Cayetano Gutiérrez-Cánovas, Rafael Miranda, Cédric Mondy, Gábor Várbíró,
Tommaso Cancellario")),

tags$br(),
tags$br(),
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