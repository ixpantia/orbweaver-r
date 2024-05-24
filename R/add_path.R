#' @title Add a path to a graph
#'
#' @description
#' Adds all of the edges that make up the given
#' path to the graph.
#'
#' NOTE: Not all graphs are able to be modified.
#'
#' @param graph A graph object
#' @param path A character vector that describes the path
#' @return The updated graph object
#' @export
add_path <- function(graph, path) {
  UseMethod("add_path")
}

#' @export
add_path.DirectedGraph <- function(graph, path) {
  graph$add_path(path)
  return(graph)
}

#' @export
add_path.DirectedAcyclicGraph <- function(graph, path) {
  rlang::abort(err_unable_to_modify_dag)
}
