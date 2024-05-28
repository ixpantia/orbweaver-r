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
#'
#' If no `node_ids` argument is supplied then all of
#' the nodes in the graph a returned in a list.
#' @param graph A graph object
#' @param node_ids The unique ids of the nodes to be retrieved
#' @return A list of node objects
#' @export
get_nodes <- function(graph, node_ids) {
  UseMethod("get_nodes")
}

#' @export
get_nodes.DirectedGraph <- function(graph, node_ids) {
  if (missing(node_ids)) {
    return(graph$nodes())
  }
  graph$get_nodes(node_ids)
}

#' @export
get_nodes.DirectedAcyclicGraph <- function(graph, node_ids) {
  if (missing(node_ids)) {
    return(graph$nodes())
  }
  graph$get_nodes(node_ids)
}

#' @title Get the ids of a group of nodes from a graph object
#'
#' @description
#' Retrieves a character vector with the ids of nodes
#' in a graph
#'
#' @param graph A graph object
#' @return A character vector containing the node ids
#' @export
get_node_ids <- function(graph) {
  UseMethod("get_node_ids")
}

#' @export
get_node_ids.DirectedGraph <- function(graph) {
  return(graph$node_ids())
}

#' @export
get_node_ids.DirectedAcyclicGraph <- function(graph) {
  return(graph$node_ids())
}


#' @title Update the data of a node
#' @description Updates the data of a node in-place
#' @param node The node to set the data into
#' @param data An arbitrary R object
#' @return The updated node object
#' @export
update_node_data <- function(graph, node_id, data) {
  UseMethod("update_node_data")
}

#' @export
update_node_data.DirectedGraph <- function(graph, node_id, data) {
  graph$update_node_data(node_id, data)
}

#' @export
update_node_data.DirectedAcyclicGraph <- function(graph, node_id, data) {
  graph$update_node_data(node_id, data)
}
