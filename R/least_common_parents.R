#' @title Find the least common parents in a graph
#' @description
#' It finds the nodes that have no parents in the given
#' set.
#' @param graph A graph object
#' @param selected A character vector of node ids
#' @return A character vector of node ids
#' @export
least_common_parents <- function(graph, selected) {
  UseMethod("least_common_parents")
}

#' @export
least_common_parents.DirectedGraph <- function(graph, selected) {
  graph$least_common_parents(selected)
}

#' @export
least_common_parents.DirectedAcyclicGraph <- function(graph, selected) {
  graph$least_common_parents(selected)
}
