#' @title Checks if a node in a graph has children
#' @description
#' This function validates if the node has an edge pointing
#' to any other node.
#' @param graph A graph object
#' @param node_id The id of the node to check
#' @return A logical describing if the node has children
#' @export
has_children <- function(graph, node_id) {
  UseMethod("has_children")
}

#' @export
has_children.DirectedGraph <- function(graph, node_id) {
  graph$has_children(node_id)
}

#' @export
has_children.DirectedAcyclicGraph <- function(graph, node_id) {
  graph$has_children(node_id)
}
