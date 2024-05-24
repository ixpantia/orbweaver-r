#' @title Get the root nodes of a graph
#'
#' @description
#' Retrieves the nodes in a graph that have no parents
#'
#' If no `node_ids` argument is supplied then all of
#' the roots in the graph are returned.
#' @param graph A graph object
#' @param node_ids The node ids of which the roots must be descendants of
#' @return A character vector of node ids
#' @export
get_roots <- function(graph, node_ids) {
  UseMethod("get_roots")
}

#' @export
get_roots.DirectedGraph <- function(graph, node_ids) {
  if (missing(node_ids)) {
    return(graph$get_roots())
  }
  graph$get_roots_over(node_ids)
}

#' @export
get_node.DirectedAcyclicGraph <- function(graph, node_ids) {
  if (missing(node_ids)) {
    return(graph$get_roots())
  }
  graph$get_roots_over(node_ids)
}
