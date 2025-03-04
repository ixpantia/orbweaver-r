#' @title Get the root nodes of a graph over some nodes
#'
#' @description
#' Retrieves the nodes in a graph that have no parents
#' over a certain node or group of nodes
#'
#' @param graph A graph object
#' @param nodes A character vector of nodes to find roots for
#' @return A character vector of nodes
#' @export
#' @family analyze graphs
#' @examples
#' graph <- graph_builder() |>
#'   add_path(c("A", "B", "C")) |>
#'   add_path(c("A", "D", "C")) |>
#'   add_path(c("Z", "B", "C")) |>
#'   build_directed()
#'
#' get_roots_over(graph, "D")
get_roots_over <- function(graph, nodes) {
  UseMethod("get_roots_over")
}

#' @export
get_roots_over.DirectedGraph <- function(graph, nodes) {
  throw_if_error(graph$get_roots_over(nodes))
}

#' @export
get_roots_over.DirectedAcyclicGraph <- function(graph, nodes) {
  throw_if_error(graph$get_roots_over(nodes))
}

#' @title Get the all the root nodes of a graph
#'
#' @description
#' Retrieves the nodes in a graph that have no parents
#'
#' @param graph A graph object
#' @param ... Unused
#' @return A character vector of nodes
#' @export
#' @family analyze graphs
#' @examples
#' graph <- graph_builder() |>
#'   add_path(c("A", "B", "C")) |>
#'   add_path(c("A", "D", "C")) |>
#'   add_path(c("Z", "B", "C")) |>
#'   build_directed()
#'
#' get_all_roots(graph)
get_all_roots <- function(graph, ...) {
  UseMethod("get_all_roots")
}

#' @export
get_all_roots.DirectedGraph <- function(graph, ...) {
  throw_if_error(graph$get_all_roots())
}

#' @export
get_all_roots.DirectedAcyclicGraph <- function(graph, ...) {
  throw_if_error(graph$get_all_roots())
}
