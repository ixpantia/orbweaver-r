#' @title Get the parents on a node
#'
#' @description
#' Get a list of the node ids of the parents of
#' the provided node.
#' @param graph A graph object
#' @param node_id The id of the node
#' @return A character vector
#' @export
get_parents <- function(graph, node_id) {
  UseMethod("get_parents")
}

#' @export
get_parents.DirectedGraph <- function(graph, node_id) {
  graph$parents(node_id)
}

#' @export
get_parents.DirectedAcyclicGraph <- function(graph, node_id) {
  graph$parents(node_id)
}
