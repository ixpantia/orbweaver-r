#' @title Initialize a new graph
#'
#' @description
#' Initializes a new graph with the given type.
#' @param type The type of graph to create. Currently only `acyclic` is
#' supported.
#' @export
new_graph <- function(type) {
  switch(
    type,
    acyclic = AcyclicGraph$new(),
    stop("Unknown graph type")
  )
}

#' @title As graph
#'
#' @description
#' Attempts to convert the object to a graph.
#' @param x The object to convert to a graph.
#' @param type The type of graph to convert to. Currently only `acyclic` is
#' supported.
#' @param ... Additional arguments passed to the method.
#' @return A graph.
#' @export
as_graph <- function(x, type, ...) {
  UseMethod("as_graph")
}

#' @title Data.frame as graph
#'
#' @description
#' Converts a data.frame to a graph.
#' @param x The data.frame to convert to a graph.
#' @param type The type of graph to convert to. Currently only `acyclic` is
#' supported.
#' @param ... Ignored.
#' @return A graph.
#' @export
as_graph.data.frame <- function(x, type, ...) {
  switch(
    type,
    acyclic = AcyclicGraph$from_dataframe(x),
    stop("Unknown graph type")
  )
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

#' @title Get Leaves / Maximum Depth
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

#' @title Get Least Common Parents from an Acyclic Graph
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


#' @title Clone Graph
#'
#' @description
#' Creates a copy of the graph.
#' @param graph The graph to clone.
#' @return A new graph.
#' @export
clone_graph <- function(graph) {
  graph$graph_clone()
}
