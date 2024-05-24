#' @title Convert a Directed Graph into a Directed Acyclic Graph
#'
#' @description
#' Validates and converts a Directed Graph into an Acyclic Directed Graph
#' applying a topological sort.
#' @param directed_graph A Directed Graph object
#' @return A new DirectedAcyclicGraph object
#' @export
into_dag <- function(directed_graph) {
  UseMethod("into_dag")
}

#' @export
into_dag.DirectedGraph <- function(directed_graph) {
  directed_graph$into_dag()
}

#' @export
into_dag.DirectedAcyclicGraph <- function(directed_graph) {
  rlang::abort("This graph is already an DirectedAcyclicGraph")
}

#' @title Convert an Directed Acyclic Graph into a Directed Graph
#'
#' @description
#' Transforms a DirectedAcyclicGraph object into a DirectedGraph object.
#'
#' This is useful because the structure of a DirectedAcyclicGraph is
#' immutable. In order to modify the nodes or edges of a
#' DirectedAcyclicGraph requires converting it to a DirectedGraph first.
#' @param directed_acyclic_graph A Directed Acyclic Graph object
#' @return A new DirectedGraph object
#' @export
into_directed <- function(directed_acyclic_graph) {
  UseMethod("into_directed")
}

#' @export
into_directed.DirectedGraph <- function(directed_acyclic_graph) {
  rlang::abort("This graph is already a DirectedGraph")
}

#' @export
into_directed.DirectedAcyclicGraph <- function(directed_acyclic_graph) {
  directed_acyclic_graph$into_directed()
}
