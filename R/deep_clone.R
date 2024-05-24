#' @title Get a deep clone of a graph
#'
#' @description
#' Creates a new copy of a graph.
#' @param graph A graph object
#' @return A new deep copy of the graph
#' @export
deep_clone <- function(graph) {
  UseMethod("deep_clone")
}

#' @export
deep_clone.DirectedGraph <- function(graph) {
  graph$deep_clone()
}

#' @export
deep_clone.DirectedAcyclicGraph <- function(graph) {
  graph$deep_clone()
}
