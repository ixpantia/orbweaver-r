#' @title Remove all edges from a graph
#'
#' @description
#' Removes all edges from a graph in-place.
#'
#' NOTE: Not all graphs are able to be modified.
#'
#' @param graph A graph object
#' @return The updated graph object
#' @export
clear_edges <- function(graph) {
  UseMethod("clear_edges")
}

#' @export
clear_edges.DirectedGraph <- function(graph) {
  graph$clear_edges()
}

#' @export
clear_edges.DirectedAcyclicGraph <- function(graph) {
  rlang::abort(err_unable_to_modify_dag)
}
