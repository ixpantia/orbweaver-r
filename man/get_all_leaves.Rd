% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_leaves.R
\name{get_all_leaves}
\alias{get_all_leaves}
\title{Get all the leaf nodes of a graph}
\usage{
get_all_leaves(graph, ...)
}
\arguments{
\item{graph}{A graph object}

\item{...}{Unused}
}
\value{
A character vector of nodes
}
\description{
Retrieves the nodes in a graph that have no children
}
\examples{
graph <- graph_builder() |>
  add_path(c("A", "B", "C")) |>
  add_path(c("A", "D", "C")) |>
  add_path(c("Z", "B", "C")) |>
  add_path(c("Z", "B", "H")) |>
  build_directed()

get_all_leaves(graph)
}
