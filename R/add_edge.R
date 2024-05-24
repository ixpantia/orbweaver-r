#' @title Add an edge to a graph
#'
#' @description
#' Adds an edge from one node to another in a
#' a directed graph.
#'
#' NOTE: Not all graphs are able to be modified.
#'
#' @param graph A graph object
#' @param from The id of the `from` node.
#' @param to The id of the `to` node.
#' @return The updated graph object
#' @export
add_edge <- function(graph, from, to) {
  UseMethod("add_edge")
}

#' @export
add_edge.DirectedGraph <- function(graph, from, to) {
  graph$add_edge(from, to)
  return(graph)
}

#' @export
add_edge.DirectedAcyclicGraph <- function(graph, from, to) {
  rlang::abort(err_unable_to_modify_dag)
}
