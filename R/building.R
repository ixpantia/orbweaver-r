#' @title Populates the edges of a graph from a `tibble`
#' @description Adds a set of edges from a `tibble` to a graph
#' @param graph A graph object
#' @param edges_df A `tibble` with a parent and child variable
#' @param parent_col The name of the column containing the parents
#' @param child_col The name of the column containing the children
#' @return The updated graph object
#' @export
populate_edges <- function(graph, edges_df, parent_col, child_col) {
  UseMethod("populate_edges")
}

#' @export
populate_edges.DirectedGraph <- function(graph, edges_df, parent_col, child_col) {

  parent_iter <- edges_df[[parent_col]]
  if (!is.character(parent_iter)) {
    rlang::abort(glue::glue("Column {parent_col} is not of class `character`"))
  }

  child_iter <- edges_df[[child_col]]
  if (!is.character(child_iter)) {
    rlang::abort(glue::glue("Column {child_col} is not of class `character`"))
  }

  rs_populate_edges_directed_graph(graph, parent_iter, child_iter)
  return(graph)
}

#' @export
populate_edges.DirectedAcyclicGraph <- function(graph, edges_df, parent_col, child_col) {
  rlang::abort(err_unable_to_modify_dag)
}

#' @title Populates the nodes of a graph from a `tibble`
#' @description Adds a set of nodes from a `tibble` to a graph
#' @param graph A graph object
#' @param nodes_df A `tibble` with a node id and data column
#' @param node_id_col The name of the column containing the node ids
#' @param data_col The name of the column containing the data of the nodes
#' @return The updated graph object
#' @export
populate_nodes <- function(graph, nodes_df, node_id_col, data_col = NULL) {
  UseMethod("populate_nodes")
}

#' @export
populate_nodes.DirectedGraph <- function(graph, nodes_df, node_id_col, data_col = NULL) {

  node_ids <- nodes_df[[node_id_col]]
  if (!is.character(node_ids)) {
    rlang::abort(glue::glue("Column {node_id_col} is not of class `character`"))
  }

  data_iter <- NULL

  if (!is.null(data_col)) {
    data_iter <- as.list(nodes_df[[data_col]])
  }

  rs_populate_nodes_directed_graph(graph, node_ids, data_iter)
  return(graph)
}

#' @export
populate_nodes.DirectedAcyclicGraph <- function(graph, nodes_df, node_id_col, data_col = NULL) {
  rlang::abort(err_unable_to_modify_dag)
}
