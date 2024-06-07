#' @title Get the parents on a node
#'
#' @description
#' Get a list of the node ids of the parents of
#' the provided node.
#' @param graph A graph object
#' @param nodes A character vector of nodes to find parents for
#' @return A character vector
#' @export
parents <- function(graph, nodes) {
  UseMethod("parents")
}

#' @export
parents.DirectedGraph <- function(graph, nodes) {
  graph$parents(nodes)
}

#' @export
parents.DirectedAcyclicGraph <- function(graph, nodes) {
  graph$parents(nodes)
}
