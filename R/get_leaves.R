#' @title Get the leaf nodes of a graph under some nodes
#'
#' @description
#' Retrieves the nodes in a graph that have no children
#' under a certain node or group of nodes
#'
#' @param graph A graph object
#' @param nodes A character vector of nodes to find leaves for
#' @return A character vector of nodes
#' @export
#' @family analyze graphs
#' @examples
#' graph <- graph_builder() |>
#'   add_path(c("A", "B", "C")) |>
#'   add_path(c("A", "D", "C")) |>
#'   add_path(c("Z", "B", "C")) |>
#'   add_path(c("Z", "B", "H")) |>
#'   build_directed()
#'
#' get_leaves_under(graph, "D")
get_leaves_under <- function(graph, nodes) {
  UseMethod("get_leaves_under")
}

#' @export
get_leaves_under.DirectedGraph <- function(graph, nodes) {
  throw_if_error(graph$get_leaves_under(nodes))
}

#' @export
get_leaves_under.DirectedAcyclicGraph <- function(graph, nodes) {
  throw_if_error(graph$get_leaves_under(nodes))
}

#' @title Get all the leaf nodes of a graph
#'
#' @description
#' Retrieves the nodes in a graph that have no children
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
#'   add_path(c("Z", "B", "H")) |>
#'   build_directed()
#'
#' get_all_leaves(graph)
get_all_leaves <- function(graph, ...) {
  UseMethod("get_all_leaves")
}

#' @export
get_all_leaves.DirectedGraph <- function(graph, ...) {
  graph$get_all_leaves()
}

#' @export
get_all_leaves.DirectedAcyclicGraph <- function(graph, ...) {
  graph$get_all_leaves()
}
