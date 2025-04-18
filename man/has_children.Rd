% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/has_children.R
\name{has_children}
\alias{has_children}
\title{Checks if a node in a graph has children}
\usage{
has_children(graph, nodes)
}
\arguments{
\item{graph}{A graph object}

\item{nodes}{A character vector of nodes to determine}
}
\value{
A logical vector with the same length as \code{nodes}
}
\description{
This function validates if the node has an edge pointing
to any other node.
}
\examples{
graph <- graph_builder() |>
  add_edge(from = "A", to = "B") |>
  build_directed()
graph

graph |> has_children(nodes = "A")
graph |> has_children(nodes = "B")
}
