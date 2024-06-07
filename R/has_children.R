#' @title Checks if a node in a graph has children
#' @description
#' This function validates if the node has an edge pointing
#' to any other node.
#' @param graph A graph object
#' @param nodes A character vector of nodes to determine
#' @return A logical vector with the same length as `nodes`
#' @export
has_children <- function(graph, nodes) {
  UseMethod("has_children")
}

#' @export
has_children.DirectedGraph <- function(graph, nodes) {
  graph$has_children(nodes)
}

#' @export
has_children.DirectedAcyclicGraph <- function(graph, nodes) {
  graph$has_children(nodes)
}
