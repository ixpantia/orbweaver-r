#' @title Remove an edge from a graph
#'
#' @description
#' Removes an edge from the graph in-place.
#'
#' NOTE: Not all graphs are able to be modified.
#'
#' @param graph A graph object
#' @param from The `from` node id of the edge to be removed
#' @param to The `to` node id of the edge to be removed
#' @return The updated graph object
#' @export
remove_edge <- function(graph, from, to) {
  UseMethod("remove_edge")
}

#' @export
remove_edge.DirectedGraph <- function(graph, from, to) {
  graph$remove_edge(from, to)
}

#' @export
remove_edge.DirectedAcyclicGraph <- function(graph, from, to) {
  rlang::abort(err_unable_to_modify_dag)
}
