#' @title Find the least common parents in a graph
#' @description
#' It finds the nodes that have no parents in the given
#' set.
#' @param graph A graph object
#' @param selected A character vector of node ids
#' @return A character vector of node ids
#' @export
#' @family analyze graphs
#' @examples
#' graph_edges <- data.frame(
#'   parent = c("A", "B", "C", "C", "F"),
#'   child = c("B", "C", "D", "E", "D")
#' )
#'
#' graph <- graph_builder() |>
#'   populate_edges(graph_edges, parent, child) |>
#'   build_directed()
#' graph
#'
#' graph |> least_common_parents(c("D", "E"))
least_common_parents <- function(graph, selected) {
  UseMethod("least_common_parents")
}

#' @export
least_common_parents.DirectedGraph <- function(graph, selected) {
  throw_if_error(graph$least_common_parents(selected))
}

#' @export
least_common_parents.DirectedAcyclicGraph <- function(graph, selected) {
  throw_if_error(graph$least_common_parents(selected))
}
