#' @title Find a path between two nodes
#'
#' @description
#' Finds a path between two nodes in a graph.
#'
#' Different types of graphs use different algorithms to
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
#' @family analyze graphs
#' @examples
#' graph <- graph_builder() |>
#'   add_path(c("A", "B", "C")) |>
#'   build_directed()
#'
#' find_path(graph, "A", "C")
find_path <- function(graph, from, to) {
  UseMethod("find_path")
}

#' @export
find_path.DirectedGraph <- function(graph, from, to) {
  throw_if_error(graph$find_path(from, to))
}

#' @export
find_path.DirectedAcyclicGraph <- function(graph, from, to) {
  throw_if_error(graph$find_path(from, to))
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
#' @family analyze graphs
#' @examples
#' graph <- graph_builder() |>
#'   add_path(c("A", "B", "C")) |>
#'   add_path(c("A", "Z", "C")) |>
#'   add_path(c("A", "B", "A")) |>
#'   build_directed()
#'
#' find_all_paths(graph, "A", "C")
find_all_paths <- function(graph, from, to) {
  UseMethod("find_all_paths")
}

#' @export
find_all_paths.DirectedGraph <- function(graph, from, to) {
  throw_if_error(graph$find_all_paths(from, to))
}

#' @export
find_all_paths.DirectedAcyclicGraph <- function(graph, from, to) {
  throw_if_error(graph$find_all_paths(from, to))
}

#' @title Find the a valid path from one node to many
#'
#' @description
#' Find a valid path from one node to many
#'
#' @param graph A graph object
#' @param from The starting node of the path
#' @param to A character vector of nodes
#' @return A list of paths
#' @export
#' @family analyze graphs
#' @examples
#' edges <- data.frame(
#'   parent = c("A", "A", "B", "Z"),
#'   child =  c("B", "Z", "Z", "F")
#' )
#'
#' graph <- graph_builder() |>
#'   populate_edges(edges, parent, child) |>
#'   build_acyclic()
#'
#' find_path_one_to_many(graph, "A", edges$child)
find_path_one_to_many <- function(graph, from, to) {
  UseMethod("find_path_one_to_many")
}

#' @export
find_path_one_to_many.DirectedGraph <- function(graph, from, to) {
  graph$find_path_one_to_many(from, to)
}

#' @export
find_path_one_to_many.DirectedAcyclicGraph <- function(graph, from, to) {
  graph$find_path_one_to_many(from, to)
}
