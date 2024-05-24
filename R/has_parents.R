#' @title Checks if a node in a graph has parents
#' @description
#' This function validates if any edge points to the
#' given node.
#' @param graph A graph object
#' @param node_id The id of the node to check
#' @return A logical describing if the node has parents
#' @export
has_parents <- function(graph, node_id) {
  UseMethod("has_parents")
}

#' @export
has_parents.DirectedGraph <- function(graph, node_id) {
  graph$has_parents(node_id)
}

#' @export
has_parents.DirectedAcyclicGraph <- function(graph, node_id) {
  graph$has_parents(node_id)
}
