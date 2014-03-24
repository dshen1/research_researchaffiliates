#<blockquote>
#  <small><em style = "background-color:#E7E4E4;">data source:</em></small><br>
#  Arnott, Robert D., et al.<br>
#  <strong>The Surprising Alpha from Malkiel’s Monkey and Upside-Down Strategies</strong><br>
#  The Journal of Portfolio Management 39.4 (2013): 91-105.
#</blockquote>

require(reshape2)
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

dBar2 <- dPlot(
  y = c("Geography","Strategy"),
  x = "Value",
  groups = c("StrategyType"),
  data = rebalStats.melt,
  type = "bar",
  height = 800
)
dBar2$set(defaultColors = "#!d3.scale.category20()!#")
dBar2$xAxis(
  type = "addMeasureAxis",
  outputFormat = ".1%"
)
dBar2$yAxis(
  type = "addCategoryAxis",
  grouporderRule = "StrategyType"
)
dBar2$set( facet = list( y = "Statistic", x = "Geography", removeAxes = T))
dBar2$addFilters("Geography","StrategyType","Statistic")
dBar2$templates$script = 
  #"./chart_singleselect.html"
  "http://timelyportfolio.github.io/rCharts_dimple/chart_multiselect_intersect.html"
  #"http://timelyportfolio.github.io/rCharts_dimple/chart_multiselect.html"
dBar2


#dBar$addAssets("http://timelyportfolio.github.io/rCharts_dimple/js/d3-grid.js")
#dBar$save("facetbars.html",cdn=T)








#draw a dimple facetted bar plot
dBar <- dPlot(
  x = "Strategy",
  y = "Return",
  groups = c("StrategyType"),
  data = rebalStats,
  type = "bar"
)
dBar$yAxis(
  type = "addMeasureAxis",
  outputFormat = ".1%"
)
dBar$xAxis(
  type = "addCategoryAxis",
  grouporderRule = "StrategyType"
)
#dBar


#add facets, filters, controls
dBar$set(facet = list( x = "StrategyType", y = "Geography", removeAxes = T))
dBar$addControls(
  "facetx",
  value = "StrategyType",
  values = colnames(rebalStats)[1:2]
)
dBar$addControls(
  "facety",
  value = "StrategyType",
  values = colnames(rebalStats)[1:2]
)
dBar$addControls(
  "x",
  value = "Geography",
  values = colnames(rebalStats)[1:3]
)
dBar$addControls(
  "y",
  value = "Return",
  values = colnames(rebalStats)[4:11]
)
dBar$addControls(
  "groups",
  value = "Strategy",
  values = colnames(rebalStats)[1:3]
)
dBar$set(defaultColors = "#!d3.scale.category10()!#")
dBar$templates$script = 
  #"./chart_singleselect.html"
  "http://timelyportfolio.github.io/rCharts_dimple/chart_singleselect.html"
dBar
