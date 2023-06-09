% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/visualization.R
\name{plot_seroprev_fitted}
\alias{plot_seroprev_fitted}
\title{Function that generates a seropositivity plot corresponding to the specified fitted serological model}
\usage{
plot_seroprev_fitted(seromodel_object, size_text = 6)
}
\arguments{
\item{seromodel_object}{Object containing the results of fitting a model by means of \link{run_seromodel}.}

\item{size_text}{Text size of the graph returned by the function.}
}
\value{
A ggplot object containing the seropositivity-vs-age graph including the data, the fitted model and their corresponding confindence intervals.
}
\description{
This function generates a seropositivity plot of the specified serological model object. This includes the original data grouped by age
as well as the obtained fitting from the model implementation. Age is located on the x axis and seropositivity on the y axis with its 
corresponding confidence interval.
}
\examples{
\dontrun{
data("serodata")
data_test <- prepare_serodata(serodata)
seromodel_object <- run_seromodel(serodata = data_test,
                                  foi_model = "constant",
                                  n_iters = 1000)
plot_seroprev_fitted(seromodel_object, size_text = 15)
}
}
