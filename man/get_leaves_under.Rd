% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_leaves.R
\name{get_leaves_under}
\alias{get_leaves_under}
\title{Get the leaf nodes of a graph under some nodes}
\usage{
get_leaves_under(graph, nodes)
}
\arguments{
\item{graph}{A graph object}

\item{nodes}{A character vector of nodes to find leaves for}
}
\value{
A character vector of nodes
}
\description{
Retrieves the nodes in a graph that have no children
under a certain node or group of nodes
}
\examples{
graph <- graph_builder() |>
  add_path(c("A", "B", "C")) |>
  add_path(c("A", "D", "C")) |>
  add_path(c("Z", "B", "C")) |>
  add_path(c("Z", "B", "H")) |>
  build_directed()

get_leaves_under(graph, "D")
}
\seealso{
Other analyze graphs: 
\code{\link{find_all_paths}()},
\code{\link{find_path}()},
\code{\link{find_path_one_to_many}()},
\code{\link{get_all_leaves}()},
\code{\link{get_all_roots}()},
\code{\link{get_roots_over}()},
\code{\link{least_common_parents}()}
}
\concept{analyze graphs}
