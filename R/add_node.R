#' @title Add a new node to a graph
#'
#' @description
#' Appends a new node to the graph in-place with
#' some arbitrary data.
#'
#' NOTE: Not all graphs are able to be modified.
#'
#' @param graph A graph object
#' @param node_id The unique id of the node to be added
#' @param data R object to be used as the data for the node
#' @return The updated graph object
#' @export
add_node <- function(graph, node_id, data = NULL) {
  UseMethod("add_node")
}

#' @export
add_node.DirectedGraph <- function(graph, node_id, data) {
  graph$add_node(node_id, data)
  return(graph)
}

#' @export
add_node.DirectedAcyclicGraph <- function(graph, node_id, data) {
  rlang::abort(
    c(
      "You may not modify an DAG.",
      "Convert it to a Directed Graph first"
    )
  )
}
