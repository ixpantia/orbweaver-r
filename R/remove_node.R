#' @title Remove a node from a graph
#'
#' @description
#' Removes a node from the graph in-place.
#'
#' NOTE: Not all graphs are able to be modified.
#'
#' @param graph A graph object
#' @param node_id The id of the node to be removed
#' @return The updated graph object
#' @export
remove_node <- function(graph, node_id) {
  UseMethod("remove_node")
}

#' @export
remove_node.DirectedGraph <- function(graph, node_id) {
  graph$remove_node(node_id)
}

#' @export
remove_node.DirectedAcyclicGraph <- function(graph, node_id) {
  rlang::abort(err_unable_to_modify_dag)
}
