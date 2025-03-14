% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nodes.R
\name{nodes}
\alias{nodes}
\title{Get the nodes in the graph}
\usage{
nodes(graph, ...)
}
\arguments{
\item{graph}{A directed or directed acyclic graph}

\item{...}{Reserved for later use}
}
\value{
A character vector with the nodes
}
\description{
Returns the unique nodes in the graph
}
\examples{
graph <- graph_builder() |>
  add_edge(from = "A", to = "B") |>
  build_directed()
graph

nodes(graph)
}
