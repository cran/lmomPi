% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cdf.R
\name{cdf}
\alias{cdf}
\alias{spi.cdf}
\alias{cdf.spi}
\title{Generic function for \code{cdf...}: probability distribution fitting with L-Moments.}
\usage{
cdf(
  para,
  x,
  probability_distribution_attrname = "probability_distrib",
  indices = NULL,
  return.as.spi = FALSE,
  spi.scale = NA,
  distrib = NA,
  ...
)

spi.cdf(x, para, ...)

cdf.spi(x, para, ...)
}
\arguments{
\item{x, para, ...}{L-moments and further parameters for \code{cdf...} and \code{\link{cdf}}}

\item{probability_distribution_attrname}{attribute name for probability distribution}

\item{indices}{vector of string working as factors or indices, e g. the month names or similar. It must be of the same length of \code{x} or the length equal to 1 other \code{NULL}, if not used. If used, it computes \code{cdf} for each factor.}

\item{return.as.spi}{logical parameter. Default is \code{FALSE}. If it is \code{TRUE} probability value is transformed to a normalized random variable through standard \code{\link{qnorm}}, as for Standard Precipitation Index (SPI) (\url{https://climatedataguide.ucar.edu/climate-data/standardized-precipitation-index-spi}).}

\item{spi.scale}{integer value or \code{NA}. If it greater than 1 \code{x} is filtered with the sum of a generic element of \code{x} and the previous \code{spi.scale-1} ones (e.g. SPI-3,SPI-6, etc. ). Default is \code{NA} (no filtering) which is equivalent to \code{spi.scale=1}.}

\item{distrib}{character string indicating the probability distribution, it can be used in case \code{para} has no attributes. Default is \code{NA} and distribution info are all passed through \code{para}.}
}
\value{
A vector of cumulated probability value(s) or SPI-like Gaussianized values. It is a list of vectors in case of several probability parametric distribution functions (i.e. \code{para} is a list and \code{length(para)>1}).
}
\description{
These functions compute value(s) of cumulated probability or SPI-like (normal standardize) index from a sample or time series of \code{x}.
}
\examples{

# Sample L-moments of Ozone from the airquality data
data(airquality)
lmom <- samlmu(airquality$Ozone,nmom=6)

distrib <- c("exp","gam","gev","glo","gpa","gno","gum","kap",
"ln3","nor","pe3","wak","wei")

para_list <- pel(distrib=distrib,lmom=lmom)
cdf_list <- cdf(para=para_list,x=airquality$Ozone)

cdf_gam <- cdf(para=para_list$gam,x=airquality$Ozone)
cdf_gam2 <- cdf(para=para_list$gam,x=airquality$Ozone,distrib="gam")

if (any(cdf_gam!=cdf_gam2,na.rm=TRUE)) stop("Any possible errors after  0.6.3 package updates!") 

\donttest{

## Comparison with the SPI/SPEI algorithms:  'SPEI::spi' ('SPEI' package)

if (requireNamespace("SPEI",quietly = TRUE)) {
 library(SPEI)
 data(wichita)

 distrib_wichita <- 'pe3'
 spi.scale <- 1

 month_wichita <- sprintf("M\%02d",wichita$MONTH)
 para_whichita  <- pel(x=wichita$PRCP,indices=month_wichita,distrib=distrib_wichita,
						spi.scale=spi.scale)
 spi_wichita   <- spi.cdf(x=wichita$PRCP,indices=month_wichita,para=para_whichita,
						spi.scale=spi.scale)
 spi_wichita_speipkg   <- spi(data=wichita$PRCP,distrib='PearsonIII',scale=spi.scale)
 difference <- spi_wichita-spi_wichita_speipkg$fitted
}

}

}
\seealso{
\code{\link{pel}},\code{\link{cdfexp}},\code{\link{cdfgam}},\code{\link{cdfgev}},\code{\link{cdfglo}},

\code{\link{cdfgpa}},\code{\link{cdfgno}},\code{\link{cdfgum}},\code{\link{cdfkap}},\code{\link{cdfln3}},\code{\link{cdfnor}},\code{\link{cdfpe3}},\code{\link{cdfwak}},\code{\link{cdfwei}}
}
