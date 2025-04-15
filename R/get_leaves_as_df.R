#' @title Get leaves as a data frame
#'
#' @description
#' Get leaves of a set of nodes in a data frame format.
#'
#' @param graph A graph object
#' @param nodes A character vector of node IDs
#' @return A data frame of leaves
#' @export
get_leaves_as_df <- function(graph, nodes) {
  throw_if_error(graph$get_leaves_as_df(nodes))
}
