#' @title Validate if an edge exists
#' @description Returns `TRUE` if the edge exists.
#' @param graph A graph object
#' @param from ID of the `from` node
#' @param to ID of the `to` node
#' @return A logical describing if the edge exists
#' @export
edge_exists <- function(graph, from, to) {
  UseMethod("edge_exists")
}

#' @export
edge_exists.DirectedGraph <- function(graph, from, to) {
  graph$edge_exists(from, to)
}

#' @export
edge_exists.DirectedAcyclicGraph <- function(graph, from, to) {
  graph$edge_exists(from, to)
}
