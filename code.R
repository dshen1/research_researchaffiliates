

#data source:
#Arnott, Robert D., et al.
#"The Surprising’Alpha’from Malkiel’s Monkey and Upside-Down Strategies."
#The Journal of Portfolio Management 39.4 (2013): 91-105.

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


#draw a nvd3 bar plot
nBar <- nPlot(
  Value ~ Strategy,
  group = "Geography",
  data = subset(rebalStats.melt, Statistic == "Annual.FF4Alpha"),
  type = "multiBarHorizontalChart",
  height = 600,
  width = 900
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