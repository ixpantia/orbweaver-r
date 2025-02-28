#' @title Get the children on a node
#'
#' @description
#' Get a list of the node ids of the children of
#' the provided node.
#' @param graph A graph object
#' @param nodes A character vector of nodes to find children for
#' @return A character vector
#' @export
#' @examples
#' graph <- graph_builder() |>
#'   add_edge(from = "A", to = "B") |>
#'   build_directed()
#'
#' graph |> children("A")
children <- function(graph, nodes) {
  UseMethod("children")
}

#' @export
children.DirectedGraph <- function(graph, nodes) {
  throw_if_error(graph$children(nodes))
}

#' @export
children.DirectedAcyclicGraph <- function(graph, nodes) {
  throw_if_error(graph$children(nodes))
}
