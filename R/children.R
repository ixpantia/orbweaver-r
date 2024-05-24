#' @title Get the children on a node
#'
#' @description
#' Get a list of the node ids of the children of
#' the provided node.
#' @param graph A graph object
#' @param node_id The id of the node
#' @return A character vector
#' @export
get_children <- function(graph, node_id) {
  UseMethod("get_children")
}

#' @export
get_children.DirectedGraph <- function(graph, node_id) {
  graph$children(node_id)
}

#' @export
get_children.DirectedAcyclicGraph <- function(graph, node_id) {
  graph$children(node_id)
}
