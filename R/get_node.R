#' @title Get the node from a graph object
#'
#' @description
#' Retrives the a specific node from a graph with
#' its data.
#' @param graph A graph object
#' @param node_id The unique id of the node to be retrieved
#' @return A node object
#' @export
get_node <- function(graph, node_id) {
  UseMethod("get_node")
}

#' @export
get_node.DirectedGraph <- function(graph, node_id) {
  graph$get_node(node_id)
}

#' @export
get_node.DirectedAcyclicGraph <- function(graph, node_id) {
  graph$get_node(node_id)
}

#' @title Get a group of nodes from a graph object
#'
#' @description
#' Retrieves a list of nodes with their data from
#' a graph object.
#' @param graph A graph object
#' @param node_ids The unique ids of the nodes to be retrieved
#' @return A list of node objects
#' @export
get_nodes <- function(graph, node_ids) {
  UseMethod("get_nodes")
}

#' @export
get_nodes.DirectedGraph <- function(graph, node_ids) {
  graph$get_nodes(node_ids)
}

#' @export
get_node.DirectedAcyclicGraph <- function(graph, node_ids) {
  graph$get_nodes(node_ids)
}
