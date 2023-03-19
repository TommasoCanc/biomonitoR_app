fluidRow(
  div(style = "display: inline-block;vertical-align:top; margin-left:30px",
      column(
        width = 7,
        HTML(
          "<h1>biomonitoR App</h1>

<h3>What is biomonitoR?</h3>

<i><b>biomonitoR</b></i> is a package for the R programming language that fills a gap in the range of informatic tools for the management and visualization of ecological data. <i><b>biomonitoR</b></i> implements most of the biological indices currently used or proposed in different fields of ecology and aquatic science. Its easy-to-use design favours the flow of information that is often fragmented in specific country methods, national protocols and informatic programs.

<br>
<br>

<i><b>biomonitoR</b></i> currently allows the calculation of more than 30 indices (including diversity, biomonitoring <i>sensu stricto</i> and functional measures) as well as a wide range of further taxonomic indices (e.g., richness or abundance of a particular taxon, pair and combination of taxa).

<br>
<br>

It represents a flexible toolbox with five main assets:
<ul>
    <li>it checks taxonomic information against reference databases allowing for customization of trait and sensitivity scores;</li>
    <li>it supports heterogeneous taxonomic resolutions allowing computations at multiple taxonomic levels;</li>
    <li>it calculates multiple biological indices, including metrics for both general and stressor-specific ecological assessments;</li>
    <li>it enables powerful data visualization, helping both decision-making processes and result dissemination;</li>
    <li>it also allows to work with a user-friendly web application straight from R (biomonitoR App).</li>
</ul>

<h3>Contacts</h3>

<i><b>biomonitoR</b></i> is an original idea developed and currently maintained by <b>Alex Laini</b> and <b>Tommaso Cancellario</b> with the collaboration of <b>Simone Guareschi</b>.

To report bugs, discuss details or further requests please contact: <a href=\"mailto:alex.laini@gmail.com\">A. Laini</a> or <a href=\"mailto:tommaso.canellario@gmail.com\">T. Cancellario</a>

<br>

Users are welcome to send a pull request on GitHub at: <a href=\"https://github.com/alexology\"> GitHub-biomonitoR </a> or directly at <a href=\"https://github.com/TommasoCanc/biomonitoR_app\"> GitHub-biomonitoR App </a>

<h3>Cite</h3>

Please cite as follows:
<ul>
    <li><i>Laini et al., 2022. biomonitoR: an R package for managing ecological data and calculating biomonitoring indices. PeerJ, 10, e14183.</i></li>
</ul>"
        )
      )
),

tags$br(),
tags$br(),
tags$br(),
div(style = "display: inline-block;vertical-align:top; margin-left:30px",
    img(src = "biomonitor_300px.png", height = '100px')
    ),

tags$br(),
tags$br(),

column(
  width = 7,
  div(
    style = "display: inline-block;vertical-align:top; margin-left:30px",
    HTML(
      "<h3>Contributors</h3>
Alex Laini, Simone Guareschi, Rossano Bolpagni, Gemma Burgazzi, Daniel Bruno
Cayetano Gutiérrez-Cánovas, Rafael Miranda, Cédric Mondy, Gábor Várbíró,
Tommaso Cancellario"
    )
  )
),

tags$br(),
tags$br(),
column(
  width = 7,
  img(
    src = "unipr_300px.png",
    height = "50px",
    hspace = "10"
  ),
  img(
    src = "unito_300px.png",
    height = "50px",
    hspace = "10"
  ),
  img(
    src = "alpstream_300px.png",
    height = "50px",
    hspace = "10"
  ),
  img(
    src = "donana_300px.png",
    height = "50px",
    hspace = "10"
  ),
  img(
    src = "koblenz_300px.png",
    height = "30px",
    hspace = "10"
  ),
  img(
    src = "ipe_300px.png",
    height = "50px",
    hspace = "10"
  ),
  img(
    src = "unav_300px.png",
    height = "50px",
    hspace = "10"
  ),
  img(
    src = "ofb_300px.png",
    height = "50px",
    hspace = "10"
  ),
  img(
    src = "elkh_300px.png",
    height = "30px",
    hspace = "10"
  ),
  
  tags$hr(),
  div(
    style = "display: inline-block;vertical-align:top; margin-left:30px",
    HTML(
      "<h3>Acknowledgements</h3>
This package is based upon work from COST Action CA15113 (SMIRES, Science and
Management of Intermittent Rivers and Ephemeral Streams,www.smires.eu),
supported by COST (European Cooperation in Science and Technology)."
    )
  ),
tags$br(),
tags$br(),
img(
  src = "smires_300px.png",
  height = "50px",
  hspace = "20"
),
img(
  src = "cost_300px.png",
  height = "50px",
  hspace = "10"
  )
)
)
