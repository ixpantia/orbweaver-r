#' @title Checks if a node in a graph has parents
#' @description
#' This function validates if any edge points to the
#' given node.
#' @param graph A graph object
#' @param nodes A character vector of nodes to determine
#' @return A logical vector with the same length as `nodes`
#' @export
#' @examples
#' graph <- graph_builder() |>
#'   add_edge(from = "A", to = "B") |>
#'   build_directed()
#' graph
#'
#' graph |> has_parents(nodes = "A")
#' graph |> has_parents(nodes = "B")
has_parents <- function(graph, nodes) {
  UseMethod("has_parents")
}

#' @export
has_parents.DirectedGraph <- function(graph, nodes) {
  throw_if_error(graph$has_parents(nodes))
}

#' @export
has_parents.DirectedAcyclicGraph <- function(graph, nodes) {
  throw_if_error(graph$has_parents(nodes))
}
