% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/least_common_parents.R
\name{least_common_parents}
\alias{least_common_parents}
\title{Find the least common parents in a graph}
\usage{
least_common_parents(graph, selected)
}
\arguments{
\item{graph}{A graph object}

\item{selected}{A character vector of node ids}
}
\value{
A character vector of node ids
}
\description{
It finds the nodes that have no parents in the given
set.
}
\examples{
graph_edges <- data.frame(
  parent = c("A", "B", "C", "C", "F"),
  child = c("B", "C", "D", "E", "D")
)

graph <- graph_builder() |>
  populate_edges(graph_edges, parent, child) |>
  build_directed()
graph

graph |> least_common_parents(c("D", "E"))
}
\seealso{
Other analyze graphs: 
\code{\link{find_all_paths}()},
\code{\link{find_path}()},
\code{\link{find_path_one_to_many}()},
\code{\link{get_all_leaves}()},
\code{\link{get_all_roots}()},
\code{\link{get_leaves_under}()},
\code{\link{get_roots_over}()}
}
\concept{analyze graphs}
