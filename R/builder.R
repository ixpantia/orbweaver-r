#' @title A new builder for a graph based on the type
#' @description Object used to build graphs
#' @param type The type of graph
#' @return An object of class 'DirectedGraphBuilder'.
#' @export
#' @family build graphs
#' @examples
#' graph_builder()
graph_builder <- function(type = c("directed")) {
  switch(
    rlang::arg_match(type),
    "directed" = DirectedGraphBuilder$new()
  )
}

#' @title Add an edge to a graph builder
#'
#' @description
#' Adds an edge from one node to another in a
#' a directed graph builder.
#'
#' @param graph_builder A graph builder_object
#' @param from The `from` node.
#' @param to The `to` node.
#' @return The updated graph builder object
#' @export
#' @family build graphs
#' @examples
#' graph_builder() |>
#'   add_edge("A", "B")
add_edge <- function(graph_builder, from, to) {
  throw_if_error(graph_builder$add_edge(from, to))
  return(graph_builder)
}

#' @title Add a path to a graph
#'
#' @description
#' Adds all of the edges that make up the given
#' path to the graph.
#'
#' @param graph_builder A graph builder_object
#' @param path A character vector that describes the path
#' @return The updated graph builder object
#' @export
#' @family build graphs
#' @examples
#' graph_builder() |>
#'   add_path(c("A", "B", "C"))
add_path <- function(graph_builder, path) {
  throw_if_error(graph_builder$add_path(path))
  return(graph_builder)
}

#' @title Build a DirectedGraph from a builder
#' @title Builder into a Directed Graph

#' @description
#' Builds a graph builder into a new DirectedGraph
#' object.
#'
#' NOTE: This will consume the builder. It will leave an empty
#' builder in its place.
#' @param graph_builder A graph builder object
#' @return A DirectedGraph Object
#' @export
#' @family build graphs
#' @examples
#' graph_builder() |>
#'   add_path(c("1", "2", "3", "4")) |>
#'   build_directed()
build_directed <- function(graph_builder) {
  throw_if_error(graph_builder$build_directed())
}

#' @title Build a DirectedAcyclicGraph from a builder
#' @description
#' Builds a graph builder into a new DirectedAcyclicGraph
#' object.
#'
#' NOTE: This will consume the builder. It will leave an empty
#' builder in its place.
#' @param graph_builder A graph builder object
#' @return A DirectedAcyclicGraph Object
#' @export
#' @family build graphs
#' @examples
#' graph_builder() |>
#'   add_path(c("1", "2", "3", "4")) |>
#'   build_acyclic()
build_acyclic <- function(graph_builder) {
  throw_if_error(graph_builder$build_acyclic())
}

#' @title Populates the edges of a graph from a `data.frame`
#' @description Adds a set of edges from a `data.frame` to a graph
#' @param graph_builder A graph builder object
#' @param edges_df A `data.frame` with a parent and child variable
#' @param parent_col The name of the column containing the parents
#' @param child_col The name of the column containing the children
#' @return The updated graph builder object
#' @export
#' @family build graphs
#' @examples
#' graph_edges <- data.frame(
#'   parent = c("A", "B", "C"),
#'   child = c("B", "C", "D")
#' )
#'
#' graph_builder() |>
#'   populate_edges(
#'     edges_df = graph_edges,
#'     parent_col = "parent",
#'     child_col = "child"
#'   )
populate_edges <- function(graph_builder, edges_df, parent_col, child_col) {
  parent_col <- as.character(rlang::ensym(parent_col))
  child_col <- as.character(rlang::ensym(child_col))
  parent_iter <- edges_df[[parent_col]]
  if (!is.character(parent_iter)) {
    rlang::abort(glue::glue("Column {parent_col} is not of class `character`"))
  }

  child_iter <- edges_df[[child_col]]
  if (!is.character(child_iter)) {
    rlang::abort(glue::glue("Column {child_col} is not of class `character`"))
  }

  throw_if_error(
    rs_populate_edges_builder(graph_builder, parent_iter, child_iter)
  )
  return(graph_builder)
}
