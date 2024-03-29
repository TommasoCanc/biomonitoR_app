fluidRow(
  div(style="display: inline-block;vertical-align:top; margin-left:30px",
      column(width = 4 ,
  HTML(" 

<h1>Diversity Indices</h1> 

<br>
       
<h3>The panel <b>Diversity Indices</b> enables the calculation of numerous diversity indices applied in different ecology fields (freshwaters, marine, terrestrial).</h3>

<br>
<br>

<h4> Taxa richness </h4>

Taxa richness is a metric that measures the number of taxa in each sample. In <b>biomonitoR App</b> users can calculate Taxa richness at four taxonomic levels: <i><b>Family</b></i>, <i><b>Genus</b></i>, <i><b>Species</b></i>, and <i><b>Taxa</b></i>. Once selected the taxonomic level desired, clicking on 'Run' will provide the results.

<br>

Once selected the taxonomic level desired, activate the checkbox <b>'Run'</b>

<br>
<br>

<h4> Diversity Index </h4>

<b>biomonitoR App</b> can calculate 12 Diversity indices  (see below for details) at four taxonomic levels: <i><b>Family</b></i>, <i><b>Genus</b></i>, <i><b>Species</b></i>, and <i><b>Taxa</b></i>. 

Once selected the taxonomic level desired, activate the checkbox <b>'Run'</b>

<br>
<br>

<b> Index details</b>

<br>
<br>

<li><b>Shannon index:</b> <font size='+1'> H<sup>'</sup> = -&sum;<sub>i=1</sub><sup>S</sup> p<sub>i</sub> \ log(p<sub>i</sub>) <br></li> </font>
<br>
<li><b>Pielou index:</b> <font size='+1'> J<sup>'</sup> = <sup>H <sup>'</sup></sup> &#8260; <sub>log(S)</sub></li> </font>
<br>
<li><b>Margalef diversity:</b> <font size='+1'> D<sub>mg</sub> = <sup>(S - 1)</sup> &#8260; <sub>log(N)</sub></li> </font>
<br>
<li><b>Menhinick diversity:</b> <font size='+1'> D<sub>mg</sub> = <sup>S</sup> &#8260; <sub>&radic;(N)</sub></li> </font>
<br>
<li><b>Brillouin index:</b> <font size='+1'> HB = <sup>log(N) - &sum;<sub>log(n<sub>i</sub>)</sup> &#8260; <sub>N</sub></li> </font>
<br>
<li><b>Simpson's index:</b> <font size='+1'> D = &sum; <sub>i=1</sub><sup>S</sup> * p<sub>i</sub><sup>2</sup> </li> </font>
<br>
<li><b>Simpson's evenness:</b> <font size='+1'> D<sub>1 &#8260; D</sub> =  <sup> 1 &#8260; D</sup>  &#8260; <sub>&radic;(S)</sub> </li> </font>
<br>
<li><b>Berger-Parker index:</b> <font size='+1'> d = <sup>N <sub>max</sub></sup> &#8260; <sub>N</sub> </li> </font>
<br>
<li><b>McIntosh's diversity:</b> <font size='+1'> D = <sup>N - U</sup> &#8260; <sub>N - &radic;(N)</sub> </li> </font>
<br>
<li><b>Fisher alpha:</b> <font size='+1'> a = <sup>N(1-x)</sup> &#8260; <sub>x</sub> </li> </font>
")
)

# column(width = 8,
#        img(src = "./Help_img/05_Create_Custom_RND.png", vspace="5px")
#        )
)
)
