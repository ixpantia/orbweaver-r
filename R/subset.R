#' @title Get a subset or a graph
#' @description todo!
#' @param graph A graph object
#' @param node_id The node id from which to split the tree
#' @return A new graph object
#' @export
subset_graph <- function(graph, node_id) {
  UseMethod("subset_graph")
}

#' @export
subset_graph.DirectedGraph <- function(graph, node_id) {
  graph$subset(node_id)
}

#' @export
subset_graph.DirectedAcyclicGraph <- function(graph, node_id) {
  graph$subset(node_id)
}
