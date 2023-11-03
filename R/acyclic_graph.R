#' @title Acyclic Graph
#'
#' @description
#' Creates a new acyclic graph. An acyclic graph is a directed graph with no
#' cycles.
#' @export
new_acyclic_graph <- function() {
  AcyclicGraph$new()
}

#' @title Add Node
#'
#' @description
#' Adds a node to the graph. If the node already exists, nothing happens.
#'
#' **Note**: This function modifies the graph in place. It does not return a
#' new graph. This is done for performance and memory reasons. It works in a
#' similar way to the `data.table` package.
#' @param graph The graph to add the node to.
#' @param node The ID of the node to add.
#' @return The graph.
#' @export
add_node <- function(graph, node) {
  graph$add_node(node)
  return(invisible(graph))
}

#' @title Add Child
#' @description
#' Adds a child to a node. If the child already exists, nothing happens.
#'
#' If the parent or the child do not exist, they are created.
#'
#' **Note**: This function modifies the graph in place. It does not return a
#' new graph. This is done for performance and memory reasons. It works in a
#' similar way to the `data.table` package.
#' @param graph The graph to add the child to.
#' @param parent The ID of the parent node.
#' @param child The ID of the child node.
#' @return The graph.
#' @export
add_child <- function(graph, parent, child) {
  graph$add_child(parent, child)
  return(invisible(graph))
}

#' @title Get Parents
#'
#' @description
#' Gets the parents of a node.
#' @param graph The graph to get the parents from.
#' @param node The ID of the node to get the parents of.
#' @return A character vector of the parents of the node.
#' @export
get_parents <- function(graph, node) {
  graph$get_parents(node)
}

#' @title Get Children
#'
#' @description
#' Gets the children of a node.
#' @param graph The graph to get the children from.
#' @param node The ID of the node to get the children of.
#' @return A character vector of the children of the node.
#' @export
get_children <- function(graph, node) {
  graph$get_children(node)
}

#' @title Get Leaves / Máximum Depth
#'
#' @description
#' Gets the leaves of the graph that descend from a node.
#' @param graph The graph to get the leaves from.
#' @param node The ID of the node to get the leaves of.
#' @return A character vector of the leaves of the node.
#' @export
find_leaves <- function(graph, node) {
  graph$find_leaves(node)
}

#' @title Get Least Common Parents
#'
#' @description
#' Gets the least common parents of a set of nodes.
#' This is the set of parents that are parents of all the nodes and that have
#' been selected.
#'
#' This is useful for example if you want to group by the set of parents of a
#' set of nodes.
#' @param graph The graph to get the least common parents from.
#' @param nodes The nodes to get the least common parents of.
#' @return A character vector of the least common parents of the nodes.
#' @export
find_least_common_parents <- function(graph, nodes) {
  graph$find_least_common_parents(nodes)
}

#' @title Convert to List
#'
#' @description
#' Converts the graph to a list.
#' @param graph The graph to convert to a list.
#' @param ... Ignored.
#' @return A list representation of the graph.
#' @export
as.list.AcyclicGraph <- function(x, ...) {
  x$as_list()
}

#' @title Find roots
#'
#' @description
#' Gets the roots of the graph.
#' @param graph The graph to get the roots from.
#' @return A character vector of the roots of the graph.
#' @export
find_roots <- function(graph) {
  graph$find_roots()
}

#' @title From data.frame
#'
#' @description
#' Creates a graph from a data.frame.
#'
#' The data.frame must have two columns, one for the parent and one for the
#' child.
#'
#' @param df The data.frame to create the graph from. It must have two columns,
#' `parent` and `child`.
#' @return A new graph.
#' @export
acyclic_graph_from_df <- function(df) {
  graph <- AcyclicGraph$from_df(df)
  return(graph)
}
