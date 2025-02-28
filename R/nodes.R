#' @title Get the nodes in the graph
#' @description Returns the unique nodes in the graph
#' @param graph A directed or directed acyclic graph
#' @param ... Reserved for later use
#' @return A character vector with the nodes
#' @export
#' @examples
#' graph <- graph_builder() |>
#'   add_edge(from = "A", to = "B") |>
#'   build_directed()
#' graph
#'
#' nodes(graph)
nodes <- function(graph, ...) {
  graph$nodes()
}
