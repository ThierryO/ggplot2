% Generated by roxygen2 (4.0.0): do not edit by hand
\name{geom_boxplot}
\alias{geom_boxplot}
\title{Box and whiskers plot.}
\usage{
geom_boxplot(mapping = NULL, data = NULL, stat = "boxplot",
  position = "dodge", outlier.colour = NULL, outlier.shape = NULL,
  outlier.size = NULL, notch = FALSE, notchwidth = 0.5, ...)
}
\arguments{
\item{outlier.colour}{colour for outlying points. Uses the default from geom_point().}

\item{outlier.shape}{shape of outlying points. Uses the default from geom_point().}

\item{outlier.size}{size of outlying points. Uses the default from geom_point().}

\item{notch}{if \code{FALSE} (default) make a standard box plot. If
\code{TRUE}, make a notched box plot. Notches are used to compare groups;
if the notches of two boxes do not overlap, this is strong evidence that
the medians differ.}

\item{notchwidth}{for a notched box plot, width of the notch relative to
the body (default 0.5)}

\item{mapping}{The aesthetic mapping, usually constructed with
\code{\link{aes}} or \code{\link{aes_string}}. Only needs to be set
at the layer level if you are overriding the plot defaults.}

\item{data}{A layer specific dataset - only needed if you want to override
the plot defaults.}

\item{stat}{The statistical transformation to use on the data for this
layer.}

\item{position}{The position adjustment to use for overlapping points
on this layer}

\item{...}{other arguments passed on to \code{\link{layer}}. This can
include aesthetics whose values you want to set, not map. See
\code{\link{layer}} for more details.}
}
\description{
The upper and lower "hinges" correspond to the first and third quartiles
(the 25th and 75th percentiles). This differs slightly from the method used
by the \code{boxplot} function, and may be apparent with small samples.
See \code{\link{boxplot.stats}} for for more information on how hinge
positions are calculated for \code{boxplot}.
}
\details{
The upper whisker extends from the hinge to the highest value that is within
1.5 * IQR of the hinge, where IQR is the inter-quartile range, or distance
between the first and third quartiles. The lower whisker extends from the
hinge to the lowest value within 1.5 * IQR of the hinge. Data beyond the
end of the whiskers are outliers and plotted as points (as specified by Tukey).

In a notched box plot, the notches extend \code{1.58 * IQR / sqrt(n)}.
This gives a roughly 95% confidence interval for comparing medians.
See McGill et al. (1978) for more details.
}
\section{Aesthetics}{

\Sexpr[results=rd,stage=build]{ggplot2:::rd_aesthetics("geom", "boxplot")}
}
\examples{
\donttest{
p <- ggplot(mtcars, aes(factor(cyl), mpg))

p + geom_boxplot()
qplot(factor(cyl), mpg, data = mtcars, geom = "boxplot")

p + geom_boxplot() + geom_jitter()
p + geom_boxplot() + coord_flip()
qplot(factor(cyl), mpg, data = mtcars, geom = "boxplot") +
  coord_flip()

p + geom_boxplot(notch = TRUE)
p + geom_boxplot(notch = TRUE, notchwidth = .3)

p + geom_boxplot(outlier.colour = "green", outlier.size = 3)

# Add aesthetic mappings
# Note that boxplots are automatically dodged when any aesthetic is
# a factor
p + geom_boxplot(aes(fill = cyl))
p + geom_boxplot(aes(fill = factor(cyl)))
p + geom_boxplot(aes(fill = factor(vs)))
p + geom_boxplot(aes(fill = factor(am)))

# Set aesthetics to fixed value
p + geom_boxplot(fill = "grey80", colour = "#3366FF")
qplot(factor(cyl), mpg, data = mtcars, geom = "boxplot",
  colour = I("#3366FF"))

# Scales vs. coordinate transforms -------
# Scale transformations occur before the boxplot statistics are computed.
# Coordinate transformations occur afterwards.  Observe the effect on the
# number of outliers.
library(plyr) # to access round_any
m <- ggplot(movies, aes(y = votes, x = rating,
   group = round_any(rating, 0.5)))
m + geom_boxplot()
m + geom_boxplot() + scale_y_log10()
m + geom_boxplot() + coord_trans(y = "log10")
m + geom_boxplot() + scale_y_log10() + coord_trans(y = "log10")

# Boxplots with continuous x:
# Use the group aesthetic to group observations in boxplots
qplot(year, budget, data = movies, geom = "boxplot")
qplot(year, budget, data = movies, geom = "boxplot",
  group = round_any(year, 10, floor))

# Using precomputed statistics
# generate sample data
abc <- adply(matrix(rnorm(100), ncol = 5), 2, quantile, c(0, .25, .5, .75, 1))
b <- ggplot(abc, aes(x = X1, ymin = `0\%`, lower = `25\%`, middle = `50\%`, upper = `75\%`, ymax = `100\%`))
b + geom_boxplot(stat = "identity")
b + geom_boxplot(stat = "identity") + coord_flip()
b + geom_boxplot(aes(fill = X1), stat = "identity")

# Update the defaults for the outliers by changing the defaults for geom_point

p <- ggplot(mtcars, aes(factor(cyl), mpg))
p + geom_boxplot()

update_geom_defaults("point", list(shape = 1, colour = "red", size = 5))
p + geom_boxplot()
}
}
\references{
McGill, R., Tukey, J. W. and Larsen, W. A. (1978) Variations of
    box plots. The American Statistician 32, 12-16.
}
\seealso{
\code{\link{stat_quantile}} to view quantiles conditioned on a
  continuous variable,  \code{\link{geom_jitter}} for another way to look
  at conditional distributions"
}

