#' @title Find a path between two nodes
#'
#' @description
#' Finds a path between two nodes in a graph.
#'
#' Different types of graphs use different algorithims to
#' find the paths. a `DirectedGraph` uses breadth-first search
#' while an `DirectedAcyclicGraph` uses topological sort.
#'
#' The path is represented as a character vector with the
#' node ids of the nodes that make up the path.
#' @param graph A graph object
#' @param from The starting node of the path
#' @param to The ending node of the path
#' @return A character vector
#' @export
find_path <- function(graph, from, to) {
  UseMethod("find_path")
}

#' @export
find_path.DirectedGraph <- function(graph, from, to) {
  graph$find_path(from, to)
}

#' @export
find_path.DirectedAcyclicGraph <- function(graph, from, to) {
  graph$find_path(from, to)
}

#' @title Find all paths between two nodes
#'
#' @description
#' Find all the paths between two nodes in a graph.
#'
#' Not all graphs support this function. Currently only
#' `DirectedAcyclicGraph` supports this.
#' @param graph A graph object
#' @param from The starting node of the path
#' @param to The ending node of the path
#' @return A list of character vectors
#' @export
find_all_paths <- function(graph, from, to) {
  UseMethod("find_all_paths")
}

#' @export
find_all_paths.DirectedGraph <- function(graph, from, to) {
  rlang::abort("DirectedGraph does not support `find_all_paths`")
}

#' @export
find_all_paths.DirectedAcyclicGraph <- function(graph, from, to) {
  graph$find_all_paths(from, to)
}
