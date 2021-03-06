% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hdng_get_data.R
\name{hdng_get_data}
\alias{hdng_get_data}
\title{Extract the data from the HDNG Database}
\usage{
hdng_get_data(
  variables,
  gemeenten,
  from = 1000,
  to = 2000,
  clean = TRUE,
  col.names = FALSE
)
}
\arguments{
\item{variables}{Your query.}

\item{gemeenten}{The municipalities you want to extract the data for (defaults to all)}

\item{from}{Begin year (to be used in conjunction with to)}

\item{to}{End year (to be used in conjunction with from)}

\item{clean}{Filters the dataset to variables which are available at least once}

\item{col.names}{Gives you the description rather than the variable code as colnames.}
}
\value{
a data.frame of all queried municipalities and variables
}
\description{
This function is used to extract variables indicated by the user from the database.
The user can specify which municipalities (gemeenten), and the possible years to look for.
}
\examples{
hdng_get_data(c("aaa1", "bcx1", "qbx1"), gemeenten = c("Amsterdam", "Eindhoven"), from = 1800, to = 1900)
hdng_get_data("lpkm", from = 1900, to = 1950, clean = FALSE)
}
