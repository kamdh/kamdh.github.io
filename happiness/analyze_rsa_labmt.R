## look for QWERTY effect in LabMT1.0 data
## (words with non-alphabetic chars removed)
##
## Kameron Decker Harris 03/14/2012
## University of Vermont Storylab

## constants
deltahavg <- 1 # tunable knob, happiness sensitivity
                                        # we'll plot results for this later
havgcenter <- 5

## load libraries and define functions
library(ggplot2)

## from http://wiki.stdout.org/rcookbook/Graphs/Multiple%20graphs%20on%20one%20page%20(ggplot2)/
multiplot <- function(..., plotlist=NULL, cols) {
  require(grid)
  ## Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  numPlots = length(plots)
  ## Make the panel
  plotCols = cols                          # Number of columns of plots
  plotRows = ceiling(numPlots/plotCols) # Number of rows needed, calculated from # of cols
  ## Set up the page
  grid.newpage()
  pushViewport(viewport(layout = grid.layout(plotRows, plotCols)))
  vplayout <- function(x, y)
    viewport(layout.pos.row = x, layout.pos.col = y)
  ## Make each plot, in the correct location
  for (i in 1:numPlots) {
    curRow = ceiling(i/plotCols)
    curCol = (i-1) %% plotCols + 1
    print(plots[[i]], vp = vplayout(curRow, curCol ))
  }
}

fittunefun <- function(words, deltahavg, havgcenter) {
  mask <- { words$havg > (havgcenter + deltahavg) |
            words$havg < (havgcenter - deltahavg) }
  wordsfilt <- words[mask,] # filter according to knob
  fitfilt <- lm(havg ~ RSA, data=wordsfilt)
  return(fitfilt)
}

fitweightedfun <- function(words, deltahavg, havgcenter) {
  mask <- { words$havg > (havgcenter + deltahavg) |
            words$havg < (havgcenter - deltahavg) }
  wordsfilt <- words[mask,] # filter according to knob
  words2 <- ddply(wordsfilt, "RSA", summarise, mean_havg=mean(havg),
                  sd_havg=sd(havg), N=sum(!is.na(havg)))
  fit <- lm(mean_havg ~ RSA, data=words2, weights=N)
  return(fit)
}

pvalfit <- function(fit) {
  ## if( ( class(fit) != "lm" ) || ( class(fit) != "glm" ) ) {
  ##   warning("class of argument sent to pvalfit not \"lm\" or \"glm\"")
  ## }
  tmp <- coef(summary(fit))
  if( !all( dim(tmp) == c(2,4) ) ) {
    warning("unexpected dimensions of fit coefficients")
  }
  return(tmp[2,4])
}

## do analysis on data
words <- read.table("labMT.rsa.txt", header=TRUE)

## plotting raw data, binned, with PCA
#postscript("plot_RSA_raw_bin2d.eps", width=10, height=10)
png("plot_RSA_raw_bin2d.png", width=1000, height=1000)
p <- ggplot(words, aes(RSA, havg))
x <- seq(-10, 11, by=1) - 0.5
y <- seq(1, 9, by=0.1)
p <- p + stat_bin2d(breaks=list(x, y))
## pcobj <- prcomp(cbind(words$RSA, words$havg)) #perform PCA on raw data
## centervec <- pcobj$center #center of data
## rotvecs <- matrix(t(pcobj$rotation), ncol=2) #direction of PCs
## pcendpts <- matrix(centervec, ncol=2, nrow=2) #replicate center vector
## pcendpts <- t(pcendpts) #deal w replication down columns
## pcendpts <- pcendpts + rotvecs
## p <- p + geom_segment(data=data.frame(pcendpts),
##                       aes(xend = pcendpts[,1],
##                           yend = pcendpts[,2]),
##                       x=centervec[1], y=centervec[2],
##                       arrow=arrow(angle=30, length=unit(0.2, "cm")))
##p <- p + scale_fill_brewer()
##p <- p + geom_point(size=0.2)
print(p)
dev.off()

## fit
cat("summary of results for unfiltered data:")
fit <- lm(havg ~ RSA, data=words)
print(summary(fit))

## fit with deltahavg set above
mask <- { words$havg > (havgcenter + deltahavg) |
          words$havg < (havgcenter - deltahavg) }
wordsfilt <- words[mask,] # filter according to knob
cat("summary of results for filtered data:")
fitfilt <- fittunefun(words, deltahavg, havgcenter)
print(summary(fitfilt))

## plot filtered results
svg(file=paste("plot_RSA_deltahavg=",deltahavg,".svg",sep=""),
    width=10, height=10)
p <- ggplot(wordsfilt, aes(factor(RSA), havg))
p <- p + geom_point(position=position_jitter(width=0.2,height=0), alpha=.4)
tmp <- coefficients(fitfilt)
p <- p + geom_abline(intercept=tmp[1], slope=tmp[2])
print(p)
dev.off()

## doing analysis across deltahavg
deltahavg.sweep = seq(0.5, 2, 0.1)
pval <- mapply( function(x) pvalfit(fitweightedfun(words, x, havgcenter)),
               deltahavg.sweep )
fitslope <- mapply( function(x) coef(fitweightedfun(words, x, havgcenter))[2],
                   deltahavg.sweep)
sweep.data <- data.frame(deltahavg=deltahavg.sweep,
                         fitslope, pval)
postscript("plot_p-value_RSA_fit_vs_deltahavg_weighted_glm.eps")
##qplot( deltahavg, pval, data=sweep.data, xlab="delta h_avg", ylab="p-value")
p1 <- ggplot(sweep.data) +
  geom_point(aes(x=deltahavg, y=fitslope, ylab="slope")) +
  opts(title="slope of weighted linear model havg ~ RSA")
p2 <- ggplot(sweep.data) +
  geom_point(aes(x=deltahavg, y=pval, ylab="p-value")) +
  opts(title="p-value for slope")
multiplot(p1,p2,cols=1)
dev.off()


## separate +/- word analyses
wordsfilt$posneg <- factor(ifelse(wordsfilt$havg > havgcenter, "+", "-"))
fitpos <- fitweightedfun(words[wordsfilt$posneg == "+",], deltahavg, havgcenter)
cat("summary of results for filtered, + data:")
print(summary(fitpos))
fitneg <- fitweightedfun(words[wordsfilt$posneg == "-",], deltahavg, havgcenter)
cat("summary of results for filtered, - data:")
print(summary(fitneg))


## try binning by RSA
words2 <- ddply(words, "RSA", summarise, mean_havg=mean(havg),
                sd_havg=sd(havg), N=sum(!is.na(havg)))
## linear regression, weighted by number of points at that RSA
fit <- lm(mean_havg ~ RSA, data=words2, weights=N)
##postscript("plot_binned_by_RSA.eps")
png("plot_binned_by_RSA.png", width=500,height=500)
p <- ggplot(data=words2, aes(x=RSA,y=mean_havg, size=N))
p <- p + geom_point()
tmp <- coefficients(fit)
p <- p + geom_abline(intercept=tmp[1], slope=tmp[2])
print(p)
dev.off()
