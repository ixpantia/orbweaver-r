#' @title Get the leave nodes of a graph
#'
#' @description
#' Retrieves the nodes in a graph that have no children.
#'
#' If no `node_ids` argument is supplied then all of
#' the leaves in the graph are returned.
#' @param graph A graph object
#' @param node_ids The node ids of which the leaves must be descendants of
#' @return A character vector of node ids
#' @export
get_leaves <- function(graph, node_ids) {
  UseMethod("get_leaves")
}

#' @export
get_leaves.DirectedGraph <- function(graph, node_ids) {
  if (missing(node_ids)) {
    return(graph$get_leaves())
  }
  graph$get_leaves_under(node_ids)
}

#' @export
get_node.DirectedAcyclicGraph <- function(graph, node_ids) {
  if (missing(node_ids)) {
    return(graph$get_leaves())
  }
  graph$get_leaves_under(node_ids)
}
