---
title: Surprising Alpha | rCharts Analysis
lead: Quick Bar Plots Using nvd3 and dimple
framework: pure
mode     : selfcontained # {standalone, draft}
highlighter: prettify
hitheme: twitter-bootstrap
assets:
  css:
    - http://yui.yahooapis.com/pure/0.4.2/pure-min.css
    - http://purecss.io/combo/1.11.2?/css/main-grid.css&/css/main.css&/css/home.css&/css/rainbow/baby-blue.css
    - http://fonts.googleapis.com/css?family=Roboto:300,400
    - http://fonts.googleapis.com/css?family=Oxygen:300
---



While on the topic of rebalancing (see [Unsolved Mysteries of Rebalancing](http://timelyportfolio.blogspot.com/2014/02/unsolved-mysteries-of-rebalancing.html)), I thought it would be good to highlight another good research paper with some quick rCharts analysis.

<blockquote>
<small><em style = "background-color:#E7E4E4;">data source:</em></small><br>
Arnott, Robert D., et al.<br>
<strong>The Surprising Alpha from Malkiel’s Monkey and Upside-Down Strategies</strong><br>
The Journal of Portfolio Management 39.4 (2013): 91-105.
</blockquote>

We will use the data from Exhibits 1 and 5 to produce interactive bar plots.  In planned later work, we will extend these simple charts into a much more detailed, interactive look at these statistics.


<h2 class="content-subhead">Grab the Data</h2>


```r
require(reshape2)
require(ggplot2)
require(rCharts)

#read in the csv version of data
rebalStats <- read.csv(
  "global rebalance allocation stats.csv",
  stringsAsFactors = F
)

#make long form
rebalStats.melt <- melt(
  rebalStats,
  id.vars = 1:3,
  variable.name = "Statistic",
  value.name = "Value"
)
rebalStats.melt$Value = as.numeric(rebalStats.melt$Value)
```


<h2 class="content-subhead">Bar Plot with nvd3</h2>


```r
#draw a nvd3 bar plot
nBar <- nPlot(
  Value ~ Strategy,
  group = "Geography",
  data = subset(rebalStats.melt, Statistic == "Annual.FF4Alpha"),
  type = "multiBarHorizontalChart",
  height = 400,
  width = 600
)
nBar$yAxis(
  tickFormat = 
    "#!function(d){return d3.format('.3%')(d)}!#"
)
nBar$chart(
  margin = list(
    top = 100,
    right = 20,
    bottom = 50,
    left = 350
  ),
  showControls = FALSE  #stacked does not make sense for this
)
nBar
```

<iframe src='
assets/fig/unnamed-chunk-3.html
' scrolling='no' seamless
class='rChart nvd3 '
id=iframe-
chart1d746e186017
></iframe>
<style>iframe.rChart{ width: 100%; height: 400px;}</style>


<h2 class="content-subhead">Bar Plot with Dimple</h2>


```r
#draw a dimple bar plot
dBar <- dPlot(
  y = c("Geography","Strategy"),
  x = "Value",
  groups = c("StrategyType"),
  data = subset(rebalStats.melt, Statistic == "Return"),
  type = "bar"
)
dBar$xAxis(
  type = "addMeasureAxis",
  outputFormat = ".1%"
)
dBar$yAxis(
  type = "addCategoryAxis",
  grouporderRule = "StrategyType"
)
dBar
```

<iframe src='
assets/fig/unnamed-chunk-4.html
' scrolling='no' seamless
class='rChart dimple '
id=iframe-
chart1d74d473732
></iframe>
<style>iframe.rChart{ width: 100%; height: 400px;}</style>


<h2 class = "content-subhead">Thanks</h2>
- [Research Affiliates](http://researchaffiliates.com) for the research
- [Ramnath Vaidyanathan](http://github.com/ramnathv)
- [Mike Bostock](http://bost.ocks.org/mike/) for [d3.js](http://d3js.org) and all the examples
- [nvd3 Team](http://nvd3s.org)
- [John Kiernander](https://twitter.com/jkiernander) for [dimplejs](http://dimplejs.org)
- [Yahoo](http://yahoo.com) for their framework [Pure](htpp://purecss.io)
- [Google Webfonts](http://google.com/webfonts) for Roboto and Oxygen

